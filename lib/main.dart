import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './questions.dart';
import 'package:flutter/rendering.dart';
import 'package:quiz_app/questions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.pinkAccent,
        appBar: AppBar(
          title: Text("Quiz"),
          backgroundColor: Colors.blue,
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Question> questions = [
    Question(
        text: "flutter is best sdk for mobile development ?", answer: true),
    Question(text: "dart is programing language ?", answer: true),
    Question(text: "ionic is language ?", answer: false),
    Question(text: "android studio is not IDE ?", answer: false),
    Question(text: "flutter is Framework ?", answer: true),
    Question(text: "xamarin is Framework ?", answer: true),
  ]..shuffle();
  int currentQuestion = 0;
  int score = 0;
  int correctCounter = 0;
  int wrongCounter = 0;
  bool quizCompleted = false;

  void nextQuestion(bool answer, BuildContext context) {
    setState(() {
      if (!quizCompleted) {
        if (questions[currentQuestion].answer == answer) {
          correctCounter++;
          score += 10;
        } else {
          wrongCounter++;
        }
      }
      if (questions.length - 1 > currentQuestion) {
        currentQuestion++;
      } else {
        quizCompleted = true;
        showResults(context);
      }
    });
  }

  void showResults(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              "Quiz completed",
              style: TextStyle(fontSize: 30, color: Colors.deepOrange),
            ),
            content: Text("Thank you .. your score is $score",
                style: TextStyle(fontSize: 30, color: Colors.deepOrange)),
            actions: <Widget>[
              FlatButton(
                child: Text("Reset"),
                onPressed: () {
                  setState(() {
                    currentQuestion = 0;
                    score = 0;
                    correctCounter = 0;
                    wrongCounter = 0;
                    quizCompleted = false;
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              questions[currentQuestion].text,
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          // SizedBox(
          //   height: 30,
          // ),
          Expanded(
            flex: 1,
            child: ButtonTheme(
              minWidth: 200,
              buttonColor: Colors.white,
              child: RaisedButton(
                onPressed: () {
                  nextQuestion(true, context);
                },
                child: Text(
                  "True",
                  style: TextStyle(fontSize: 40, color: Colors.blue),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    40,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            flex: 1,
            child: ButtonTheme(
              minWidth: 200,
              buttonColor: Colors.white,
              child: RaisedButton(
                onPressed: () {
                  nextQuestion(false, context);
                },
                child: Text(
                  "false",
                  style: TextStyle(fontSize: 40, color: Colors.blue),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    40,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Correct",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  Text(
                    correctCounter.toString(),
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: <Widget>[
                  Text(
                    "wrong",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  Text(
                    wrongCounter.toString(),
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
