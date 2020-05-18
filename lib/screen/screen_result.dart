import 'package:flutter/material.dart';
import 'package:quiz_app_prac/model/model_quiz.dart';
import 'package:quiz_app_prac/screen/home_screen.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({this.answers, this.quiz});

  List<int> answers;
  List<Quiz> quiz;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    int score = 0;
    for (int i = 0; i < quiz.length; i++) {
      if (quiz[i].answer == answers[i]) {
        score += 1;
      }
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Quiz App'),
            backgroundColor: Colors.deepPurple,
            leading: Container(),
          ),
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurple),
                color: Colors.deepPurple,
              ),
              width: width * 0.85,
              height: height * 0.5,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(width * 0.048)),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.deepPurple),
                      color: Colors.white,
                    ),
                    width: width * 0.73,
                    height: height * 0.3,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              0, width * 0.048, 0, width * 0.048),
                          child: Text(
                            'Thank you for playing',
                            style: TextStyle(
                                fontSize: width * 0.055,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text('Your score is',
                            style: TextStyle(
                                fontSize: width * 0.048,
                                fontWeight: FontWeight.bold)),
                        Expanded(
                          child: Container(),
                        ),
                        Text(score.toString() + '/' + quiz.length.toString(),
                            style: TextStyle(
                                fontSize: width * 0.21,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent)),
                        Padding(padding: EdgeInsets.all(width * 0.012)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(width * 0.048),
                      child: ButtonTheme(
                        minWidth: width * 0.73,
                        height: height * 0.05,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: RaisedButton(
                          child: Text('Back to Home'),
                          color: Colors.white,
                          textColor: Colors.black,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return HomeScreen();
                            }));
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
