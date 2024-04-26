import 'package:bmi_tracker_app/features/home/model/bmi_result.dart';
import 'package:bmi_tracker_app/features/home/view/widgets/user_info_dialog.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_button.dart';

class UpdateBmiResultButton extends StatelessWidget {
  const UpdateBmiResultButton({super.key,required this.bmiResult});
  final BmiResult bmiResult;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: ()=>showDialog(
        context: context,
        builder: (context) => UserInfoDialog(bmiResult: bmiResult,),
      ),
      child:const Text("Update"), 
    );
  }
}