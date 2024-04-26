import 'package:bmi_tracker_app/features/home/controllers/add_update_delete_bmi_result_cubit/add_update_delete_bmi_result_cubit.dart';
import 'package:bmi_tracker_app/features/home/model/bmi_result.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_button.dart';

class DeleteBmiResultButton extends StatelessWidget {
  const DeleteBmiResultButton({super.key,required this.bmiResult});
  final BmiResult bmiResult;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: ()=>AddUpdateDeleteBmiResultCubit.get(context).deleteBmiResult(
        id: bmiResult.id,
      ),
      child:const Text("Delete"), 
    );
  }
}