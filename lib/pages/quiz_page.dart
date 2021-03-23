import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:nuovoquizarbitri/logic/bloc/personal_questions/personal_questions_bloc.dart';
import 'package:nuovoquizarbitri/utils/constants.dart';
import 'package:nuovoquizarbitri/widget/loading_indicator.dart';
import 'package:nuovoquizarbitri/widget/recap_answers_list.dart';
import 'package:questions_repository/questions_repository.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key key}) : super(key: key);
  final String title = APP_NAME;

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  List<Card> listOfCards;
  CardController controller = CardController();
  int currentQuestion = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SelectableText(widget.title),
      ),
      body: _buildBody(context),
    );
  }

  Column _buildBody(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      _sizedBoxDivider(),
      SelectableText(
        "$STR_QUIZ!", //"Quiz!",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
      //_sizedBoxDivider(),

      BlocBuilder<PersonalQuestionsBloc, PersonalQuestionsState>(
        builder: (context, state) {
          if (state is PersonalQuestionsLoading) {
            return LoadingIndicator();
          } else if (state is PersonalQuestionsLoaded) {
            listOfCards =
                _generateListOfCards(state.personalQuestions.questions);

            return Column(
              children: [
                _createCustomCards(context),
                _sizedBoxDivider(),
                _listAnswersRaisedButtons(state.personalQuestions.questions),
              ],
            );
          } else if (state is PQuestionsAllAnswered) {
            return Flexible(
                flex: 2, child: recapAnswers(context, state.personalQuestions));
          }
          return Container();
        },
      )
    ]);
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

          return TinderSwapCard(
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
              });
        }));
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

  Widget _listAnswersRaisedButtons(List<Question> questionsList) {
    return ListView.builder(
      //physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.0),
      shrinkWrap: true,
      itemBuilder: (_, index) => _answerWidget(
          questionsList[currentQuestion].possibleAnswers[index],
          index), //todo: fix first arguments
      itemCount: questionsList[currentQuestion].possibleAnswers.length,
    );
  }

  Widget _answerWidget(String answerLablel, int indexAnswer) {
    List<MaterialAccentColor> accentColors = [
      Colors.blueAccent,
      Colors.orangeAccent,
      Colors.greenAccent,
      Colors.pinkAccent
    ];
    MaterialAccentColor currentAccentColor = accentColors[indexAnswer];
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: currentAccentColor)),
      onPressed: () {
        controller.triggerLeft();
        context
            .read<PersonalQuestionsBloc>()
            .add(AnswerQuestion(currentQuestion, indexAnswer));
      },
      color: Colors.white,
      textColor: currentAccentColor,
      child: Text(answerLablel, style: TextStyle(fontSize: 14)),
    );
  }

  Widget _sizedBoxDivider() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
