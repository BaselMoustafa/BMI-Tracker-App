import 'package:bmi_tracker_app/core/managers/color_manager.dart';
import 'package:bmi_tracker_app/features/auth/controllers/sign_out_cubit/sign_out_cubit.dart';
import 'package:flutter/material.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        SignOutCubit.get(context).signOut();
      }, 
      icon: const Icon(
        Icons.logout,
        color: ColorManager.primary,
      ),
    );
  }
}