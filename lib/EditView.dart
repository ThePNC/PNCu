import 'package:flutter/material.dart';

class EditView extends StatelessWidget {
  final Map<String, Object> card;
  final Function navigate;

  EditView(this.card, this.navigate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => navigate('card'),
        ),
        title: Text('Cartão'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(50),
            child: Image.asset('assets/${card['image']}.png',),
          ),
          Text(card['name']),
        ],
      ),
    );
  }
}
