import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './CardsGrid.dart';
import './CardView.dart';
import './EditView.dart';

// Cards are stored in shared preferences https://flutter.dev/docs/cookbook/persistence/key-value
// Following the structure: key 'barcode': value string list [<store>, <name>]
// This data gets mapped, onLoad, to an Object with the proper keys matching the values

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _emptyCard = const {
    'store': 'Outra',
    'name': '',
    'barcode': '',
  };

  List<Map<String, Object>> _cards = [];

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  _loadCards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, Object>> cs = [];

    prefs.clear(); //REMOVE IN PRODUCTION
    prefs.setStringList('2803342249544', [
      'Minipreço',
      'minipreco',
    ]);
    prefs.setStringList('1850341840143', [
      'Continente',
      'continente',
    ]);

    void loadCard(key) {
      var c = prefs.getStringList(key);
      cs.add({
        'store': c[0],
        'name': c[1],
        'barcode': key,
      });
    }

    prefs.getKeys().forEach((k) => loadCard(k));

    setState(() {
      _cards = cs;
    });
  }

  _saveCard(card) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList(card['barcode'], [card['store'], card['name']]);
  }

  _removeCard(barcode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(barcode);
  }


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
    _saveCard(card);

    var newCards = [...this._cards];
    if (index > -1) {
      newCards[index] = card;
    } else {
      newCards.add(card);
    }
    setState(() {
      this._cards = newCards;
    });
  }

  void _deleteCard(index) {
    var barcode = this._cards[index]['barcode'];

    _removeCard(barcode);

    var newCards = [...this._cards];
    newCards.removeWhere((c) => c['barcode'] == barcode);
    setState(() {
      this._cards = newCards;
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
          return EditView(_card, _cardIndex, _updateCards, _deleteCard, _navigate);
        }
        break;

      case 'create':
        {
          return EditView(_emptyCard, -1, _updateCards, _deleteCard, _navigate);
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
