import 'package:flutter/material.dart';
import 'package:quiz_app_prac/model/api_adapter.dart';
import 'package:quiz_app_prac/model/model_quiz.dart';
import 'package:quiz_app_prac/screen/screen_quiz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Quiz> quiz = [];
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

 Future<void> _fetchQuiz() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get('https://quiz-test-demo.herokuapp.com/quiz/3');
    if(response.statusCode == 200) {
      setState(() {
        quiz = parseQuiz(utf8.decode(response.bodyBytes));
        isLoading = false;
      });
    } else{
      throw Exception('Failed to laod dat');
    }
  }
//  List<Quiz> quiz = [
//    Quiz.fromMap({
//      'title': 'test',
//      'candidates': [
//        "a",
//        "b",
//        "c",
//        "d",
//      ],
//      'answer': 0
//    }),
//    Quiz.fromMap({
//      'title': 'test',
//      'candidates': [
//        "a",
//        "b",
//        "c",
//        "d",
//      ],
//      'answer': 0
//    }),
//    Quiz.fromMap({
//      'title': 'test',
//      'candidates': [
//        "a",
//        "b",
//        "c",
//        "d",
//      ],
//      'answer': 0
//    }),
//  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('My Quiz App'),
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
            leading: Container(),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'images/quiz.jpeg',
                  width: width * 0.8,
                ),
              ),
              Padding(padding: EdgeInsets.all(width * 0.024)),
              Text('Flutter Quiz App',
                  style: TextStyle(
                      fontSize: width * 0.065, fontWeight: FontWeight.bold)),
              Text('Please read the instruction before take the quiz',
                  textAlign: TextAlign.center),
              Padding(padding: EdgeInsets.all(width * 0.048)),
              _buildStep(width: width, title: '1. Take three random quiz'),
              _buildStep(
                  width: width, title: '2. Click next after you selected quiz'),
              _buildStep(width: width, title: '3. Try to get perfect score!'),
              Padding(padding: EdgeInsets.all(width * 0.048)),
              Container(
                padding: EdgeInsets.only(bottom: width * 0.036),
                child: Center(
                  child: ButtonTheme(
                    minWidth: width * 0.8,
                    height: height * 0.05,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: RaisedButton(
                      child: Text('Start Now',
                          style: TextStyle(color: Colors.white)),
                      color: Colors.deepPurple,
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Row(
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Padding(padding: EdgeInsets.only(left: width * 0.036)),
                            Text('Loading..'),
                          ],
                        )));
                        _fetchQuiz().whenComplete(() {
                          return Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return QuizScreen(quiz: quiz);
                              },
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep({double width, String title}) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          width * 0.048, width * 0.024, width * 0.024, width * 0.048),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.check_box, size: width * 0.04),
          Padding(padding: EdgeInsets.only(right: width * 0.024)),
          Text(title),
        ],
      ),
    );
  }
}
