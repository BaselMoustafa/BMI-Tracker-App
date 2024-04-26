import 'package:bmi_tracker_app/core/widgets/custom_text_form_filed.dart';
import 'package:flutter/material.dart';
import '../../../../core/managers/color_manager.dart';

class BaseUserInfoWidget extends StatelessWidget {
  const BaseUserInfoWidget({super.key,required this.customTextFormField,required this.unit});
  final String unit;
  final CustomTextFormField customTextFormField;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(height: 55,child: customTextFormField),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Text(
            unit,
            style:const TextStyle(color: ColorManager.primary),
          ),
        ),
      ],
    );
  }
}