import 'package:flutter/material.dart';
import 'start_survey.dart';
import 'food_recommendation_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.totalScore,
    required this.selectedQuestions,
    required this.resetQuiz,
  });

  final int totalScore;
  final List<String> selectedQuestions;
  final Function resetQuiz;

  @override
  Widget build(BuildContext context) {
    String resultMessage;

    if (totalScore <= 13) {
      resultMessage = '1형';
    } else if (totalScore <= 23) {
      resultMessage = '2형';
    } else if (totalScore <= 33) {
      resultMessage = '3형';
    } else {
      resultMessage = '4형';
    }

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 내용과 버튼을 하단으로 배치
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.2), // 화면 상단 여백을 늘려 텍스트가 중앙에 위치
              child: Text(
                resultMessage,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30), // 텍스트와 버튼 간 간격

            // Expanded를 추가하여 남은 공간을 차지하도록 설정
            Expanded(
              child: Container(), // 빈 공간을 차지하게 하여 버튼들을 하단으로 내림
            ),

            // 버튼들
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    width: screenWidth * 0.6,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const StartSurveyScreen()),
                              (Route<dynamic> route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5A5FFF),
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "설문조사로 돌아가기",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // 버튼 간 간격
                  SizedBox(
                    width: screenWidth * 0.6,
                    child: ElevatedButton(
                      onPressed: () {
                        // resultMessage를 FoodRecommendationScreen으로 전달
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FoodRecommendationScreen(resultMessage: resultMessage),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5A5FFF),
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "음식 추천받기",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // 버튼 간 간격
                  SizedBox(
                    width: screenWidth * 0.6,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: 결과 공유하기 기능 추가
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5A5FFF),
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "결과 공유하기",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
