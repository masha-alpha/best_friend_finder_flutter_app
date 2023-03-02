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
      footerBgColor: Colors.white.withOpacity(.8),
      activeDotColor: Colors.pink[300]!,
      footerRadius: 18.0,
//      indicatorType: IndicatorType.CIRCLE,
      slides: [
        IntroScreen(
          title: 'Search',
          imageAsset: 'assets/pic5.png',
          description: 'Quickly find all your messages',
          headerBgColor: Colors.pink[300]!,
        ),
        IntroScreen(
          title: 'Focused Inbox',
          headerBgColor: Colors.pink[300]!,
          imageAsset: 'assets/pic6.png',
          description: "We've put your most important, actionable emails here",
        ),
        IntroScreen(
          title: 'Social',
          headerBgColor: Colors.pink[300]!,
          imageAsset: 'assets/guys_pic2.png',
          description: "Keep talking with your mates",
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
