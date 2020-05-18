

class Quiz {
  String title;
  List<String> candidates;
  int answer;

  Quiz({this.title, this.answer, this.candidates});

  factory Quiz.fromMap(Map<String, dynamic> data) {
    return Quiz(
      title: data['title'],
      candidates: data['candidates'],
      answer:  data['answer'],
    );
  }

  Quiz.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        candidates = json['body'].toString().split('/'),
        answer = json['answer'];
}