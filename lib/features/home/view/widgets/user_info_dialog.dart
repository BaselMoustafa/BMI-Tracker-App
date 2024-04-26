import 'package:bmi_tracker_app/core/managers/navigator_manager.dart';
import 'package:bmi_tracker_app/core/widgets/custom_button.dart';
import 'package:bmi_tracker_app/features/home/controllers/add_update_delete_bmi_result_cubit/add_update_delete_bmi_result_cubit.dart';
import 'package:bmi_tracker_app/features/home/model/bmi_result.dart';
import 'package:bmi_tracker_app/features/home/view/widgets/user_age_widget.dart';
import 'package:bmi_tracker_app/features/home/view/widgets/user_height_widget.dart';
import 'package:bmi_tracker_app/features/home/view/widgets/user_weight_widget.dart';
import 'package:flutter/material.dart';
import '../../model/person_info.dart';

class UserInfoDialog extends StatefulWidget {
  const UserInfoDialog({super.key,this.bmiResult});
  final BmiResult? bmiResult; 
  @override
  State<UserInfoDialog> createState() => _UserInfoDialogState();
}

class _UserInfoDialogState extends State<UserInfoDialog> {

  late final GlobalKey<FormState>_fromKey;

  late final TextEditingController _heightTextController;
  late final TextEditingController _weightTextController;
  late final TextEditingController _ageTextController;

  @override
  void initState() {
    _fromKey=GlobalKey<FormState>();
    _heightTextController=TextEditingController()
      ..text=widget.bmiResult?.userInfo.height.toString()??"";
    _weightTextController=TextEditingController()
      ..text=widget.bmiResult?.userInfo.weight.toString()??"";
    _ageTextController=TextEditingController()
      ..text=widget.bmiResult?.userInfo.age.toString()??"";
    super.initState();
  }

  @override
  void dispose() {
    _heightTextController.dispose();
    _weightTextController.dispose();
    _ageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _fromKey,
          child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UserHeightWidget(heightTextController: _heightTextController),
                  const SizedBox(height: 10,),
                  UserWeightWidget(weightTextController: _weightTextController),
                  const SizedBox(height: 10,),
                  UserAgeWidget(ageTextController: _ageTextController),
                  const SizedBox(height: 10,),
                  CustomButton(
                    onTap: ()=>_onTap(context), 
                    child: Text(
                      widget.bmiResult==null?"Calculate":"Update",
                    ),
                  )
                ],
              ),
          ),
        ),
      ),
    );
  }
  
  void _onTap(BuildContext context){
    if(! _fromKey.currentState!.validate()){
      return ;
    }

    NavigatorManager.pop(context: context);

    if(widget.bmiResult==null){
      AddUpdateDeleteBmiResultCubit.get(context).addBmiResult(userInfo: _userInfo,);
    }else{
      AddUpdateDeleteBmiResultCubit.get(context).updateBmiResult(
        bmiResult: widget.bmiResult!, 
        newPersonInfo: _userInfo,
      );
    }
  }


  UserInfo get _userInfo=>UserInfo(
    age: int.parse(_ageTextController.text), 
    height: double.parse(_heightTextController.text), 
    weight: double.parse(_weightTextController.text)
  );
}