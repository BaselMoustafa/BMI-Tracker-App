import 'package:bmi_tracker_app/core/managers/color_manager.dart';
import 'package:bmi_tracker_app/features/home/model/bmi_result.dart';
import 'package:bmi_tracker_app/features/home/view/widgets/update_bmi_result_button.dart';
import 'package:flutter/material.dart';

import 'delete_bmi_result_button.dart';

class BmiResultWidget extends StatelessWidget {
  const BmiResultWidget({super.key,required this.bmiResult});
  final BmiResult bmiResult;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: ColorManager.grey.withOpacity(0.3),blurRadius: 10)
        ]
      ),
      child: Column(

        children: [
          _LabelAndValueWidget(label: "Height", value: "${bmiResult.userInfo.height} Cm"),
          _LabelAndValueWidget(label: "Weight", value: "${bmiResult.userInfo.weight} Kg"),
          _LabelAndValueWidget(label: "Age", value: "${bmiResult.userInfo.age} Years"),
          _LabelAndValueWidget(label: "Result", value:bmiResult.result),
          const SizedBox(height: 20,),
          _ActionButtons(bmiResult: bmiResult),
          
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.bmiResult,});

  final BmiResult bmiResult;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: UpdateBmiResultButton(bmiResult: bmiResult),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: DeleteBmiResultButton(bmiResult: bmiResult,),
          ),
        ],
      ),
    );
  }
}

class _LabelAndValueWidget extends StatelessWidget {
  const _LabelAndValueWidget({required this.label,required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(label),
        ),
        const Text(":"),
        const SizedBox(width: 5,),
        Expanded(
          flex: 2,
          child: Text(value),
        ),
      ],
    );
  }
}