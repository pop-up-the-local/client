// this is widget for horizontal show of the items

import 'package:flutter/material.dart';
import '../services/pop_up_list_service.dart';
import '../style/theme.dart';

class HorizontalShow extends StatefulWidget {
  const HorizontalShow({super.key});

  @override
  State<HorizontalShow> createState() => _HorizontalShowState();
}

class _HorizontalShowState extends State<HorizontalShow> {
  List<dynamic> popUps = [];
  final PopUpListService _popUpListService = PopUpListService();

  @override
  void initState() {
    super.initState();
    _fetchPopUps();
  }

  void _fetchPopUps() async {
    var fetchedPopUps = await _popUpListService.fetchPopUps();
    setState(() {
      popUps = fetchedPopUps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
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
