import 'package:bmi_tracker_app/core/constants/constants.dart';
import 'package:bmi_tracker_app/core/network/hive_helper/hive_helper.dart';
import 'package:bmi_tracker_app/features/auth/controllers/sign_in_cubit/sign_in_cubit_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SignInCubit extends Cubit<SignInCubitStates>{

  static SignInCubit get(BuildContext context)=>BlocProvider.of(context);

  SignInCubit():super(SignInInitialState());

  Future<void>signIn()async{
    emit(SignInLoadingState());

    if(! await InternetConnectionChecker().hasConnection){
      emit(SignInFailedtate(message: "Please Check Your Network Connection"));
      return ;
    }

    try {
      final userCredential =await FirebaseAuth.instance.signInAnonymously();
      _saveUserId(userCredential);
      emit(SignInSuccessState());
    } on FirebaseAuthException catch (_) {
      emit(SignInFailedtate(message: "Failed To Sign In, Please Try Again"));
    }
  }

  void _saveUserId(UserCredential userCredential) {
    HiveHelper.put(
      boxName: KConst.dataBoxName, 
      key: KConst.userId, 
      value: userCredential.user?.uid,
    );
  }
}