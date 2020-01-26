import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import 'quizz_brain.dart';

QuizzBrain quizzBrain = QuizzBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue.shade700,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
        appBar: AppBar(
          title: Center(
            child: Text(
              'Quizzler',
              style: TextStyle(
                color: Colors.amber,
              ),
            ),
          ),
          backgroundColor: Colors.pink.shade700,
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> iconsTheme = [];

  void checkAnswer(bool userPickerdAnswer) {
    bool correctAnswer = quizzBrain.getAnswerQuestion();

    setState(() {

      if (quizzBrain.isFinished() == true) {

        Alert(
          context: context,
          type: AlertType.success,
          title: "FINISHED!",
          desc: "You\'ve reached the end of the quiz.",

        ).show();

        quizzBrain.reset();

        //TODO: Step 4 Part D - empty out the iconsTheme.
        iconsTheme = [];
      }


      else {
        if (userPickerdAnswer == correctAnswer) {
          iconsTheme.add(
            Icon(
              Icons.check,
              color: Colors.greenAccent,
            ),
          );
        } else {
          iconsTheme.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizzBrain.nextQuestion();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizzBrain.getQuestionText(),

                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);

              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);

              },
            ),
          ),
        ),
        Row(
          children: iconsTheme,
        )
      ],
    );
  }
}
