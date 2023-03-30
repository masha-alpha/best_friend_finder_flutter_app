import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:best_friend_finder/TinderSwipe/candidate_model.dart';

class CardTinder extends StatelessWidget {
  final CandidateModel candidate;

  const CardTinder(
    this.candidate, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      width: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            // child: Padding(
            //   padding: const EdgeInsets.fromLTRB(70, 5, 10, 10),
            //   child: Row(
            //     children: [
            //       FloatingActionButton(
            //         onPressed: () {},
            //         backgroundColor: const Color.fromARGB(255, 245, 166, 195),
            //         child: const Icon(
            //           CupertinoIcons.multiply,
            //           size: 30,
            //           color: Color(0xfff25c93),
            //         ),
            //       ),
            //       const SizedBox(
            //         width: 40,
            //       ),
            //       FloatingActionButton(
            //         onPressed: () {},
            //         backgroundColor: const Color(0xfff25c93),
            //         child: const Icon(
            //           CupertinoIcons.heart_fill,
            //           size: 30,
            //           color: Colors.white,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          ),
          Positioned(
            left: 7,
            top: 8,
            right: 7,
            bottom: 80,
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xfff25c93),
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/pic21.jpg',
                    ),
                    fit: BoxFit.cover,
                  )),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
                child: Container(
                  padding: const EdgeInsets.only(right: 145, top: 10),
                  height: 30,
                  width: 20,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                          Colors.black87
                        ]),
                  ),
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'Misellia, 22',
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        'Dancer , friendly',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w200),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
