import 'package:bmi_tracker_app/core/managers/navigator_manager.dart';
import 'package:bmi_tracker_app/core/widgets/block_interaction_loading_widget.dart';
import 'package:bmi_tracker_app/core/widgets/show_my_snackbar.dart';
import 'package:bmi_tracker_app/features/auth/controllers/sign_out_cubit/sign_out_cubit.dart';
import 'package:bmi_tracker_app/features/auth/screens/sign_in_screen.dart';
import 'package:bmi_tracker_app/features/home/controllers/add_update_delete_bmi_result_cubit/add_update_delete_bmi_result_cubit.dart';
import 'package:bmi_tracker_app/features/home/controllers/add_update_delete_bmi_result_cubit/add_update_delete_bmi_result_cubit_states.dart';
import 'package:bmi_tracker_app/features/home/controllers/get_bmi_results_cubit/get_bmi_results_cubit.dart';
import 'package:bmi_tracker_app/features/home/view/widgets/home_screen_body.dart';
import 'package:bmi_tracker_app/features/home/view/widgets/add_bmi_result_button.dart';
import 'package:bmi_tracker_app/features/home/view/widgets/sign_out_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/controllers/sign_out_cubit/sign_out_cubit_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    GetBmiResultsCubit.get(context).getBmiResults();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignOutCubit,SignOutCubitStates>(listener: _signOutBlocListener),
        BlocListener<AddUpdateDeleteBmiResultCubit,AddUpdateDeleteBmiResultCubitStates>(
          listener: _addUpdateDeleteBmiResultBlocListener,
        ),
      ], 
      child: BlocBuilder<SignOutCubit,SignOutCubitStates>(
        builder:_signOutBlocBuilder,
      )
    );
  }

  Widget _signOutBlocBuilder(context, state)=>BlockInteractionLoadingWidget(
    isLoading: state is SignOutLoadingState,
    widget: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BMI Results"),
        actions: const[SignOutButton()],
      ),
      floatingActionButton:const AddBmiResultButton(),
      body:const HomeScreenBody(),
    ), 
  );

  void _signOutBlocListener(context, state) {
    if(state is SignOutFailedtate){
      showMySnackBar(context: context, content: Text(state.message));
    }
    if(state is SignOutSuccessState){
      GetBmiResultsCubit.get(context).init();
      NavigatorManager.pushAndRemoveUntil(context: context, widget: const SignInScreen());
    }
  }

  void _addUpdateDeleteBmiResultBlocListener(context, state) {
    if(state is AddUpdateDeleteBmiResultFailedState){
      showMySnackBar(context: context, content: Text(state.message));
    }
  }
}
