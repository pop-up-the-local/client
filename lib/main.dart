import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pop_up_the_local/screens/application_screen.dart';
import 'package:pop_up_the_local/screens/home_screen.dart';
import 'package:pop_up_the_local/screens/pop_up_detailed_screen.dart';
import 'package:pop_up_the_local/screens/pop_up_list_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pop_up_the_local/screens/sign_up_customer_screen.dart';
import 'screens/boomark_screen.dart';
import 'screens/sign_up_business_screen.dart';

import 'screens/image_upload_screen.dart';
import 'screens/my_page_screen.dart';
import 'style/theme.dart';

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');
  await initializeDateFormatting();

  runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness:
          Brightness.light // Dark == white status bar -- for IOS.
      ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentBottomNavIndex = 0;

  static const List<Widget> _screenList = [
    HomeScreen(),
    //PopUpDetailedScreen(),
    PopUpListScreen(),
    //ApplicationScreen(),
    //ImageUploadScreen(),
    //MyPageScreen(),
    //SignUpBusinessScreen(),
    //SignUpCustomerScreen(),
    BookmarkScreen(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() => _currentBottomNavIndex = index);
  }

  Future<bool> _onWillPop() async {
    if (_currentBottomNavIndex != 0) {
      setState(() => _currentBottomNavIndex = 0);
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: SafeArea(
        top: false,
        bottom: false,
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            bottomNavigationBar: Container(
              child: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: '홈',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: '둘러보기',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.info),
                    label: '마이페이지',
                  ),
                ],
                currentIndex: _currentBottomNavIndex,
                onTap: _onBottomNavTapped,
              ),
            ),
            body: _screenList.elementAt(_currentBottomNavIndex),
          ),
        ),
      ),
    );
  }
}
