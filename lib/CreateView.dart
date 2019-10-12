import 'package:flutter/material.dart';

class CreateView extends StatelessWidget {
  final Function navigate;

  CreateView(this.navigate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => navigate('grid'),
        ),
        title: Text('Cartão'),
      ),
      body: Column(
        children: [
          Text('New Card'),
        ],
      ),
    );
  }
}
