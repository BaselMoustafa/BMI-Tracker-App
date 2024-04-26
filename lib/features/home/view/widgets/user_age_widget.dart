import 'package:bmi_tracker_app/core/functions/functions.dart';
import 'package:bmi_tracker_app/core/widgets/custom_text_form_filed.dart';
import 'package:bmi_tracker_app/features/home/view/widgets/base_user_info_widget.dart';
import 'package:flutter/material.dart';

class UserAgeWidget extends StatelessWidget {
  const UserAgeWidget({super.key,required this.ageTextController});
  final TextEditingController ageTextController;
  @override
  Widget build(BuildContext context) {
    return BaseUserInfoWidget(
      unit: "Years",
      customTextFormField: CustomTextFormField(
        textFormFieldProperties: TextFormFieldProperties(
          labelText: "Age",
          validator: (value)=>hasToBeInt(value: value,maxValue: 100),
          controller: ageTextController,
        )
      ), 
      
    );
  }
}