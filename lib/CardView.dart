import 'package:flutter/material.dart';

import './utils.dart';

class CardView extends StatelessWidget {
  final Map<String, Object> card;
  final Function navigate;

  CardView(this.card, this.navigate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => navigate('grid'),
        ),
        title: Text('Cartão'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(50),
            child: Image.asset('assets/${images[card['store']]}.png',),
          ),
          Text(card['name']),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigate('edit'),
        tooltip: 'Edit',
        child: Icon(Icons.edit),
      ),
    );
  }
}
