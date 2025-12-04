import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MurshidScreen extends StatelessWidget {
  const MurshidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Murshid'),
        titleTextStyle: TextStyle(
          color: Color(0xff3D4032),
          fontSize: 25.9,
          fontWeight: .bold,
        ),
        centerTitle: true,
      ),
      drawer: Drawer(),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: .start,
          children: [
            Gap(61),
            Text('Hi there!'),
            Text('I’m Murshid، your AI assistant'),
            Text('How can I help you today?'),

            Gap(40),
            GestureDetector(
              onTap: () {
                context.go('/chat');
              },
              child: Container(
                width: 388,
                height: 72,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0x1A656A53),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF656A53)),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('Assets/icons/murshid_trip.svg'),
                    Gap(10),
                    Text('Plan My Trip'),
                  ],
                ),
              ),
            ),
            Gap(15),
            GestureDetector(
                onTap: () {
                context.go('/ai-image-analysis-screen');
              },
              child: Container(
                width: 388,
                height: 72,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0x1A656A53),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF656A53)),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('Assets/icons/murshid_image.svg'),
                    Gap(10),
                    Text('Identify The Image'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
