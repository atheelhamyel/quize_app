import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int questionIndex = 0;
  int score = 0;
  String? selectedAnswer;
  bool showScore = false;

  List<Map<String, dynamic>> question = [
    {
      'question': 'what your favorite color?',
      'answers': ['red', 'blue', 'Green', 'black'],
      'correctAnswer': 'red',
      'key': 'question_one'
    },
    {
      'question': 'what your favorite animal?',
      'answers': ['dog', 'cat', 'lino', 'elephant'],
      'correctAnswer': 'cat',
      'key': 'question_two'
    },
    {
      'question': 'what your favorite food?',
      'answers': ['pizza', 'burger', 'pasta', 'sandwich'],
      'correctAnswer': 'burger',
      'key': 'question_three'
    },
    {
      'question': 'what your favorite movie?',
      'answers': ['Titanic', 'Avatar', 'Inception', 'Interstellar'],
      'correctAnswer': 'Avatar',
      'key': 'question_four'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldMessenger( // Wrap your Scaffold with ScaffoldMessenger
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 232, 206, 232),
          body: 
          Builder(
            builder: (context) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: !showScore
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 45,
                              ),
                              Text(
                                question[questionIndex]['question'] as String,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('answer and get point!'),
                              const SizedBox(
                                height: 35,
                              ),
                              Text(
                                question[questionIndex]['key'] as String,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              Column(
                                children: (question[questionIndex]['answers']
                                        as List<String>)
                                    .map((answer) => Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                selectedAnswer = answer;
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: answer == selectedAnswer
                                                    ? Colors.green
                                                    : null,
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              width: double.infinity,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 30),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.add,
                                                      color: answer ==
                                                              selectedAnswer
                                                          ? Colors.white
                                                          : null,
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      answer,
                                                      style: TextStyle(
                                                          color: answer ==
                                                                  selectedAnswer
                                                              ? Colors.white
                                                              : null),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (selectedAnswer != null) {
                                      if (selectedAnswer ==
                                          question[questionIndex]
                                              ['correctAnswer']) {
                                        setState(() {
                                          score++;
                                        });
                                      }
                                      if (questionIndex < question.length - 1) {
                                        setState(() {
                                          questionIndex++;
                                        });
                                      } else {
                                        setState(() {
                                          showScore = true;
                                        });
                                      }
                                      setState(() {
                                        selectedAnswer = null;
                                      });
                                      debugPrint('Index: $questionIndex');
                                    } else {
                                     ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content:Text('Please select an answer before proceeding.'),
                                       backgroundColor: Color.fromARGB(255, 236, 213, 230),

                                      ));
                                    }
                                  },
                                  child: const Text('Next'),
                                ),
                              )
                            ],
                          )
                        : Builder(
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Quiz Completed',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Score: $score / ${question.length}',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            questionIndex = 0;
                                            score = 0;
                                            showScore = false;
                                            selectedAnswer = null;
                                          });
                                        },
                                        child: const Text('Restart Quiz'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          SystemNavigator.pop();
                                        },
                                        child: const Text('Exit Quiz'),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
