import 'package:flutter/material.dart';
import 'package:barcode_flutter/barcode_flutter.dart';

import './utils.dart';

class CardView extends StatelessWidget {
  final Map<String, Object> card;
  final Function navigate;

  CardView(this.card, this.navigate);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => navigate('grid'),
      child: Scaffold(
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
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(50, 50, 50, 25),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image.asset(
                'assets/${images[card['store']]}.png',
              ),
            ),
          ),
          Text(
            card['name'],
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 50),
            child: BarCodeImage(
              data: card['barcode'],
              codeType: BarCodeType.CodeEAN13,
              lineWidth: 2.5,
              barHeight: 90.0,
              hasText: true,
              onError: (error) {
                print('error = $error');
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigate('edit'),
        tooltip: 'Edit',
        child: Icon(Icons.edit),
      ),
    ),
    );
  }
}
