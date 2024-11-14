import 'package:flutter/material.dart';
import 'match_questionlist.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  int currentPage = 1;
  final int totalPages = 8;
  int? selectedAnswer;
  List<int> userAnswers = [];

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = QuestionData.questions[currentPage - 1];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '매칭',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // 진행 상태 표시
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '$currentPage / $totalPages',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: currentPage / totalPages,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF03037C)),
                      minHeight: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),

          // 질문 텍스트
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              currentQuestion.questionText,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 40),

          // 답변 영역
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  currentQuestion.answers.length,
                      (index) => Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAnswer = index;
                          userAnswers.add(currentQuestion.answers[index].score);

                          if (currentPage < totalPages) {
                            Future.delayed(Duration(milliseconds: 300), () {
                              setState(() {
                                currentPage++;
                                selectedAnswer = null;
                              });
                            });
                          } else {
                            // 모든 질문이 끝났을 때의 처리
                            print('Survey completed! Answers: $userAnswers');
                          }
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 110,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: selectedAnswer == index
                              ? Color(0xFFF5F7FF)
                              : Colors.white,
                          border: Border.all(
                            color: selectedAnswer == index
                                ? Color(0xFF3D3DFF)
                                : Colors.grey[300]!,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentQuestion.answers[index].text,
                              style: TextStyle(
                                color: selectedAnswer == index
                                    ? Color(0xFF3D3DFF)
                                    : Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              currentQuestion.answers[index].subtitle,
                              style: TextStyle(
                                color: selectedAnswer == index
                                    ? Color(0xFF3D3DFF)
                                    : Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16), // 하단 여백 추가
        ],
      ),
    );
  }
}