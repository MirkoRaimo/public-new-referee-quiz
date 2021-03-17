import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:nuovoquizarbitri/redux/app/app_state.dart';
import 'package:nuovoquizarbitri/redux/models/question.dart';
import 'package:nuovoquizarbitri/redux/questionsList/questions_list_actions.dart';
import 'package:nuovoquizarbitri/redux/questionsList/questions_list_state.dart';
import 'package:nuovoquizarbitri/redux/store.dart';
import 'package:nuovoquizarbitri/utils/constants.dart';
import 'package:nuovoquizarbitri/widget/recap_answers_list.dart';
import 'package:redux/redux.dart';

class TrueFalsePage extends StatefulWidget {
  TrueFalsePage({Key key}) : super(key: key);
  final String title = APP_NAME;

  @override
  _TrueFalsePageState createState() => _TrueFalsePageState();
}

class _TrueFalsePageState extends State<TrueFalsePage>
    with TickerProviderStateMixin {
  List<Card> listOfCards;
  final Store<AppState> store = createStore();
  CardController controller = CardController();

  @override
  void initState() {
    super.initState();
    store.dispatch(GenerateTrueFalseQuestions());
    listOfCards =
        _generateListOfCards(store.state.questionsListState.questionsList);
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: Scaffold(
            appBar: AppBar(
              title: SelectableText(widget.title),
            ),
            body: _buildBody(context),
            floatingActionButton: _buildRowFab()));
  }

  Column _buildBody(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      StoreConnector<AppState, QuestionsListState>(
          distinct: true, //to improve the performances
          converter: (store) => store.state.questionsListState,
          builder: (BuildContext context, QuestionsListState userState) {
            return SizedBox(
              //height: !store.state.questionsListState.answeredLastQuestion ? MediaQuery.of(context).size.height * 0.08 : 0,
              height: MediaQuery.of(context).size.height *
                  (!store.state.questionsListState.answeredLastQuestion
                      ? 0.08
                      : 0.02),
            );
          }),
      SelectableText(
        "$STR_TRUE_OR_FALSE?",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
      StoreConnector<AppState, QuestionsListState>(
          distinct: true, //to improve the performances
          converter: (store) => store.state.questionsListState,
          builder: (BuildContext context, QuestionsListState userState) {
            return !store.state.questionsListState.answeredLastQuestion
                ? _createCustomCards(context)
                : Flexible(
                    flex: 2,
                    child:
                        recapAnswers(context, store.state.questionsListState));
          }),
    ]);
  }

  StoreConnector<AppState, QuestionsListState> _buildRowFab() {
    return StoreConnector<AppState, QuestionsListState>(
        converter: (store) => store.state.questionsListState,
        builder: (BuildContext context, QuestionsListState userState) {
          return !store.state.questionsListState.answeredLastQuestion
              ? _rowFabRaisedButtons()
              : Container();
        });
  }

  Container _createCustomCards(BuildContext context) {
    final double _containerCardHeight =
        MediaQuery.of(context).size.height * 0.6;

    return Container(
        height: _containerCardHeight,
        child: Builder(builder: (BuildContext innerContext) {
          final double _cardMaxWidth = MediaQuery.of(context).size.width * 0.9;
          final double _cardMaxHeight = MediaQuery.of(context).size.width * 0.9;
          final double _cardMinWidth = MediaQuery.of(context).size.width * 0.8;
          final double _cardMinHeight = MediaQuery.of(context).size.width * 0.6;

          return _tinderSwapCard(_cardMaxWidth, _cardMaxHeight, _cardMinWidth,
              _cardMinHeight, innerContext);
        }));
  }

  TinderSwapCard _tinderSwapCard(double _cardMaxWidth, double _cardMaxHeight,
      double _cardMinWidth, double _cardMinHeight, BuildContext innerContext) {
    return TinderSwapCard(
        swipeUp: false,
        swipeDown: false,
        orientation: AmassOrientation.BOTTOM,
        totalNum: listOfCards.length,
        stackNum: 3,
        swipeEdge: 4.0,
        maxWidth: _cardMaxWidth,
        maxHeight: _cardMaxHeight,
        minWidth: _cardMinWidth,
        minHeight: _cardMinHeight,
        cardBuilder: (context, index) {
          return listOfCards[index];
        },
        cardController: controller,
        swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
          /// Get swiping card's alignment
          if (align.x < 0) {
            //Card is LEFT swiping

          } else if (align.x > 0) {
            //Card is RIGHT swiping
          }
        },
        swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
          // Get orientation & index of swiped card!
          int givenAnswer;
          if (orientation != CardSwipeOrientation.RECOVER) {
            switch (orientation) {
              case CardSwipeOrientation.LEFT:
                givenAnswer = Question.FALSE;
                break;
              case CardSwipeOrientation.RIGHT:
                givenAnswer = Question.TRUE;
                break;

              case CardSwipeOrientation.UP:
                break;
              case CardSwipeOrientation.DOWN:
                break;
              case CardSwipeOrientation.RECOVER:
                break;
            }
            store.dispatch(SetQuestionsListContext(context: innerContext));
            store.dispatch(AnswerQuestion(
                currentQuestion: index, givenAnswer: givenAnswer));
          }
        });
  }

  static List<Card> _generateListOfCards(List<Question> listOfQuestions) {
    List<Card> listOfCards = [];
    if (listOfQuestions != null && listOfQuestions.isNotEmpty)
      for (int i = 0; i < listOfQuestions.length; i++) {
        Card card = new Card(
            color: Colors.primaries[Random().nextInt(Colors.accents.length)],
            child: Center(
                child: Text(
              listOfQuestions[i].questionStatement,
              //style: Theme.of(context).textTheme.headline5,
            )));
        listOfCards.add(card);
      }

    return listOfCards;
  }

  Widget _rowFabRaisedButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.redAccent)),
          onPressed: () => controller.triggerLeft(),
          color: Colors.redAccent,
          textColor: Colors.white,
          child: Text(STR_FALSE, style: TextStyle(fontSize: 14)),
        ),
        SizedBox(
          width: 16.0,
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.lightGreen)),
          onPressed: () => controller.triggerRight(),
          color: Colors.lightGreen,
          textColor: Colors.white,
          child: Text(STR_TRUE, style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }

  //Old list of rowfab
  @deprecated
  Widget _rowFab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () => controller.triggerLeft(),
          tooltip: STR_FALSE,
          heroTag: HERO_FALSE,
          child: Icon(Icons.clear),
          //child: Text(STR_FALSE),
          backgroundColor: Colors.redAccent,
        ),

//          FloatingActionButton(
//            onPressed: () => _refreshList(),
//            tooltip: 'Change color',
//            child: Icon(Icons.palette),
//          ),
        SizedBox(
          width: 16.0,
        ),
        FloatingActionButton(
          onPressed: () => controller.triggerRight(),
          tooltip: STR_TRUE,
          heroTag: HERO_TRUE,
          child: Icon(Icons.check),
          backgroundColor: Colors.lightGreen,
        ),
      ],
    );
  }
}
