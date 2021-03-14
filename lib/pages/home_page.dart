import 'package:flutter/material.dart';
import 'package:nuovoquizarbitri/utils/constants.dart';
import 'package:nuovoquizarbitri/widget/home_grid.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SelectableText(widget.title),actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, SETTINGS_ROUTE);
          },
        )
      ],),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
          Flexible(flex: 1, child: SelectableText(STR_WELCOME_SENTENCE, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline5,)),
          Flexible(flex: 2, child: Center(child: homeGrid(context))),
        ],
      )
    );
  }
}
