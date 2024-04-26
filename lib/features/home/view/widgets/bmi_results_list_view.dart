import 'package:bmi_tracker_app/core/widgets/exception_widget.dart';
import 'package:bmi_tracker_app/core/widgets/loading_widget.dart';
import 'package:bmi_tracker_app/features/home/controllers/get_bmi_results_cubit/get_bmi_results_cubit.dart';
import 'package:bmi_tracker_app/features/home/view/widgets/bmi_result_widget.dart';
import 'package:flutter/material.dart';

import '../../model/bmi_result.dart';

class BmiResultsListView extends StatefulWidget {
  const BmiResultsListView({super.key,required this.bmiResults,this.withLoadingIndicator=false});
  final List<BmiResult>bmiResults;
  final bool withLoadingIndicator;

  @override
  State<BmiResultsListView> createState() => _BmiResultsListViewState();
}

class _BmiResultsListViewState extends State<BmiResultsListView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController=ScrollController();
    _scrollController.addListener(() {
      if(_scrollController.offset==_scrollController.position.maxScrollExtent){
        GetBmiResultsCubit.get(context).getBmiResults();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.bmiResults.isEmpty){
      return const ExceptionWidget(
        message: "There Are No Bmi Results Yet",
      );
    }
    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.all(10),
      itemCount:widget.withLoadingIndicator?widget.bmiResults.length+1: widget.bmiResults.length,
      separatorBuilder: _separatorBuilder, 
      itemBuilder: _itemBuilder, 
    );
  }

  Widget? _itemBuilder(context,index){
    if(index==widget.bmiResults.length){
      return const LoadingWidget();
    }
    return BmiResultWidget(bmiResult: widget.bmiResults[index]) ;
  }

  Widget _separatorBuilder(context,index)=>const SizedBox(height: 5,);
}