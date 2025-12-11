import 'package:final_project/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:final_project/features/weather/presentation/cubit/weather_state.dart';
import 'package:final_project/features/weather/presentation/widgets/weather_content.dart';
import 'package:final_project/features/weather/presentation/widgets/weather_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WeatherCubit>();

    // Load initial weather data for specific cities
    if (context.read<WeatherCubit>().state is WeatherInitialState) {
      cubit.loadAllCitiesWeather();
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 238, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(240, 240, 238, 1),
        title: const Text(
          "Weather",
          style: TextStyle(
            fontWeight: FontWeight.bold,
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
          padding: EdgeInsets.all(16.w),
          child: BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              return Column(
                children: [
                  // Search Bar
                  WeatherSearchBar(
                    onChanged: (value) {
                      cubit.filterCities(value);
                    },
                  ),
                  Gap(16.h),

                  // Weather Content
                  Expanded(child: WeatherContent(state: state)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
