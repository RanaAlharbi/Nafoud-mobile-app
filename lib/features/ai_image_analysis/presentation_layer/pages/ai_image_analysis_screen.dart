import 'package:dashed_border/dashed_border.dart';
import 'package:final_project/features/ai_image_analysis/domain_layer/usecase/ai_image_analysis_usecase.dart';
import 'package:final_project/features/ai_image_analysis/presentation_layer/widgets/mark_down_card.dart';
import 'package:final_project/features/murshid/presentation/widget/image_source_picker_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/ai_image_analysis/presentation_layer/cubit/ai_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

class AIImageAnalysisScreen extends StatelessWidget {
  const AIImageAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AIImageCubit(GetIt.I.get<AnalyzeImageUseCase>()),
      child: Builder(
        builder: (context) {
          final cubit = context.read<AIImageCubit>();

          return Scaffold(
            appBar: AppBar(
              title: Text('Murshid'),
              titleTextStyle: GoogleFonts.cairo(
                color: const Color(0xff3D4032),
                fontSize: 25.9,
                fontWeight: FontWeight.bold,
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
              ),
            ),

            body: Padding(
              padding: const EdgeInsets.all(26),

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(21),

                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/murshid_trip.svg'),
                        const Gap(18),
                        Text(
                          'Identify The Image',
                          style: GoogleFonts.cairo(
                            color: const Color(0xff656A53),
                            fontSize: 31,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const Gap(57),

                    // image pick
                    BlocBuilder<AIImageCubit, AIImageState>(
                      builder: (context, state) {
                        final selectedImage = cubit.selectedImage;

                        if (selectedImage != null) {
                      
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              selectedImage,
                              width: double.infinity,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                          );
                        }

                   
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              barrierColor: Colors.transparent,
                              builder: (context) =>
                                ImageSourcePickerSheet(cubit: cubit),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 220,
                            decoration: BoxDecoration(
                              border: DashedBorder(
                                color: const Color(0xff656A53),
                                width: 2,
                                dashLength: 8,
                                dashGap: 5,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.grey[200],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/Upload_image.png'),
                                  const Gap(32),
                                  Text("Take or Upload Your Image Here", 
                                  style: GoogleFonts.cairo(
                                    fontSize: 21,
                                    fontWeight: .w600
                                  )),
                                   Text("Browse", style: GoogleFonts.cairo(
                                    fontSize: 18,
                                    fontWeight: .w600,
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff656A53)
                                  )),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const Gap(20),

                    //Ai response
                    BlocBuilder<AIImageCubit, AIImageState>(
                      builder: (context, state) {
                        if (state is AIImageLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is AIImageSuccess) {
                          return markDownCard(state.analysis.text);
                        }

                        if (state is AIImageHistoryLoaded) {
                          return markDownCard(state.history.last);
                        }

                        if (state is AIImageError) {
                          return Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}