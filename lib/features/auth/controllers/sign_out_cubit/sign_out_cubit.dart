import 'package:bmi_tracker_app/core/constants/constants.dart';
import 'package:bmi_tracker_app/core/network/hive_helper/hive_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'sign_out_cubit_states.dart';

class SignOutCubit extends Cubit<SignOutCubitStates>{

  static SignOutCubit get(BuildContext context)=>BlocProvider.of(context);

  SignOutCubit():super(SignOutInitialState());

  Future<void>signOut()async{
    emit(SignOutLoadingState());

    if(! await InternetConnectionChecker().hasConnection){
      emit(SignOutFailedtate(message: "Please Check Your Network Connection"));
      return ;
    }

    try {
      await FirebaseAuth.instance.signOut();
      _clearUserId();
      emit(SignOutSuccessState());
    } on FirebaseAuthException catch (_) {
      emit(SignOutFailedtate(message: "Failed To Sign Out, Please Try Again"));
    }
  }

  void _clearUserId() {
    HiveHelper.delete(
      boxName: KConst.dataBoxName, 
      key: KConst.userId,
    );
  }
}