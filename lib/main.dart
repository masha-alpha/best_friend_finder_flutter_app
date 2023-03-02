import 'package:flutter/material.dart';
import 'package:best_friend_finder/intro_screen/introd_screen.dart';
import 'package:best_friend_finder/intro_screen/introd_screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'intro screen demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      );
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var screens = IntroScreens(
      onDone: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NextPage(),
        ),
      ),
      onSkip: () => print('Skipping the intro slides'),
      footerBgColor: const Color(0xfff25c93),
      activeDotColor: const Color(0xfff25c93),
      footerRadius: 35.0,
//      indicatorType: IndicatorType.CIRCLE,
      slides: [
        IntroScreen(
          title: '''Find Your Best\nFriend With Us''',
          imageAsset: 'assets/pic15.png',
          description:
              'Let\'s find your life partner to enjoy life to be better and prosperous!',
          headerBgColor: Colors.white,
        ),
        IntroScreen(
          title: 'Find Your Best\nFriend With Us',
          headerBgColor: Colors.white,
          imageAsset: 'assets/pic14.png',
          description:
              "Let's find your life partner to enjoy life to be better and prosperous!",
        ),
        IntroScreen(
          title: 'Find Your Best\nFriend With Us',
          headerBgColor: Colors.white,
          imageAsset: 'assets/pic5.png',
          description:
              "Let's find your life partner to enjoy life to be better and prosperous!",
        ),
      ],
    );

    return Scaffold(
      body: screens,
    );
  }
}

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
      );
}
