import 'package:animation_trainig/signin_screen_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController sizeController;
  late AnimationController positionController;
  late AnimationController widgetController;
  late Animation<double> _sizeAnimation;
  late Animation<double> _raduis;
  late Animation<Offset> _offset;
  late Animation<Offset> _widgetOffset;
  late Animation<double> _opacity;
  bool visible = false;
  @override
  void initState() {
    super.initState();

    // animated container animation

    sizeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _sizeAnimation = Tween<double>(begin: 25, end: 150).animate(sizeController);
    _raduis = Tween<double>(begin: 300, end: 0).animate(sizeController);

    // slide transition animation

    positionController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400));
    _offset =
        Tween<Offset>(begin: const Offset(0, -30), end: const Offset(0, 0))
            .animate(CurvedAnimation(
                parent: positionController, curve: Curves.bounceInOut));

    // show widgets of column

    widgetController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _widgetOffset = Tween<Offset>(
            begin: const Offset(0, 0.6), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: widgetController, curve: Curves.ease));

    _opacity = Tween<double>(begin: 0, end: 1).animate(widgetController);

    // show the animations

    positionController.forward();
    positionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 250), () {
          _sizeAnimation = Tween<double>(begin: 25, end: 1400).animate(
              // 1400 is the biggest height for tablet devices
              CurvedAnimation(
                  parent: sizeController, curve: Curves.bounceInOut));
          sizeController.forward();
        });
      }
      _sizeAnimation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            visible = true;
          });
          widgetController.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    sizeController.dispose();
    positionController.dispose();
    widgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: sizeController,
          builder: (_, child) {
            return SlideTransition(
              position: _offset,
              child: AnimatedContainer(
                curve: Curves.elasticOut,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFF00CC),
                        Color(0xFF333399),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(_raduis.value)),
                duration: sizeController.duration!,
                height: _sizeAnimation.value,
                width: _sizeAnimation.value,
                padding: const EdgeInsets.all(20),
                child: AnimatedBuilder(
                    animation: widgetController,
                    builder: (_, child) {
                      return SlideTransition(
                          position: _widgetOffset,
                          child: Visibility(
                              visible: visible,
                              child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeIn,
                                  opacity: _opacity.value,
                                  child: const SigninScreenWidgets())));
                    }),
              ),
            );
          },
        ),
      ),
    );
  }
}
