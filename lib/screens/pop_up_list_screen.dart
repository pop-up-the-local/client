import 'package:flutter/material.dart';
import 'package:pop_up_the_local/widgets/custom_dropdown_widget.dart';

import '../services/bookmark_service.dart';
import '../style/theme.dart';

class PopUpListScreen extends StatefulWidget {
  const PopUpListScreen({super.key});

  @override
  State<PopUpListScreen> createState() => _PopUpListScreenState();
}

class _PopUpListScreenState extends State<PopUpListScreen> {
  bool _isBookmarked = true;
  final List<String> _industries = <String>[
    '전체',
    '요식',
    '제조',
    '예술',
    '교육',
  ];
  final List<String> _locations = <String>[
    '전체',
    '서울',
    '경기',
    '인천',
    '부산',
    '대구',
    '울산',
    '광주',
    '대전',
    '세종',
    '강원',
    '충북',
    '충남',
    '전북',
    '전남',
    '경북',
    '경남',
    '제주도'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('팝업 목록'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomDropdownWidget(categories: _industries),
              CustomDropdownWidget(categories: _locations),
            ],
          ),
          Expanded(
            child: _buildPopUpList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPopUpList() {
    return Container(
      color: Colors.white,
      child: FutureBuilder(
        future: getBookmarkList("66c4403a3e0e4edeae03270a"), // 함수 수정 필요
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      minVerticalPadding: 10.0,
                      leading: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(8.0), // 원하는 반경 값으로 설정
                        child: Image.network(
                          snapshot.data![index].image,
                          width: 70,
                          height: 80,
                          fit: BoxFit.cover, // 이미지가 잘리지 않도록 설정
                        ),
                      ),
                      title: Text(
                        snapshot.data![index].title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            snapshot.data![index].description, // 설명 텍스트
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '기간: ${snapshot.data![index].start_date} ~ ${snapshot.data![index].end_date}', // 기간 날짜 텍스트
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      // trailing: IconButton(
                      //   onPressed: () {
                      //     _isBookmarked = !_isBookmarked;
                      //     setState(() {});
                      //     _onPressBookmark();
                      //   },
                      //   icon: Icon(
                      //     _isBookmarked
                      //         ? Icons.bookmark
                      //         : Icons.bookmark_border,
                      //     color: ColorTheme.background,
                      //   ),
                      // ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      onTap: () {
                        // 아이템 클릭 시 동작
                        print('Tapped on ${snapshot.data![index].title}');
                      },
                    ),
                    const Divider(
                      color: Color.fromARGB(37, 73, 73, 73),
                      thickness: 1.0,
                      indent: 16.0,
                      endIndent: 16.0,
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  void _onPressBookmark() {
    // TODO: 북마크 추가/삭제 기능 구현
  }
}
