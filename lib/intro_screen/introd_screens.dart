import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:best_friend_finder/intro_screen/page_indicator.dart';
import 'package:best_friend_finder/intro_screen/introd_screen.dart';

// ignore: constant_identifier_names
enum IndicatorType { CIRCLE, LINE, DIAMOND }

enum FooterShape { NORMAL, CURVED_TOP, CURVED_BOTTOM }

class IntroScreens extends StatefulWidget {
//  PageController get controller => this.createState()._controller;

  @override
  _IntroScreensState createState() => _IntroScreensState();

  ///sets the indicator type for your slides
  ///[IndicatorType]
  final IndicatorType indicatorType;

  ///sets the next widget, the one used to move to the next screen
  ///[Widget]
  final Widget? nextWidget;

  ///sets the done widget, the one used to end the slides
  ///[Widget]
  final Widget? doneWidget;

  final String appTitle;

  ///set the radius of the footer part of your slides
  ///[double]
  final double footerRadius;

  ///sets the viewport fraction of your controller
  ///[double]
  final double viewPortFraction;

  ///sets your slides
  ///[List<IntroScreen>]
  final List<IntroScreen> slides;

  ///sets the skip widget text
  ///[String]
  final String skipText;

  ///defines what to do when the skip button is tapped
  ///[Function]
  final Function? onSkip;

  ///defines what to do when the last slide is reached
  ///[Function]
  final Function onDone;

  /// set the color of the active indicator
  ///[Color]
  final Color activeDotColor;

  ///set the color of an inactive indicator
  ///[Color]
  final Color? inactiveDotColor;

  ///sets the padding of the footer part of your slides
  ///[EdgeInsets]
  final EdgeInsets footerPadding;

  ///sets the background color of the footer part of your slides
  ///[Color]
  final Color footerBgColor;

  ///sets the text color of your slides
  ///[Color]
  final Color textColor;

  ///sets the colors of the gradient for the footer widget of your slides
  ///[List<Color>]
  final List<Color> footerGradients;

  ///[ScrollPhysics]
  ///sets the physics for the page view
  final ScrollPhysics physics;

  ///[Color]
  ///sets the wrapper container's background color, defaults to white
  final Color containerBg;

  const IntroScreens({
    required this.slides,
    this.footerRadius = 12.0,
    this.footerGradients = const [],
    this.containerBg = Colors.white,
    required this.onDone,
    this.indicatorType = IndicatorType.CIRCLE,
    this.appTitle = '',
    this.physics = const BouncingScrollPhysics(),
    this.onSkip,
    this.nextWidget,
    this.doneWidget,
    this.activeDotColor = Colors.white,
    this.inactiveDotColor,
    this.skipText = 'skip',
    this.viewPortFraction = 1.0,
    this.textColor = Colors.black,
    this.footerPadding = const EdgeInsets.all(24),
    this.footerBgColor = const Color(0xff51adf6),
  }) : assert(slides.length > 0);
}

class _IntroScreensState extends State<IntroScreens>
    with TickerProviderStateMixin {
  PageController? _controller;
  double? pageOffset = 0;
  int currentPage = 0;
  bool lastPage = false;
  late AnimationController animationController;
  IntroScreen? currentScreen;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: widget.viewPortFraction,
    )..addListener(() {
        pageOffset = _controller!.page;
      });

    currentScreen = widget.slides[0];
    animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
  }

  get onSkip => this.widget.onSkip != null ? this.widget.onSkip : defaultOnSkip;

  defaultOnSkip() => animationController.animateTo(
        widget.slides.length - 1,
        duration: Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );

  TextStyle get textStyle =>
      currentScreen!.textStyle ??
      Theme.of(context).textTheme.bodyText1 ??
      GoogleFonts.lato(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );

  Widget get next =>
      this.widget.nextWidget ??
      Icon(
        Icons.arrow_forward,
        size: 28,
        color: widget.textColor,
      );

  Widget get done =>
      this.widget.doneWidget ??
      Icon(
        Icons.check,
        size: 28,
        color: widget.textColor,
      );

  @override
  void dispose() {
    _controller!.dispose();
    animationController.dispose();
    super.dispose();
  }

  bool get existGradientColors => widget.footerGradients.length > 0;

  LinearGradient get gradients => existGradientColors
      ? LinearGradient(
          colors: widget.footerGradients,
          begin: Alignment.topLeft,
          end: Alignment.topRight)
      : LinearGradient(
          colors: [
            widget.footerBgColor,
            widget.footerBgColor,
          ],
        );

  int getCurrentPage() => _controller!.page!.floor();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor:
            currentScreen?.headerBgColor.withOpacity(.0) ?? Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor:
            currentScreen?.headerBgColor ?? Colors.transparent,
      ),
      child: Container(
        color: this.widget.containerBg,
//        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            PageView.builder(
              itemCount: widget.slides.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                  currentScreen = widget.slides[currentPage];
                  setState(() {
                    currentScreen!.index = currentPage + 1;
                  });
                  if (currentPage == widget.slides.length - 1) {
                    lastPage = true;
                    animationController.forward();
                  } else {
                    lastPage = false;
                    animationController.reverse();
                  }
                });
              },
              controller: _controller,
              physics: widget.physics,
              itemBuilder: (context, index) {
                if (index == pageOffset!.floor()) {
                  return AnimatedBuilder(
                      animation: _controller!,
                      builder: (context, _) {
                        return buildPage(
                          index: index,
                          angle: pageOffset! - index,
                        );
                      });
                } else if (index == pageOffset!.floor() + 1) {
                  return AnimatedBuilder(
                    animation: _controller!,
                    builder: (context, _) {
                      return buildPage(
                        index: index,
                        angle: pageOffset! - index,
                      );
                    },
                  );
                }
                return buildPage(index: index);
              },
            ),
            //footer widget
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height * .64,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 100, 24),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(45),
                      topLeft: Radius.circular(45),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                  color: Colors.white,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 15, 0),
                        child: Text(
                          currentScreen!.title!,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xff29284f),
                            fontWeight: FontWeight.w900,
                            fontSize: 31,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 20, 24),
                        child: Text(
                          currentScreen!.description!,
                          softWrap: true,
                          style: textStyle.apply(
                            color: const Color(0xffbdbdbd),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //controls widget
            Positioned(
              left: 0,
              right: 0,
              bottom: 18,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                child: Container(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Material(
                        clipBehavior: Clip.antiAlias,
                        type: MaterialType.transparency,
                        child: lastPage
                            ? ElevatedButton(
                                onPressed: widget.onDone as void Function()?,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xfff25c93),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  fixedSize: const Size(120, 40),
                                ),
                                child: const Text('Get Started'),
                              )
                            : Container(),
                      ),
                      Container(
                        margin: lastPage
                            ? const EdgeInsets.fromLTRB(30, 0, 10, 0)
                            : const EdgeInsets.fromLTRB(75, 0, 0, 0),
                        width: 160,
                        child: PageIndicator(
                          type: widget.indicatorType,
                          currentIndex: currentPage,
                          activeDotColor: widget.activeDotColor,
                          inactiveDotColor: widget.inactiveDotColor ??
                              widget.activeDotColor.withOpacity(.5),
                          pageCount: widget.slides.length,
                          onTap: () {
                            _controller!.animateTo(
                              _controller!.page!,
                              duration: const Duration(
                                milliseconds: 400,
                              ),
                              curve: Curves.fastOutSlowIn,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //app title
            /*Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  widget.appTitle,
                  style: textStyle.apply(
                      fontSizeDelta: 12, fontWeightDelta: 8, color: Colors.red),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget buildPage(
      {required int index, double angle = 0.0, double scale = 1.0}) {
    // print(pageOffset - index);
    return Container(
      color: const Color(0xfff25c93),
      child: Transform(
          child: widget.slides[index],
          transform: Matrix4.identity()..setEntry(3, 2, .001)
          //..rotateY(angle),
          ),
    );
  }
}
