import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';

import './utils.dart';

class EditView extends StatefulWidget {
  final Map<String, Object> card;
  final int index;
  final Function update;
  final Function delete;
  final Function navigate;

  EditView(this.card, this.index, this.update, this.delete, this.navigate);

  @override
  _EditViewState createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  var _store = stores[0];
  TextEditingController _nameController;
  var _barcode = '';

  @override
  void initState() {
    super.initState();
    this._store = widget.card['store'];
    _nameController = TextEditingController(text: widget.card['name']);
    this._barcode = widget.card['barcode'];
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    super.dispose();
  }

  Future<bool> _navigateBack() =>
      widget.navigate(widget.index > -1 ? 'card' : 'grid');

  Future _submitSave() async {
    if (_nameController.text != '') {
      widget.update({
        'store': _store,
        'name': _nameController.text,
        'barcode': _barcode,
      }, widget.index);
      widget.navigate('grid');
    } else {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Por favor, preencha todos os campos.'),
          );
        },
      );
    }
  }

  Future _submitDelete() async {
    return showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Apagar Cartão?'),
          content: const Text('Esta acção não é irreversível.'),
          actions: [
            FlatButton(
              child: const Text('Confirmar'),
              onPressed: () {
                Navigator.pop(context);
                widget.delete(widget.index);
                widget.navigate('grid');
              },
            )
          ],
        );
      },
    );
  }

  Future _scan() async {
    try {
      String result = await BarcodeScanner.scan();
      setState(() {
        _barcode = result;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          _barcode = "Sem acesso a Câmara.";
        });
      } else {
        setState(() {
          _barcode = "Unknown Error $ex";
        });
      }
    } catch (ex) {
      setState(() {
        _barcode = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _navigateBack,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.index > -1 ? 'Cartão' : 'Novo Cartão'),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: _navigateBack,
          ),
          actions: widget.index > -1
              ? [
                  IconButton(
                    icon: Icon(Icons.delete_forever),
                    onPressed: _submitDelete,
                  ),
                ]
              : [],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(50, 50, 50, 25),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Image.asset(
                    'assets/${images[_store]}.png',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Loja:'),
                    DropdownButton(
                      value: _store,
                      items: stores.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (v) {
                        setState(() {
                          this._store = v;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Nome",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _barcode == '' ? 'Código de Barras' : _barcode,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      tooltip: 'Scan',
                      onPressed: _scan,
                    ),
                  ],
                ),
              ),
              RaisedButton.icon(
                label: Text('Guardar'),
                icon: Icon(Icons.save),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: _submitSave,
              )
            ],
          ),
        ),
      ),
    );
  }
}
