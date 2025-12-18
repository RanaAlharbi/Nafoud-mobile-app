import 'package:easy_localization/easy_localization.dart';
import 'package:final_project/core/di/configure_dependencies.dart';
import 'package:final_project/features/emergency/presentation_layer/cubit/emergency_cubit.dart';
import 'package:final_project/features/emergency/presentation_layer/cubit/emergency_state.dart';
import 'package:final_project/features/emergency/presentation_layer/widgets/embassy_dropdown_card.dart';
import 'package:final_project/features/emergency/presentation_layer/widgets/emergency_card.dart';
import 'package:final_project/features/emergency/presentation_layer/widgets/emergency_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  String _getIconUrl(String contactName) {
    // Map contact names to images
    final iconMap = {
      // Local Assets
      'Police': 'assets/Images/emergency/police.png',
      'Traffic Police': 'assets/Images/emergency/Traffic_Police.png',
      'Traffic patrols': 'assets/Images/emergency/Traffic_Patrols.png',
      'Civil Defence': 'assets/Images/emergency/Civil_Defense.png',
      'Roads Security': 'assets/Images/emergency/Road_Security.png',
      'CPVPV': 'assets/Images/emergency/CPVPV.png',
      'Ministry of Health': 'assets/Images/emergency/Ministry_of_Health.png',

      // Fallback to default for unmapped contacts
      'Police (Riyadh, Makkah, Medina, and East of Saudi Arabia)': 'assets/Images/emergency/police.png',
      'Police other countries': 'assets/Images/emergency/police.png',
      'Public Security': 'assets/Images/emergency/police.png',
      'Traffic': 'assets/Images/emergency/Traffic_Police.png',
      'Traffic Violation Inquiries': 'assets/Images/emergency/Traffic_Police.png',
    };

    return iconMap[contactName] ?? '';
  }


  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return BlocProvider(
      create: (context) => getIt<EmergencyCubit>()..loadEmergencyContacts(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(240, 240, 238, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(240, 240, 238, 1),
          title: const Text(
            "Emergency",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(30, 30, 30, 1),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Transform.scale(
              scaleX: isArabic ? -1 : 1,
              child: SvgPicture.asset('assets/icons/arrow_left.svg'),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: BlocBuilder<EmergencyCubit, EmergencyState>(
              builder: (context, state) {
                if (state is EmergencyLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is EmergencyErrorState) {
                  return Center(
                    child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state is EmergencyLoadedState) {
                  return Column(
                    children: [
                      // Search Bar
                      EmergencySearchBar(
                        onChanged: (value) {
                          context.read<EmergencyCubit>().filterContacts(value);
                        },
                      ),
                      Gap(16.h),

                      // Emergency Contacts Grid
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 12.h,
                            childAspectRatio: 0.85,
                          ),
                          itemCount: state.filteredContacts.length,
                          itemBuilder: (context, index) {
                            final contact = state.filteredContacts[index];

                            // Check if it's the embassies contact
                            if (contact.isEmbassy && contact.embassies != null) {
                              return EmbassyDropdownCard(
                                embassies: contact.embassies!,
                                selectedEmbassy: state.selectedEmbassy,
                                onEmbassySelected: (value) {
                                  context.read<EmergencyCubit>().selectEmbassy(value);
                                },
                              );
                            }

                            // Regular emergency contact
                            return EmergencyCard(
                              title: contact.name,
                              number: contact.number,
                              description: state.descriptions[contact.name],
                              iconUrl: _getIconUrl(contact.name),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
