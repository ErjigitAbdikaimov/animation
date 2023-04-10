import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFullSan = false;
  bool isDayMood = true;
  Duration duration = Duration(seconds: 4);

  Future<void> changeMode(int value) async {
    if (value == 0) {
      setState(() {
        isFullSan = true;
      });
    } else {
      setState(() {
        isFullSan = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Future<void>.delayed(duration);
        await changeMode(0);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Color> lightBgColors = [
      const Color(0xFF8C2480),
      const Color(0xFFCE585D),
      const Color(0xFFFF9485),
      if (isFullSan) const Color(0xFFFF9D80)
    ];

    List<Color> darkBgColors = [
      const Color(0xFF0D1441),
      const Color(0xFF283584),
      const Color(0xFF376AB2),
    ];

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AnimatedContainer(
        width: width,
        height: height,
        curve: Curves.easeInOut,
        duration: duration,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isFullSan ? lightBgColors : darkBgColors,
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: isFullSan ? 320 : -180,
              duration: duration,
              child: SvgPicture.asset('sun.svg'),
            ),
            Positioned(
              bottom: -70,
              left: 0,
              right: 0,
              child: Image.asset(
                'land.png',
                height: 430,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              width: width,
              height: 60,
              margin: EdgeInsets.fromLTRB(28, 48, 20, 0),
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10)),
              child: DefaultTabController(
                length: 2,
                child: TabBar(
                    onTap: (value) async {
                      changeMode(value);
                    },
                    indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    indicatorColor: Colors.transparent,
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                    tabs: [
                      Tab(text: 'kun'),
                      Tab(text: 'tun'),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
