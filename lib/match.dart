import 'package:flutter/material.dart';
import 'match_survey.dart';
class MatchingScreen extends StatefulWidget {
  @override
  _MatchingScreenState createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  int? selectedCount;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '매칭',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                '몇 명과 함께 식사를 하나요?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.6,
                children: [
                  _buildPersonCountButton(1),
                  _buildPersonCountButton(2),
                  _buildPersonCountButton(3),
                  _buildPersonCountButton(4),
                ],
              ),
              SizedBox(height: 100),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F7FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '오늘 뭐 먹지? 이젠 더 이상 고민하지 마세요!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '우린 어떤 미식가? 우리의 입맛 유형을 확인합니다!',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '모두의 입맛을 사로잡을 추천 메뉴와 맛집까지 한 번에 알아봐요!',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                height: 48,
                margin: EdgeInsets.only(bottom: 8),
                child: ElevatedButton(
                  onPressed: selectedCount != null
                      ? () {
                    // Handle matching start
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder:(context)=> SurveyScreen()
                      ),
                    );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF03037C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    disabledBackgroundColor: Colors.grey[300],
                  ),
                  child: Text(
                    '테스트 시작하기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    '1분 안에 우리의 입맛 유형 확인하기',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonCountButton(int count) {
    bool isSelected = selectedCount == count;

    return GestureDetector(  // GestureDetector 추가
      onTap: () {
        setState(() {
          selectedCount = count;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFF5F7FF) : Colors.white,
          border: Border.all(
            color: isSelected ? Color(0xFF3D3DFF) : Colors.grey[300]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline,
              color: isSelected ? Color(0xFF3D3DFF) : Colors.grey[600],
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              '${count}명',
              style: TextStyle(
                color: isSelected ? Color(0xFF3D3DFF) : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}