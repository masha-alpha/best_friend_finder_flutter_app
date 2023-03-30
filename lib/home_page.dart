// ignore_for_file: prefer_const_constructors

import 'package:best_friend_finder/widgets/tinder_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'widgets/card.dart';
import 'TinderSwipe/candidate_model.dart';
import 'Location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CardSwiperController controller = CardSwiperController();

  final cards = candidates.map((candidate) => CardTinder(candidate)).toList();
  final CheckLocation checkLocation = CheckLocation();
  final Permission _permission = Permission.locationAlways;
  PermissionStatus _permissionStatus = PermissionStatus.granted;
  late final Permission locationPermission = Permission.locationAlways;

  var country = '';
  var city = '';
  var locationMessage = '';

  void _listenForPermissionStatus() async {
    final status = await _permission.status;
    setState(() => _permissionStatus = status);
  }

  void checkServiceStatus(
      BuildContext context, PermissionWithService permission) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text((await permission.serviceStatus).toString()),
    ));
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();

    setState(() {
      print(status);
      _permissionStatus = status;
      print(_permissionStatus);
    });
  }

  Future getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];
    print(lastPosition);

    print(place);
    setState(() {
      locationMessage = "Lat: ${position.latitude},Long: ${position.longitude}";
      country = "${place.country}";
      city = "${place.locality}";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    requestPermission(_permission);
    getCurrentLocation();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[50],
        elevation: 0,
        toolbarHeight: 60,
        title: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 37),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Text(
                        "LOCATION",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: const Color(0xfff25c93),
                    ),
                    Text(
                      "${city}, ",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff29284f),
                      ),
                    ),
                    Text(
                      country,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff29284f),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                Icons.notifications,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 80,
                ),
                SizedBox(
                  height: 50,
                  width: 280,
                  child: Padding(
                    padding: EdgeInsets.only(left: 21),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xfff25c93),
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.view_list_rounded,
                    color: Color(0xff29284f),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 465,
              width: 340,
              child: Stack(
                children: [
                  CardSwiper(
                    controller: controller,
                    cardsCount: cards.length,
                    numberOfCardsDisplayed: 4,
                    cardBuilder: (context, index) => cards[index],
                  ),
                  Positioned(
                    left: 90,
                    right: 0,
                    top: 330,
                    bottom: 0,
                    child: Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          backgroundColor:
                              const Color.fromARGB(255, 245, 166, 195),
                          child: const Icon(
                            CupertinoIcons.multiply,
                            size: 30,
                            color: Color(0xfff25c93),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: const Color(0xfff25c93),
                          child: const Icon(
                            CupertinoIcons.heart_fill,
                            size: 30,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 30,
              width: double.infinity,
              margin: EdgeInsets.only(left: 30),
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Icon(
                    Icons.home_filled,
                    color: Color(0xfff25c93),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Icon(
                    CupertinoIcons.heart_fill,
                    color: Color(0xffd3e8f4),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Icon(
                    CupertinoIcons.chat_bubble_text_fill,
                    color: Color(0xffd3e8f4),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Icon(
                    Icons.person,
                    color: Color(0xffd3e8f4),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
