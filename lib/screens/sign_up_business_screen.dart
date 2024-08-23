import 'package:flutter/material.dart';

class SignUpBusinessScreen extends StatefulWidget {
  const SignUpBusinessScreen({super.key});

  @override
  State<SignUpBusinessScreen> createState() => _SignUpBusinessScreenState();
}

class _SignUpBusinessScreenState extends State<SignUpBusinessScreen> {
  final TextEditingController _businessNumberController =
      TextEditingController();
  final TextEditingController _representativeNameController =
      TextEditingController();
  final TextEditingController _openingDateController = TextEditingController();
  final TextEditingController _businessAddressController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("사업자 정보"),
            TextField(
              controller: _businessNumberController,
              decoration: InputDecoration(
                labelText: "사업자 등록 번호",
                hintText: "사업자 등록 번호를 입력하세요",
              ),
            ),
            TextField(
              controller: _representativeNameController,
              decoration: InputDecoration(
                labelText: "대표자 성명",
                hintText: "대표자의 성명을 입력하세요",
              ),
            ),
            TextField(
              controller: _openingDateController,
              decoration: InputDecoration(
                labelText: "개업일자",
                hintText: "개업일자를 입력하세요",
              ),
            ),
            TextField(
              controller: _businessAddressController,
              decoration: InputDecoration(
                labelText: "사업장 주소",
                hintText: "사업장 주소를 입력하세요",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _confirmBusinessInfo,
              child: Text("확인"),
            ),
            SizedBox(height: 40),
            Text("추가 정보"),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: "전화 번호",
                hintText: "전화 번호를 입력하세요",
              ),
            ),
            TextField(
              controller: _businessNameController,
              decoration: InputDecoration(
                labelText: "사업 명",
                hintText: "사업 명을 입력하세요",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text("제출"),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmBusinessInfo() {
    // 사업자 정보 확인 로직
    print("사업자 정보가 확인되었습니다.");
  }

  void _submitForm() {
    // 폼 제출 로직
    print("폼 데이터를 제출합니다.");
    print("사업자 등록 번호: ${_businessNumberController.text}");
    print("대표자 성명: ${_representativeNameController.text}");
    print("개업일자: ${_openingDateController.text}");
    print("사업장 주소: ${_businessAddressController.text}");
    print("전화 번호: ${_phoneNumberController.text}");
    print("사업 명: ${_businessNameController.text}");
  }
}
