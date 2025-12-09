import 'package:final_project/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = context.read<WeatherCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather",
          style: TextStyle(
            fontWeight: .bold,
            color: Color.fromRGBO(30, 30, 30, 1),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset('Assets/icons/arrow_left.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      
      // Here's the body starts
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: []),
        ),
      ),
    );
  }
}
