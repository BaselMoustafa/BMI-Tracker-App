import 'package:flutter/material.dart';
import '../managers/color_manager.dart';

void showMySnackBar({
  required BuildContext context,
  required Widget content,
  SnackBarAction? snackBarAction,
  Color color=ColorManager.red,
}){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      action: snackBarAction,
      backgroundColor: color,
      dismissDirection: DismissDirection.up,
      padding:const EdgeInsets.all(10),
      content: DefaultTextStyle(
        style:const TextStyle(color: ColorManager.white,fontSize: 16), 
        child: content,
      ),
    )
  );
}