import 'package:flutter/material.dart';
import 'question_screen.dart'; // QuizScreen 임포트

class StartSurveyScreen extends StatefulWidget {
  const StartSurveyScreen({super.key});

  @override
  _StartSurveyScreenState createState() => _StartSurveyScreenState();
}

class _StartSurveyScreenState extends State<StartSurveyScreen> {
  double _opacityFirstText = 0.0;
  double _opacitySecondText = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 1000)); // 첫 번째 텍스트 지연 시간 늘림
    setState(() {
      _opacityFirstText = 1.0;
    });

    await Future.delayed(const Duration(milliseconds: 1000)); // 두 번째 텍스트 지연 시간 늘림
    setState(() {
      _opacitySecondText = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFF000033), // 짙은 파란색 배경
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.2), // 화면 높이에 비례하여 상단 여백 설정
              child: const Text(
                '음식 취향 테스트',
                style: TextStyle(
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.3), // 제목 아래에 위치하도록 설정
              child: Column(
                children: [
                  AnimatedOpacity(
                    opacity: _opacityFirstText,
                    duration: const Duration(milliseconds: 1700), // 애니메이션 지속 시간을 느리게 설정
                    child: const Text(
                      '무엇을 먹을지 고민이라면?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01), // 텍스트 사이 간격을 화면 높이에 맞게 설정
                  AnimatedOpacity(
                    opacity: _opacitySecondText,
                    duration: const Duration(milliseconds: 1700), // 애니메이션 지속 시간을 느리게 설정
                    child: const Text(
                      '당신의 음식 취향 유형을 탐험해보세요!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.1), // 버튼을 화면 비율에 따라 하단에 배치
              child: SizedBox(
                width: screenWidth * 0.8, // 버튼의 너비를 화면 너비에 비례하여 설정
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(
                          questionIndex: 0, // 첫 번째 질문부터 시작
                          answerPressed: (score) {},
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A5FFF), // 밝은 파란색 버튼
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025), // 버튼 높이를 화면 높이에 비례하게 설정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        '테스트 시작하기',
                        style: TextStyle(
                          fontFamily: "Pretendard",
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '2분 만에 나의 음식 취향 확인하기',
                        style: TextStyle(
                          fontFamily: "Pretendard",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
