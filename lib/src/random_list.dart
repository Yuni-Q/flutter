import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:my_app/src/saved.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestion = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("name app"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SavedList(saved: _saved)));
            },
          )
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(itemBuilder: (context, index) {
      if (index.isOdd) {
        return Divider();
      }

      var realIndex = index ~/ 2;

      if (realIndex >= _suggestion.length) {
        _suggestion.addAll((generateWordPairs().take(10)));
      }

      return _buidRow(_suggestion[realIndex]);
    });
  }

  Widget _buidRow(WordPair pair) {
    final bool alreaySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(
        alreaySaved ? Icons.favorite : Icons.favorite_border,
        color: Colors.pink,
      ),
      onTap: () {
        setState(() {
          if (alreaySaved) {
            _saved.remove(pair); // true
          } else {
            _saved.add(pair); // false
          }
          print(_saved.toString());
        });
      },
    );
  }
}
