import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SimCardScreen extends StatelessWidget {
  const SimCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SIM Card",
          style: TextStyle(
            fontWeight: .bold,
            color: Color.fromRGBO(30, 30, 30, 1),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/arrow_left.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: []),
        ),
      ),
    );
  }
}
