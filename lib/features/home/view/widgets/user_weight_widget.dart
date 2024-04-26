import 'package:bmi_tracker_app/core/functions/functions.dart';
import 'package:bmi_tracker_app/core/widgets/custom_text_form_filed.dart';
import 'package:bmi_tracker_app/features/home/view/widgets/base_user_info_widget.dart';
import 'package:flutter/material.dart';

class UserWeightWidget extends StatelessWidget {
  const UserWeightWidget({super.key,required this.weightTextController});
  final TextEditingController weightTextController;
  @override
  Widget build(BuildContext context) {
    return BaseUserInfoWidget(
      unit: "Kg",
      customTextFormField: CustomTextFormField(
        textFormFieldProperties: TextFormFieldProperties(
          labelText: "Weight",
          validator: (value)=>hasToBeNumber(value: value,maxValue: 200),
          controller: weightTextController,
        )
      ), 
      
    );
  }
}