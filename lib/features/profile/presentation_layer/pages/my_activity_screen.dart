import 'package:flutter/material.dart';

class MyActivityScreen extends StatelessWidget {
  const MyActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(leading: BackButton()));
  }
}
