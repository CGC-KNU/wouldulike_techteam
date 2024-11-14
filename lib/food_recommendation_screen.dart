import 'package:flutter/material.dart';
import 'package:new1/main2.dart';
import 'home.dart'; // HomeScreen을 정의한 home.dart 파일을 임포트

class FoodRecommendationScreen extends StatelessWidget {
  final String resultMessage;

  const FoodRecommendationScreen({super.key, required this.resultMessage});

  @override
  Widget build(BuildContext context) {
    // 1형, 2형, 3형, 4형에 맞는 음식 목록 정의
    List<List<String>> foodImages = [
      ['assets/images/food_image1.png', 'assets/images/food_image2.png', 'assets/images/food_image3.png'], // 1형 음식들
      ['assets/images/food_image4.png', 'assets/images/food_image5.png', 'assets/images/food_image6.png'], // 2형 음식들
      ['assets/images/food_image7.png', 'assets/images/food_image8.png', 'assets/images/food_image1.png'], // 3형 음식들
      ['assets/images/food_image3.png', 'assets/images/food_image1.png', 'assets/images/food_image2.png'], // 4형 음식들
    ];

    // 형에 맞는 음식 목록 선택
    List<String> selectedFoods;
    String challengeType;

    if (resultMessage == '1형') {
      selectedFoods = foodImages[0]; // 1형 음식들
      challengeType = '1형'; // 1형에 해당하는 텍스트
    } else if (resultMessage == '2형') {
      selectedFoods = foodImages[1]; // 2형 음식들
      challengeType = '2형'; // 2형에 해당하는 텍스트
    } else if (resultMessage == '3형') {
      selectedFoods = foodImages[2]; // 3형 음식들
      challengeType = '3형'; // 3형에 해당하는 텍스트
    } else {
      selectedFoods = foodImages[3]; // 4형 음식들
      challengeType = '4형'; // 4형에 해당하는 텍스트
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A5C), // 어두운 보라색 배경
      body: PageView(
        scrollDirection: Axis.vertical, // 아래로 스와이프 가능하도록 설정
        children: [
          for (int i = 0; i < 3; i++) // 3개의 화면을 보여줄 것
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        selectedFoods[i], // 선택된 음식 이미지
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '오늘의 메뉴는',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '추천 메뉴 ${i + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '# 건강한 한끼   # 고단백질',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3E3E80), // 어두운 보라색 컨테이너
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '‘$challengeType’인 당신을 위한 오늘의 추천 메뉴는 추천 메뉴 ${i + 1}입니다. 익숙한 재료들의 색다른 만남, 이번 식사에는 도전해보면 어떨까요?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // 마지막 화면에 버튼을 추가
                  if (i == 2)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // 모든 화면을 제거하고 HomeScreen을 새로운 시작 화면으로 설정
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MainAppScreen()),
                                  (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5A5FFF), // 버튼 색상
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            '홈으로 가기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
