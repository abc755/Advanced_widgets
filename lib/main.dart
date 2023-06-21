import 'package:advanced_widgets/widgets/profile.dart';
import 'package:advanced_widgets/widgets/renderObjectWidget.dart';
import 'package:advanced_widgets/widgets/weather.dart';
import 'package:flutter/material.dart';

import 'models/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  ProfileTheme _currentTheme = themeDay;
  double _currentSliderValue = 0.5;
  late AnimationController _controller;
  late Animation<double> animation;
  late Animation<double> animationPaint;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 1, end: 2.5).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    animationPaint = Tween<double>(begin: 100, end: 180).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileWidget(
      theme: _currentTheme,
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: ProfileWidget.of(context).headerColor,
            titleTextStyle: TextStyle(
                color: ProfileWidget.of(context).textColor, fontSize: 24),
          ),
          body: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                top: 50,
                right: 0,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext _, child) {
                    return Transform.scale(
                      alignment: Alignment.topRight,
                      scale: animation.value,
                      child: child,
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      _controller.forward();
                    },
                    child: SizedBox(
                      height: animationPaint.value,
                      width: animationPaint.value / 2,
                      child: CustomPaint(
                        painter: WeatherWidget(state: _currentSliderValue),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 160,
                left: 50,
                child: InnerShadow(
                  blur: 5,
                  color: const Color(0xFF477C70),
                  offset: const Offset(5, 5),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.red,
                    ),
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Сегодня ${_currentSliderValue <= 0.5 ? 'солнечно' : 'пасмурно'}',
                        style: TextStyle(
                          fontSize: 30,
                          color: ProfileWidget.of(context).textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: (50 + animationPaint.value),
                child: Container(
                  color: _currentTheme.backgroundColor,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Text(
                        'Погода',
                        style: TextStyle(
                            color: ProfileWidget.of(context).textColor,
                            fontSize: 50),
                      ),
                      Slider(
                        value: _currentSliderValue,
                        max: 1,
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderValue = value;
                          });
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (_currentTheme == themeDay) {
                              _currentTheme = themeNight;
                            } else {
                              _currentTheme = themeDay;
                            }
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                ProfileWidget.of(context).buttonColor)),
                        child: Text(
                          'Включить "${_currentTheme == themeDay ? 'Ночной' : 'Дневной'}" режим',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          backgroundColor: ProfileWidget.of(context).backgroundColor,
        );
      }),
    );
  }
}
