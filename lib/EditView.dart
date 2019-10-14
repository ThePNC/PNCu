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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => widget.navigate(widget.index < 0 ? 'grid' : 'card'),
        ),
        title: Text(widget.index < 0 ? 'Novo Cartão' : 'Cartão'),
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
            Container(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 25),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nome",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
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
    );
  }
}
