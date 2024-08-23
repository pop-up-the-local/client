import 'package:flutter/material.dart';
import 'package:pop_up_the_local/style/theme.dart';
import 'package:pop_up_the_local/widgets/horizontal_show_widget.dart';
import 'package:pop_up_the_local/widgets/title_widget.dart';

class PopUpDetailedScreen extends StatefulWidget {
  const PopUpDetailedScreen({super.key});

  @override
  State<PopUpDetailedScreen> createState() => _PopUpDetailedScreenState();
}

class _PopUpDetailedScreenState extends State<PopUpDetailedScreen> {
  bool _isBookmarked = false;
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isBookmarked ? '북마크 설정됨' : '북마크 해제됨'),
        duration: const Duration(milliseconds: 200),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 팝업 상세 페이지
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 243,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/couple_date.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                // 팝업 상세 정보
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  height: 150,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: '팝업 이름',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                  children: const [
                                    // 빈칸 넣기
                                    TextSpan(text: '  '),
                                    TextSpan(
                                        text: '팝업 위치',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    // style:
                                    //     Theme.of(context).textTheme.bodyMedium),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: _toggleBookmark,
                                icon: Icon(
                                  _isBookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: ColorTheme.background,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('기간: 2021.08.01 ~ 2021.08.31',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('장소: 대구 북구 대현동 123-4 1층',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  //padding: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey, width: 0.3),
                      //bottom: BorderSide(color: Colors.grey, width: 0.3),
                    ),
                  ),
                  child: Text(
                    '팝업 상세 설명입니다.팝업 상세 설명입니다.팝업 상세 설명입니다.팝업 상세 설명입니다.팝업 상세 설명입니다.팝업 상세 설명입니다.팝업 상세 설명입니다.팝업 상세 설명입니다.팝업 상세 설명입니다.팝업 상세 설명입니다.팝업 상세 설명입니다.팝업 상세 설명입니다.팝업 상세 설명입니다.팝업 상세 설명입니다.팝업 상세 설명입니다.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  // get size of _buildImageCard() and multiply by number of images
                  // set height as reactive to the number of images
                  height: _isExpanded ? 410 * 6 : 410,

                  decoration: const BoxDecoration(
                    border: Border(
                        //top: BorderSide(color: Colors.grey, width: 0.3),
                        bottom: BorderSide(color: Colors.grey, width: 0.3)),
                  ),
                  child: _isExpanded
                      ? GridView.count(
                          padding: const EdgeInsets.all(20),
                          scrollDirection: Axis.vertical,
                          mainAxisSpacing: 10, // 이미지 사이의 간격
                          crossAxisCount: 1, // 노출 이미지 수
                          shrinkWrap: true, // 스크롤 가능 여부
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(6, (index) {
                            return _buildImageCard(
                                'assets/img/couple_date.png');
                          }),
                        )
                      : GridView.count(
                          padding: const EdgeInsets.all(20),
                          scrollDirection: Axis.vertical,
                          mainAxisSpacing: 10,
                          crossAxisCount: 1,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(6, (index) {
                            return _buildImageCard(
                                'assets/img/couple_date.png');
                          }),
                        ),
                ),
                GestureDetector(
                  onTap: _toggleExpand,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isExpanded ? '접기' : '더보기',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Icon(
                          _isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        ),
                      ],
                    ),
                  ),
                ),
                const TitleWidget(title: "유사한 동네 팝업", keyWord: "유사한 동네 팝업"),
                const HorizontalShow(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(String imagePath) {
    return Card(
      //key: _imageCardKey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      margin: const EdgeInsets.all(0),
      child: Image.asset(
        imagePath,
        height: 410,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
