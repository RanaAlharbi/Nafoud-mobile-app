import 'package:flutter/cupertino.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TimerCountdown(
      endTime: DateTime.now().add(const Duration(minutes: 1, seconds: 30)),
      onEnd: () {
        print("Timer finished");
      },
    );
  }
}
