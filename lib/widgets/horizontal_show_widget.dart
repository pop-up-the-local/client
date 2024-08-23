// this is widget for horizontal show of the items

import 'package:flutter/material.dart';
import '../style/theme.dart';

class HorizontalShow extends StatefulWidget {
  const HorizontalShow({super.key});

  @override
  State<HorizontalShow> createState() => _HorizontalShowState();
}

class _HorizontalShowState extends State<HorizontalShow> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
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
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/img/couple_date.png'), // 팝업 대표 이미지
                            fit: BoxFit.cover,
                          ),
                        )),
                    Text(
                      "대구 수성구",
                      style: Theme.of(context).textTheme.titleMedium, // 팝업 위치
                    ),
                    Text("OO 스토어",
                        style:
                            Theme.of(context).textTheme.titleMedium), // 팝업 이름
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
