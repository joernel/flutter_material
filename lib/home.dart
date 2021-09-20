import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  List<Card> _buildGridCards(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());
    final Random random = Random();
    List<Card> cards = List.generate(
        50,
        (int index) => Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 18.0 / 11.0,
                  child: Image.network(
                      'https://picsum.photos/id/${index}/200/100',
                      fit: BoxFit.fitWidth),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<Map>(
                          future: fetchUser(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!['name'] ?? 'null',
                                style: theme.textTheme.headline6,
                                maxLines: 1,
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }

                            return const CircularProgressIndicator();
                          }),
                      SizedBox(height: 8.0),
                      Text(
                        formatter.format(random.nextDouble()),
                        style: theme.textTheme.subtitle2,
                      )
                    ],
                  ),
                )
              ],
            )));
    return cards;
  }

  Future<Map> fetchUser() async {
    var val = await http.get(Uri.parse('https://api.namefake.com/'));
    return jsonDecode(val.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('Menu Button');
          },
        ),
        title: Text('SHRINE'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, semanticLabel: 'search'),
            onPressed: () {
              print('search');
            },
          ),
          IconButton(
            icon: Icon(Icons.tune, semanticLabel: 'filter'),
            onPressed: () {
              print('filter');
            },
          )
        ],
      ),
      body: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0,
          children: _buildGridCards(context)),
      resizeToAvoidBottomInset: false,
    );
  }
}
