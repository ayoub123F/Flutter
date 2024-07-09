import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestion = 0;
  int score = 0;
  var quiz = [
    {
      "title": "Question1",
      "answers": [
        {"answer": "Answer11", "correct": false},
        {"answer": "Answer12", "correct": true},
        {"answer": "Answer13", "correct": false},
      ]
    },
    {
      "title": "Question2",
      "answers": [
        {"answer": "Answer21", "correct": true},
        {"answer": "Answer22", "correct": false},
        {"answer": "Answer23", "correct": false},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
      ),
      body: (this.currentQuestion >= quiz.length)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Score : ${(100 * score / quiz.length).round()} %",
                    style:
                        TextStyle(fontSize: 22, color: Colors.deepOrangeAccent),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        this.currentQuestion = 0;
                        this.score = 0;
                      });
                    },
                    color: Colors.deepOrangeAccent,
                    child: Text(
                      "Restart...",
                      style: TextStyle(fontSize: 22),
                    ),
                    textColor: Colors.white,
                  ),
                ],
              ),
            )
          : ListView(
              children: [
                ListTile(
                  title: Center(
                    child: Text(
                      "Question ${currentQuestion + 1}/${quiz.length}",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    quiz[currentQuestion]['title'] as String,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...(quiz[currentQuestion]['answers']
                        as List<Map<String, Object>>)
                    .map(
                  (answer) => ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepOrangeAccent),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            if (answer['correct'] == true) {
                              ++score;
                            }
                            ++currentQuestion;
                          });
                        },
                        child: Text(
                          answer['answer'] as String,
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
