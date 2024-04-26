import 'dart:math';

import 'package:bmi_tracker_app/core/constants/constants.dart';
import 'package:bmi_tracker_app/features/home/model/person_info.dart';
import 'package:equatable/equatable.dart';

class BmiResult extends Equatable{
  final String id;
  final String result;
  final DateTime date;
  final UserInfo userInfo;
  
  const BmiResult({
    required this.date,
    required this.id,
    required this.result,
    required this.userInfo,
  });

  factory BmiResult.fromMap(Map<String,dynamic>map){
    return BmiResult(
      id: map[KConst.id], 
      date: map[KConst.date].toDate(),
      result: map[KConst.result], 
      userInfo: UserInfo.fromMap(map[KConst.userInfo]),
    );
  }

  static String _calculateResult(UserInfo userInfo)=>_fromNumberToString(
    userInfo.weight/pow(userInfo.height/100, 2)
  );

  static String _fromNumberToString(double result){
    result=double.parse(result.toStringAsFixed(1));
    if(result<=18.5){
      return "$result (Underweight)";
    }
    if(result<=25){
      return "$result (Normal)";
    }
    if(result<=30){
      return "$result (Overweight)";
    }
    return "$result (Obesity)";
  }

  static Map<String,dynamic>toMap({
    DateTime? date,
    required UserInfo userInfo,
    required String userId,
  })=>{
    KConst.userId:userId,
    KConst.date:date?? DateTime.now(),
    KConst.userInfo:userInfo.toMap(),
    KConst.result:_calculateResult(userInfo),
  };

  @override
  List<Object?> get props => [id,result,UserInfo];
}