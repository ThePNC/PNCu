import 'package:flutter/material.dart';

import './CardsGrid.dart';
import './CardView.dart';
import './EditView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _emptyCard = const {
    'barcode': -1,
    'type': '',
    'name': '',
    'store': 'Outra',
  };

  List<Map<String, Object>> _cards = [
    {
      'barcode': 1,
      'type': 'abc',
      'name': 'minipreco',
      'store': 'Minipreço',
    },
    {
      'barcode': 2,
      'type': 'bcd',
      'name': 'pingodoce',
      'store': 'Pingo Doce',
    },
    {
      'barcode': 3,
      'type': 'cdf',
      'name': 'continente',
      'store': 'Continente',
    },
    {
      'barcode': 4,
      'type': 'cdf',
      'name': 'loja do thor',
      'store': 'Outra',
    },
    {
      'barcode': 5,
      'type': 'cdf',
      'name': 'loja do doc',
      'store': 'Outra',
    },
  ];

  var _page = 'grid';
  Map<String, Object> _card;
  int _cardIndex;

  void _navigate(page) {
    setState(() {
      this._page = page;
    });
  }

  void _open(card, index) {
    setState(() {
      this._page = 'card';
      this._card = card;
      this._cardIndex = index;
    });
  }

  void _updateCards(card, index) {
    setState(() {
      this._cards[index] = card;
    });
  }

  Widget _content() {
    switch (_page) {
      case 'card':
        {
          return CardView(_card, _navigate);
        }
        break;

      case 'edit':
        {
          return EditView(_card, _cardIndex, _updateCards, _navigate);
        }
        break;

      case 'create':
        {
          return EditView(_emptyCard, -1, _updateCards, _navigate);
        }
        break;

      default:
        // case 'grid'
        {
          return CardsGrid(_cards, _open, () => _navigate('create'));
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _content();
  }
}
