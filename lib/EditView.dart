import 'package:flutter/material.dart';

import './utils.dart';

class EditView extends StatefulWidget {
  final Map<String, Object> card;
  final int index;
  final Function update;
  final Function navigate;

  EditView(this.card, this.index, this.update, this.navigate);

  @override
  _EditViewState createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  var _store = stores[0];
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    this._store = widget.card['store'];
    _nameController = TextEditingController(text: widget.card['name']);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    super.dispose();
  }

  Future<bool> navigateBack() => widget.navigate(widget.index < 0 ? 'grid' : 'card');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: navigateBack,
      child: Scaffold(
      appBar: AppBar(
        title: Text(widget.index < 0 ? 'Novo Cartão' : 'Cartão'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: navigateBack,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
        ],
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
                    widget.card['barcode'] == ''
                        ? 'Código de Barras'
                        : widget.card['barcode'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    tooltip: 'Scanear Código',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            RaisedButton.icon(
              label: Text('Guardar'),
              icon: Icon(Icons.save),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Text(_nameController.text + images[_store]),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    ),
    );
  }
}
