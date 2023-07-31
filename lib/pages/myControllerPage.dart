import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:starbhakpiket/pages/absensiPage.dart';
import 'package:starbhakpiket/pages/homePage.dart';
import 'package:starbhakpiket/pages/keterlambatanPage.dart';
import 'package:starbhakpiket/pages/rekapitulasiPage.dart';
import 'auth/profilePage.dart';

class MyControllerPage extends StatefulWidget {
  const MyControllerPage({super.key});

  @override
  State<MyControllerPage> createState() => _MyControllerPageState();
}

class _MyControllerPageState extends State<MyControllerPage> {
  final PageController _pageController = PageController(initialPage: 2);

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);

  int _selectedItemPosition = 2;
  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = const Color(0xff7F669D);
  Color unselectedColor = const Color(0xff7F669D);

  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);
  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  Color? containerColor;
  List<Color> containerColors = [
    const Color(0xFFFDE1D7),
    const Color(0xFFE4EDF5),
    const Color(0xFFE7EEED),
    const Color(0xFFF4E4CE),
  ];

  Map<String, bool> _isChecked =
      Map<String, bool>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: 5,
        onPageChanged: (index) {
          setState(() {
            _selectedItemPosition = index;
          });
        },
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return const RekapitulasiPage();
            case 1:
              return const KeterlambatanPage();
            case 2:
              return const HomePage();
            case 3:
              return AbsensiPage(isChecked: _isChecked);
            case 4:
              return const ProfilePage();
            default:
              throw ArgumentError('Invalid index');
          }
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3),
                spreadRadius: -10,
                blurRadius: 3,
                color: Color.fromRGBO(217, 216, 216, 1),
              )
            ]),
        child: SnakeNavigationBar.color(
          behaviour: snakeBarStyle,
          snakeShape: snakeShape,
          shape: bottomBarShape,
          padding: padding,
          snakeViewColor: selectedColor,
          selectedItemColor:
              snakeShape == SnakeShape.indicator ? selectedColor : null,
          unselectedItemColor: unselectedColor,
          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,
          currentIndex: _selectedItemPosition,
          onTap: (index) {
            if (!_pageController.hasClients)
              return;
            setState(() {
              _selectedItemPosition = index;
            });
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOut,
            );
          },
          items: [
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/export.png'),
                activeIcon: Image.asset('assets/images/export-white.png'),
                label: 'export'),
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/report.png'),
                activeIcon: Image.asset('assets/images/report-white.png'),
                label: 'report'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/student.png'),
                activeIcon: Image.asset('assets/images/student-white.png'),
                label: 'student'),
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/user.png'),
                activeIcon: Image.asset('assets/images/user-white.png'),
                label: 'user')
          ],
          selectedLabelStyle: const TextStyle(fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}

class PagerPageWidget extends StatelessWidget {
  final String? text;
  final String? description;
  final Image? image;
  final TextStyle titleStyle =
      const TextStyle(fontSize: 40, fontFamily: 'SourceSerifPro');
  final TextStyle subtitleStyle = const TextStyle(
    fontSize: 20,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w200,
  );

  const PagerPageWidget({
    Key? key,
    this.text,
    this.description,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text!,
        style: titleStyle,
      ),
    );
  }
}
