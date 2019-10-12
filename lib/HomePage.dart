import 'package:flutter/material.dart';

import './CardsGrid.dart';
import './CardView.dart';
import './EditView.dart';
import './CreateView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, Object>> _testCards = [
    {
      'barcode': 1,
      'type': 'abc',
      'name': 'minipreco',
      'image': 'mp',
    },
    {
      'barcode': 2,
      'type': 'bcd',
      'name': 'pingodoce',
      'image': 'pd',
    },
    {
      'barcode': 3,
      'type': 'cdf',
      'name': 'continente',
      'image': 'cont',
    },
    {
      'barcode': 4,
      'type': 'cdf',
      'name': 'loja do thor',
      'image': 'blank',
    },
    {
      'barcode': 5,
      'type': 'cdf',
      'name': 'loja do doc',
      'image': 'blank',
    },
  ];

  var _page = 'grid';
  Map<String, Object> _card;

  void _add() {
    _navigate('create');
  }

  void _open(card) {
    setState(() {
      this._page = 'card';
      this._card = card;
    });
  }

  void _navigate(page) {
    setState(() {
      this._page = page;
    });
  }

  Widget _content() {
    switch (_page) {
      case 'card':
        {
          return CardView(_card, _navigate);
        }
        break;

      case 'edit': {
        return EditView(_card, _navigate);
      }
      break;

      case 'create': {
        return CreateView(_navigate);
      }
      break;

      default:
      // case 'grid'
        {
          return CardsGrid(_testCards, _open, _add);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _content();
  }
}
