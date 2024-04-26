import 'package:bmi_tracker_app/core/widgets/exception_widget.dart';
import 'package:bmi_tracker_app/core/widgets/loading_widget.dart';
import 'package:bmi_tracker_app/core/widgets/show_my_snackbar.dart';
import 'package:bmi_tracker_app/features/home/controllers/get_bmi_results_cubit/get_bmi_results_cubit.dart';
import 'package:bmi_tracker_app/features/home/controllers/get_bmi_results_cubit/get_bmi_results_cubit_states.dart';
import 'package:bmi_tracker_app/features/home/view/widgets/bmi_results_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetBmiResultsCubit,GetBmiResultsCubitStates>(
      listener: _listener,
      builder: _builder,
    );
  }

  void _listener(BuildContext context,GetBmiResultsCubitStates state) {
    if(state is GetBmiResultsFailedState && state.bmiResults.isNotEmpty){
      showMySnackBar(context: context, content: Text(state.message));
    }  
  } 
  
  Widget _builder(BuildContext context,GetBmiResultsCubitStates state) {
    if(state is GetBmiResultsLoadingState){
      return const LoadingWidget();
    }
    if(state is GetBmiResultsSuccessState){
      return BmiResultsListView(
        bmiResults: state.bmiResults,
        withLoadingIndicator: !state.thereAreNoMoreBmiResults,
      );
    }
    if(state is GetBmiResultsFailedState){
      return state.bmiResults.isNotEmpty?
        BmiResultsListView(bmiResults: state.bmiResults)
        :ExceptionWidget(
          message: state.message,
          onTryAgain: () => GetBmiResultsCubit.get(context).getBmiResults(),
        );
    }
    return const SizedBox();
  }

}