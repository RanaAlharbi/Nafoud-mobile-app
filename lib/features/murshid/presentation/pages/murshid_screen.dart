import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MurshidScreen extends StatelessWidget {
  const MurshidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Murshid'),
        titleTextStyle: GoogleFonts.cairo(
          color: Color(0xff3D4032),
          fontSize: 25.9,
          fontWeight: .bold,
        ),
        centerTitle: true,
      ),
      drawer: Drawer(),

      body: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: .start,
          children: [
            Gap(61),
            Text(
              'Hi there!',
              style: GoogleFonts.cairo(fontSize: 25.92, fontWeight: .bold),
            ),
            RichText(
              text: TextSpan(
                style: GoogleFonts.cairo(
                  fontSize: 25.92,
                  fontWeight: .bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(text: 'I’m '),
                  TextSpan(
                    text: 'Murshid',
                    style: GoogleFonts.cairo(
                      color: Color(0xff656A53),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: ', your AI assistant'),
                ],
              ),
            ),

            Gap(14),

            Text(
              'How can I help you today?',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff919191),
              ),
            ),

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
                    SvgPicture.asset('assets/icons/murshid_trip.svg'),
                    Gap(10),
                    Text(
                      'Plan My Trip',
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        color: Color(0xff656A53),
                       
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(15),
            GestureDetector(
              onTap: () {
                context.push('/ai-image-analysis-screen');
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
                    SvgPicture.asset('assets/icons/murshid_image.svg'),
                    Gap(10),
                    Text(
                      'Identify The Image',
                      style: GoogleFonts.cairo(
                        color: Color(0xff656A53), 
                        fontSize: 18),
                    ),
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
