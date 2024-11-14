import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // 화면 크기에 따라 카드 크기 조절
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.35; // 화면 너비의 35%로 카드 크기 설정

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('홈 화면'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      // SingleChildScrollView로 전체 화면 스크롤 가능하게 설정
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '오늘의 트렌드 뉴스',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '전체 보기',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                height: screenWidth * 0.5, // 화면 크기에 맞춰 높이 조절
                child: PageView(
                  controller: _pageController,
                  children: [
                    _buildPage(
                      'assets/images/food_image1.png',
                      '면역력 강화를 위한 10가지 한식 슈퍼푸드',
                      '우리 몸에 좋은 전통 식재료 알아보기',
                    ),
                    _buildPage(
                      'assets/images/food_image2.png',
                      '피부 건강을 위한 필수 영양소',
                      '피부를 지키는 다양한 영양소들',
                    ),
                    _buildPage(
                      'assets/images/food_image3.png',
                      '건강을 위한 슈퍼푸드 소개',
                      '하루 한 번 건강을 챙기자',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: WormEffect(
                    dotWidth: 8.0,
                    dotHeight: 8.0,
                    spacing: 8.0,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                '이번 주 가장 핫한 메뉴들을 만나보세요!',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildMenuCard(
                      'assets/images/food_image4.png',
                      '스테이크 샐러드',
                      '신선한 조합이 당신을\n자극합니다',
                      cardWidth,
                    ),
                    _buildMenuCard(
                      'assets/images/food_image5.png',
                      '매콤 치킨버거',
                      '매콤한 치킨버거로\n입맛을 사로잡다',
                      cardWidth,
                    ),
                    _buildMenuCard(
                      'assets/images/food_image6.png',
                      '시그니처 스테이크',
                      '육즙 가득한\n스테이크의 향연',
                      cardWidth,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(String imagePath, String title, String subtitle) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Stack(
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.6),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(String imagePath, String title, String description, double width) {
    return Container(
      width: width,
      margin: EdgeInsets.only(right: 12, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 내용에 맞춰 크기 조절
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              height: width * 0.8, // 카드 너비에 비례하여 이미지 높이 설정
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.08), // 카드 크기에 비례한 패딩
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.09, // 카드 크기에 비례한 글자 크기
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: width * 0.08, // 카드 크기에 비례한 글자 크기
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      '자세히 보기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.08,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: width * 0.04),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}