import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/features/my_activity/presentation/cubit/my_activity_cubit.dart';

class MyActivityFeatureScreen extends StatelessWidget {
  const MyActivityFeatureScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final _ = context.read<MyActivityCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyActivity Feature Screen'),
        leading: BackButton(),
      ),
      body: Column(children: [
          
        ],
      ),
    );
  }
}
