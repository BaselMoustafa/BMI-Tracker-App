import 'package:bmi_tracker_app/core/functions/functions.dart';
import 'package:bmi_tracker_app/core/widgets/custom_text_form_filed.dart';
import 'package:bmi_tracker_app/features/home/view/widgets/base_user_info_widget.dart';
import 'package:flutter/material.dart';

class UserHeightWidget extends StatelessWidget {
  const UserHeightWidget({super.key,required this.heightTextController});
  final TextEditingController heightTextController;
  @override
  Widget build(BuildContext context) {
    return BaseUserInfoWidget(
      unit: "Cm",
      customTextFormField: CustomTextFormField(
        textFormFieldProperties: TextFormFieldProperties(
          labelText: "Height",
          validator: (value)=>hasToBeNumber(value: value,maxValue: 200),
          controller: heightTextController,
        )
      ), 
      
    );
  }
}