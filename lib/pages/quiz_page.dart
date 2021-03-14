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

class QuizPage extends StatefulWidget {
  QuizPage({Key key}) : super(key: key);
  final String title = APP_NAME;

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  List<Card> listOfCards;
  final Store<AppState> store = createStore();
  CardController controller = CardController();
  int currentQuestion;

  @override
  void initState() {
    super.initState();
    store.dispatch(GenerateQuizQuestions());
    currentQuestion = 0;
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
        ));
  }


/*  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: SelectableText(widget.title),
      ),
      body: _buildBody(context),
    );
  }*/

  Column _buildBody(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      _sizedBoxDivider(),
      SelectableText(
        "$STR_QUIZ!", //"Quiz!",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
      //_sizedBoxDivider(),

      StoreConnector<AppState, QuestionsListState>(
          converter: (store) => store.state.questionsListState,
          builder: (BuildContext context, QuestionsListState userState) {
            return !store.state.questionsListState.answeredLastQuestion
                ? Column(
                    children: [
                      _createCustomCards(context),
                      _sizedBoxDivider(),
                      _listAnswersRaisedButtons(),
                    ],
                  )
                : Flexible(
                    flex: 2,
                    child:
                        recapAnswers(context, store.state.questionsListState));
          }),
    ]);
/*
    _createCustomCards(context),
    _sizedBoxDivider(),
    _listAnswersRaisedButtons()
    ]);*/
  }

  Container _createCustomCards(BuildContext context) {
    final double _containerCardHeight =
        MediaQuery.of(context).size.height * 0.5;

    return Container(
        height: _containerCardHeight,
        child: Builder(builder: (BuildContext innerContext) {
          final double _cardSwipeEdge = MediaQuery.of(context).size.width *
              0.4; //in this way I can disable the swipe
          final double _cardMaxWidth = MediaQuery.of(context).size.width * 0.9;
          final double _cardMaxHeight = MediaQuery.of(context).size.width * 0.9;
          final double _cardMinWidth = MediaQuery.of(context).size.width * 0.8;
          final double _cardMinHeight = MediaQuery.of(context).size.width * 0.6;

          store.dispatch(SetQuestionsListContext(context: innerContext));
          return StoreProvider(
            store: store,
            child: TinderSwapCard(
                swipeUp: false,
                swipeDown: false,
                orientation: AmassOrientation.BOTTOM,
                totalNum: listOfCards.length,
                stackNum: 3,
                swipeEdge: _cardSwipeEdge,
                maxWidth: _cardMaxWidth,
                maxHeight: _cardMaxHeight,
                minWidth: _cardMinWidth,
                minHeight: _cardMinHeight,
                cardBuilder: (context, index) {
                  return listOfCards[index];
                },
                cardController: controller,
                swipeUpdateCallback:
                    (DragUpdateDetails details, Alignment align) {
                  /// Get swiping card's alignment
                  if (align.x < 0) {
                    //Card is LEFT swiping

                  } else if (align.x > 0) {
                    //Card is RIGHT swiping
                  }
                },
                swipeCompleteCallback:
                    (CardSwipeOrientation orientation, int index) {
                  // Get orientation & index of swiped card!
                  currentQuestion = ++index;
//                      if (store.state.questionsListState.answeredLastQuestion){
//                        Navigator.pushNamed(context, RECAP_ANSWERS_ROUTE);
//                      }
                }),
          );
        }));
  }

  static List<Card> _generateListOfCards(List<Question> listOfQuestions) {
    List<Card> listOfCards = [];
    if (listOfQuestions != null && listOfQuestions.isNotEmpty)
      for (int i = 0; i < listOfQuestions.length ?? 100; i++) {
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

  Widget _listAnswersRaisedButtons() {
    List<Question> questionsList = store.state.questionsListState.questionsList;
    return ListView.builder(
      //physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.0),
      shrinkWrap: true,
      itemBuilder: (_, index) => _answerWidget(
          questionsList[currentQuestion].possibleAnswers[index], index),
      itemCount: questionsList[currentQuestion].possibleAnswers.length,
    );
  }

  Widget _answerWidget(String answer, int index) {
    List<MaterialAccentColor> accentColors = [
      Colors.blueAccent,
      Colors.orangeAccent,
      Colors.greenAccent,
      Colors.pinkAccent
    ];
    MaterialAccentColor currentAccentColor = accentColors[index];
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: currentAccentColor)),
      onPressed: () {
        if (currentQuestion <
            store.state.questionsListState.questionsList.length) {
          controller.triggerLeft();
          store.dispatch(AnswerQuestion(
              currentQuestion: currentQuestion, givenAnswer: index));
        }
      },
      color: Colors.white,
      textColor: currentAccentColor,
      child: Text(answer, style: TextStyle(fontSize: 14)),
    );
  }

  Widget _sizedBoxDivider() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
