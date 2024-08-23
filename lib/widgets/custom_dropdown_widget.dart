import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../style/theme.dart';

class CustomDropdownWidget extends StatefulWidget {
  const CustomDropdownWidget({super.key, required this.categories});

  final List<String> categories;

  @override
  State<CustomDropdownWidget> createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.categories[0];
  }

  @override
  Widget build(BuildContext context) {
    int maxLength = 7;

    for (String category in widget.categories) {
      if (category.length > maxLength) {
        maxLength = category.length;
      }
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            children: [
              Expanded(
                child: Text(
                  widget.categories[0],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          value: dropdownValue,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                dropdownValue = newValue; // 선택된 값으로 업데이트
              });
            }
          },
          items: widget.categories
              .map((String category) => DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          buttonStyleData: ButtonStyleData(
            height: 30,
            width: maxLength * 16,
            padding: const EdgeInsets.only(left: 16, right: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: ColorTheme.background),
            elevation: 1,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down_rounded,
            ),
            iconSize: 20,
            iconEnabledColor: Colors.white,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 150,
            width: maxLength * 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorTheme.background,
            ),
            offset: const Offset(0, 0),
            scrollbarTheme: const ScrollbarThemeData(
              radius: Radius.circular(20),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 16, right: 16),
          ),
        ),
      ),
    );
  }
}
