import 'package:flutter/material.dart';
import 'question_list.dart'; // 질문 리스트 임포트
import 'result_screen.dart'; // 결과 화면 임포트

class QuizScreen extends StatefulWidget {
  final int questionIndex;
  final Function answerPressed;

  const QuizScreen({
    Key? key,
    required this.answerPressed,
    required this.questionIndex,
  }) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _totalScore = 0;
  int _currentQuestionIndex = 0;
  int _selectedIndex = -1;
  List<String> _selectedAnswers = [];

  void _answerQuestion(int score, String answer, int index) {
    setState(() {
      _selectedIndex = index;
      _totalScore += score;
      _selectedAnswers.add(answer);
    });
  }

  void _nextQuestion() {
    if (_selectedIndex == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("답변을 선택해주세요.")),
      );
      return;
    }

    setState(() {
      _currentQuestionIndex += 1;
      _selectedIndex = -1;
    });

    // 질문이 끝났을 경우 결과 화면으로 이동
    if (_currentQuestionIndex >= questionList.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            totalScore: _totalScore,
            selectedQuestions: _selectedAnswers,
            resetQuiz: _resetQuiz,
          ),
        ),
      );
    }
  }

  void _resetQuiz() {
    setState(() {
      _totalScore = 0;
      _currentQuestionIndex = 0;
      _selectedAnswers.clear();
      _selectedIndex = -1;
    });
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  double get _progress {
    return questionList.isNotEmpty ? (_currentQuestionIndex + 1) / questionList.length : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [
              Color(0xFF1E1B4B), Color(0xFF1E1C4C), Color(0xFF1A1F4F), Color(0xFF192352),
              Color(0xFF1D1F56), Color(0xFF311B6C), Color(0xFF330D60), Color(0xFF3A0763)
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.04, bottom: screenHeight * 0.05),
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.grey[700],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.04,
              ),
              child: Text(
                // 리스트가 비었거나 범위를 넘었을 때 처리
                questionList.isNotEmpty && _currentQuestionIndex < questionList.length
                    ? 'Q${_currentQuestionIndex + 1} : ${questionList[_currentQuestionIndex]["questionText"]}'
                    : '질문이 없습니다.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: questionList.isNotEmpty && _currentQuestionIndex < questionList.length
                  ? ListView.builder(
                itemCount: questionList[_currentQuestionIndex]["answers"].length,
                itemBuilder: (context, index) {
                  final answer = questionList[_currentQuestionIndex]["answers"][index];
                  final isSelected = _selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      _answerQuestion(
                        answer["score"],
                        answer["text"],
                        index,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.01,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.015,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blueAccent : Color(0xFF232F5C),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Color(0xFF7F8AF5) : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  answer["text"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.04,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Text(
                                  answer["description"] ?? '',
                                  style: TextStyle(
                                    color: Color(0xFF94A0EB),
                                    fontSize: screenWidth * 0.038,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Radio(
                            value: index,
                            groupValue: _selectedIndex,
                            onChanged: (int? value) {
                              if (value != null) {
                                _answerQuestion(
                                  answer["score"],
                                  answer["text"],
                                  value,
                                );
                              }
                            },
                            activeColor: Colors.white,
                            fillColor: MaterialStateProperty.all(Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
                  : Center(
                child: Text(
                  '질문이 없습니다.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.05),
              child: SizedBox(
                width: screenWidth * 0.5,
                child: ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedIndex == -1 ? Colors.grey : Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    '다음으로',
                    style: TextStyle(
                      color: _selectedIndex == -1 ? Color(0xFFA5B4FC) : Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
