import 'package:flutter/material.dart';

import '../../../../core/managers/color_manager.dart';
import 'user_info_dialog.dart';

class AddBmiResultButton extends StatelessWidget {
  const AddBmiResultButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorManager.primary,
      onPressed: ()=>showDialog(
        context: context, 
        builder: (_)=>const UserInfoDialog(),
      ),
      child:const Icon(Icons.add,color: ColorManager.white,),
    );
  }
}