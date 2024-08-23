import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pop_up_the_local/widgets/custom_progress_ring_widget.dart';
import 'package:pop_up_the_local/widgets/custom_dropdown_white_widget.dart';
import 'package:pop_up_the_local/widgets/custom_dropdown_widget.dart';
import 'package:pop_up_the_local/widgets/text_input_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../style/theme.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  double _progress = 0.0;
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedLocation = '전체';
  String _selectedIndustry = '전체';

  @override
  void initState() {
    super.initState();
    _storeNameController.addListener(_updateProgress);
    _descriptionController.addListener(_updateProgress);
    _selectedLocation = '전체';
    _selectedIndustry = '전체';
  }

  void _updateProgress() {
    double newProgress = 0.0;
    if (_storeNameController.text.isNotEmpty) newProgress += 0.2;
    if (_descriptionController.text.isNotEmpty) newProgress += 0.2;
    if (_selectedLocation != '전체') newProgress += 0.2;
    if (_selectedIndustry != '전체') newProgress += 0.2;
    if (_selectedDay != DateTime.now()) newProgress += 0.2;

    setState(() {
      print(newProgress);
      _progress = newProgress;
    });
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _descriptionController.dispose();
    _selectedLocation = '전체';
    _selectedIndustry = '전체';
    super.dispose();
  }

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
      body: Column(
        children: [
          Container(
            height: 234,
            color: ColorTheme.background,
            child: Column(
              children: [
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomProgressRingWidget(
                      size: 80,
                      backgroundColor: ColorTheme.background,
                      progressColor: Colors.white,
                      strokeWidth: 8.0,
                      progress: _progress,
                    ),
                    const SizedBox(width: 40),
                    Text('팝업 신청하기',
                        style: Theme.of(context).textTheme.headlineLarge),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 600,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomDropdownWhiteWidget(
                        title: '장소',
                        categories: _locations,
                        selectedValue: _selectedLocation,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLocation = newValue!;
                            _updateProgress();
                          });
                        },
                      ),
                      CustomDropdownWhiteWidget(
                        title: '업종',
                        categories: _locations,
                        selectedValue: _selectedIndustry,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedIndustry = newValue!;
                            _updateProgress();
                          });
                        },
                      ),
                    ],
                  ),
                  TextInputWidget(
                      title: '가게 이름',
                      hintText: '가게 이름을 입력해주세요',
                      controller: _storeNameController,
                      onTextChanged: _updateProgress),
                  // const TextInputWidget(
                  //     title: '팝업 장소', hintText: '팝업 장소를 선택해주세요'),
                  // const TextInputWidget(
                  //     title: '카테고리', hintText: '카테고리를 선택해주세요'),
                  TextInputWidget(
                      title: '내용',
                      hintText: '내용을 입력해주세요',
                      controller: _descriptionController,
                      onTextChanged: _updateProgress),
                  const SizedBox(height: 20),
                  buildCalendar(),
                  const SizedBox(height: 20),
                  const Text('시간을 선택해주세요'),
                  const SizedBox(height: 20),
                  const Text('시간을 선택해주세요'),
                  const SizedBox(height: 20),
                  const Text('시간을 선택해주세요'),
                  const SizedBox(height: 20),
                  const Text('시간을 선택해주세요'),
                  const SizedBox(height: 20),
                  const Text('시간을 선택해주세요'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCalendar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        locale: 'ko_KR',
        daysOfWeekHeight: 30,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          // 선택한 날짜를 저장하고 화면을 갱신합니다.
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
            _updateProgress();
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(
            color: ColorTheme.background,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          formatButtonShowsNext: false,
        ),
      ),
    );
  }
}
