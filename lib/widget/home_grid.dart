import 'package:flutter/material.dart';
import 'package:nuovoquizarbitri/utils/constants.dart';

Widget homeGrid (BuildContext context){
  return GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    children: <Widget>[
      homeGridElement(context, STR_QUIZ, PTH_LOGO_QUIZ, QUIZ_ROUTE),
      homeGridElement(context, STR_TRUE_OR_FALSE, PTH_LOGO_TRUE_OR_FALSE, TRUE_FALSE_ROUTE),
    ],
  );
}

Widget homeGridElement (BuildContext context, String elementName, String assetImage, String namedRoute, {List<Object> arguments}){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      child: Card(
        child: Column(
          children: [
            Flexible(flex: 1, child: Center(child: Padding(padding: EdgeInsets.all(8.0),child: Image.asset(assetImage)))),
            Flexible(flex: 0, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(elementName),
            ))
          ],
        ),
        elevation: 18.0,
        clipBehavior: Clip.antiAlias,
      ),
      onTap: () => namedRoute != null ? Navigator.pushNamed(context, namedRoute, arguments: arguments) : Navigator.pushNamed(context, namedRoute),
    ),
  );
}

