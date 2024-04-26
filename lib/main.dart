import 'package:bmi_tracker_app/features/auth/controllers/sign_in_cubit/sign_in_cubit.dart';
import 'package:bmi_tracker_app/features/auth/screens/splash_screen.dart';
import 'package:bmi_tracker_app/features/home/controllers/add_update_delete_bmi_result_cubit/add_update_delete_bmi_result_cubit.dart';
import 'package:bmi_tracker_app/features/home/controllers/get_bmi_results_cubit/get_bmi_results_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/controllers/sign_out_cubit/sign_out_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>SignInCubit()),
        BlocProvider(create: (_)=>SignOutCubit()),
        BlocProvider(create: (_)=>AddUpdateDeleteBmiResultCubit()),
        BlocProvider(create: (_)=>GetBmiResultsCubit()),
      ], 
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}