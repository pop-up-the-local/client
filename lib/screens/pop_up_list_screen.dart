import 'package:flutter/material.dart';
import 'package:pop_up_the_local/services/pop_up_list_service.dart';
import 'package:pop_up_the_local/style/theme.dart';
import 'package:pop_up_the_local/widgets/custom_dropdown_widget.dart';

class PopUpListScreen extends StatefulWidget {
  const PopUpListScreen({super.key});

  @override
  State<PopUpListScreen> createState() => _PopUpListScreenState();
}

class _PopUpListScreenState extends State<PopUpListScreen> {
  String _selectedLocation = '전체';
  String _selectedIndustry = '전체';
  List<dynamic> _popupList = [];

  List<dynamic> popUps = [];
  final PopUpListService _popUpListService = PopUpListService();

  @override
  void initState() {
    super.initState();
    _fetchPopUps();
  }

  void _fetchPopUps() async {
    var fetchedPopUps = await _popUpListService.fetchPopUps(null, null);
    setState(() {
      popUps = fetchedPopUps;
    });
  }

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
              CustomDropdownWidget(
                categories: _industries,
                onChanged: (String? newValue) async {
                  final popupList = await _popUpListService.fetchPopUps(
                      _selectedLocation, newValue!);
                  setState(() {
                    _selectedIndustry = newValue;
                    _popupList = popupList;
                  });
                },
                dropdownValue: _selectedIndustry,
              ),
              CustomDropdownWidget(
                categories: _locations,
                onChanged: (String? newValue) async {
                  setState(() {
                    _selectedLocation = newValue!;
                    _popUpListService
                        .fetchPopUps(newValue, _selectedLocation)
                        .then((value) => setState(() {}));
                  });
                },
                dropdownValue: _selectedLocation,
              ),
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
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: popUps.length,
        itemBuilder: (context, index) {
          var popup = popUps[index];
          return Column(
            children: [
              InkWell(
                // 팝업 클릭 시 이동
                onTap: () {},
                child: Column(
                  children: [
                    Container(
                        width: 140,
                        height: 160,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ColorTheme.background,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(popup.image), // 팝업 대표 이미지
                            //image: AssetImage('assets/img/couple_date.png'),
                            fit: BoxFit.cover,
                          ),
                        )),
                    Text(
                      popup.title,
                      // '대구 수성구',
                      style: Theme.of(context).textTheme.titleMedium, // 팝업 위치
                    ),
                    Text(popup.address,
                        // '말이 많다',
                        style: Theme.of(context).textTheme.titleSmall), // 팝업 이름
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
