import 'package:flutter/material.dart';

class CardsGrid extends StatelessWidget {
  final List<Map<String, Object>> cards;
  final Function open;
  final Function add;

  CardsGrid(this.cards, this.open, this.add);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Cartões'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: cards.map((card) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: FlatButton(
              onPressed: () => open(card),
              padding: EdgeInsets.all(0.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/${card['image']}.png'),
                    Text(card['name'])
                  ]),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        tooltip: 'Criar',
        child: Icon(Icons.add),
      ),
    );
  }
}
