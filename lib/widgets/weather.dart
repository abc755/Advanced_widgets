import 'package:flutter/material.dart';

class WeatherWidget extends CustomPainter {
  final double state;

  const WeatherWidget({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final sunPaint = Paint()
      ..color = Colors.yellow.withOpacity(_getSunOpacity(state))
      ..style = PaintingStyle.fill;

    final cloudPaint = Paint()
      ..color = Colors.grey.withOpacity(_getCloudOpacity(state))
      ..style = PaintingStyle.fill;

    final rainPaint = Paint()
      ..color = Colors.blueAccent.withOpacity(_getRainOpacity(state))
      ..style = PaintingStyle.fill
      ..strokeWidth = 3.0;

    //Солнце
    canvas.drawCircle(const Offset(25, 0), 20, sunPaint);

    //Облако
    canvas.drawCircle(const Offset(15, 15), 20, cloudPaint);
    canvas.drawCircle(const Offset(0, 20), 15, cloudPaint);
    canvas.drawCircle(const Offset(35, 20), 15, cloudPaint);

    //Дождь
    canvas.drawLine(const Offset(4, 35), const Offset(0, 50), rainPaint);
    canvas.drawLine(const Offset(20, 35), const Offset(16, 50), rainPaint);
    canvas.drawLine(const Offset(34, 35), const Offset(30, 50), rainPaint);
  }

  double _getSunOpacity(double value) {
    if (value > 0.7) {
      return 0;
    }else if (value < 0.5) {
      return 1;
    }

    return -5 * value + 3.5;
  }

  double _getCloudOpacity(double value) {
    if (value < 0.3) {
      return 0;
    } else if (value > 0.8) {
      return 1;
    } else {
      return 2 * value - 0.6;
    }
  }

  double _getRainOpacity(double value) {
    if (value < 0.7) {
      return 0;
    }

    return 10 / 3 * value - 7 / 3;
  }

  @override
  bool shouldRepaint(WeatherWidget oldDelegate) => state != oldDelegate.state;
}
