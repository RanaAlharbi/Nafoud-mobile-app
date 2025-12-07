import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:final_project/features/gathering/presentation/cubit/gathering_cubit.dart';
import 'package:final_project/features/gathering/presentation/pages/add_events.dart';
import 'package:final_project/features/gathering/presentation/widget/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

class GatheringScreen extends StatelessWidget {
  const GatheringScreen({super.key});

  final List<String> categories = const ['All', 'Cultural', 'Sports', 'Arts'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GatheringCubit>()..fetchEvents(),

      child: Builder(
        builder: (providerContext) {
          return DefaultTabController(
            length: categories.length,

            child: Scaffold(
              backgroundColor: const Color(0xFFF0F0EE),

              appBar: AppBar(
                backgroundColor: const Color(0xFFF0F0EE),
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "Gather",
                  style: GoogleFonts.cairo(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff3D4032),
                  ),
                ),
              ),

              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Expanded(child: SearchBarWidget()),
                        const Gap(13),

                        _circleBtn('Assets/icons/murshid_image.svg'),
                        const Gap(12),
                        _circleBtn('Assets/icons/filter-horizontal.svg'),
                      ],
                    ),
                  ),

                  const Gap(15),

                //chips
                  SizedBox(
                    height: 45,
                    child: TabBar(
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                      tabs: categories.map((cat) {
                        return Tab(
                          child: Chip(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            label: Text(cat),
                            backgroundColor: const Color(0xFFE3E3DF),
                            labelStyle: const TextStyle(
                              color: Color(0xFF4A4A41),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const Gap(10),

                  Expanded(
                    child: TabBarView(
                      children: categories.map((category) {
                        return BlocBuilder<GatheringCubit, GatheringState>(
                          builder: (context, state) {
                            if (state is GatheringLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (state is GatheringLoaded) {
                              final filtered = category == 'All'
                                  ? state.events
                                  : state.events
                                      .where((e) => e.category == category)
                                      .toList();

                              if (filtered.isEmpty) {
                                return const Center(
                                  child: Text('No events found'),
                                );
                              }

                              return ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: filtered.length,
                                itemBuilder: (context, index) {
                                  final event = filtered[index];
                                  return _eventCard(
                                    title: event.title,
                                    city: event.city,
                                    date: event.date,
                                    image: event.imageUrl,
                                    category: event.category,
                                  );
                                },
                              );
                            }

                            if (state is GatheringError) {
                              return Center(child: Text(state.message));
                            }

                            return const SizedBox();
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),

              floatingActionButton: FloatingActionButton(
                backgroundColor: const Color(0xFF656A53),
                onPressed: () {
                  Navigator.push(
                    providerContext,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: providerContext.read<GatheringCubit>(),
                        child: const AddEventScreen(),
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          );
        },
      ),
    );
  }

  // button 
  Widget _circleBtn(String iconPath) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFE3E3DF),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF656A53)),
      ),
      child: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
        fit: BoxFit.scaleDown,
      ),
    );
  }

  //events card
  Widget _eventCard({
    required String title,
    required String city,
    required String date,
    required String category,
    required String image,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
                child: Image.network(
                  image,
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade300,
                    height: 170,
                    child: const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),

              // date corner
              Positioned(
                left: 14,
                top: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B6F52),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    date.replaceAll("-", "\n"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),

              // bookmark
              Positioned(
                right: 14,
                top: 14,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6B6F52),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.bookmark,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "$title | $category",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A4A41),
              ),
            ),
          ),

          const SizedBox(height: 6),

          // city
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.location_pin,
                  size: 17,
                  color: Color(0xFF6B6F52),
                ),
                const SizedBox(width: 5),
                Text(
                  city,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4A4A41),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF6B6F52),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  "View details",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
