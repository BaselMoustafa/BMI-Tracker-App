import 'package:bmi_tracker_app/core/managers/color_manager.dart';
import 'package:bmi_tracker_app/core/managers/navigator_manager.dart';
import 'package:bmi_tracker_app/core/widgets/block_interaction_loading_widget.dart';
import 'package:bmi_tracker_app/core/widgets/custom_button.dart';
import 'package:bmi_tracker_app/core/widgets/show_my_snackbar.dart';
import 'package:bmi_tracker_app/features/auth/controllers/sign_in_cubit/sign_in_cubit.dart';
import 'package:bmi_tracker_app/features/auth/controllers/sign_in_cubit/sign_in_cubit_states.dart';
import 'package:bmi_tracker_app/features/home/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit,SignInCubitStates>(
      listener: _listener,
      builder: _builder,
    );
  }

  void _listener(BuildContext context, SignInCubitStates state) {
    if(state is SignInFailedtate){
      showMySnackBar(context: context, content: Text(state.message));
    }else if(state is SignInSuccessState){
      showMySnackBar(context: context,color: ColorManager.green,content:const Text("Signed in successfully"));
      NavigatorManager.pushAndRemoveUntil(context: context, widget:const HomeScreen());
    } 
  }

  Widget _builder(BuildContext context, SignInCubitStates state) {
    return BlockInteractionLoadingWidget(
      isLoading: state is SignInLoadingState,
      widget: const _ScreenDesign(), 
    );   
  }
}

class _ScreenDesign extends StatelessWidget {
  const _ScreenDesign();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: ()=>SignInCubit.get(context).signIn(),
                  child: const Text("Sign In Anonymously"), 
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}