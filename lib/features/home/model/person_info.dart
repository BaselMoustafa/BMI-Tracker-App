import 'package:bmi_tracker_app/core/constants/constants.dart';
import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {

  final int age;
  final double height;
  final double weight;

  const UserInfo({required this.age,required this.height,required this.weight});

  factory UserInfo.fromMap(Map<String,dynamic>map){
    return UserInfo(
      age: map[KConst.age], 
      height:map[KConst.height], 
      weight:map[KConst.weight],
    );
  }

  Map<String,dynamic>toMap()=>{
    KConst.age:age, 
    KConst.height:height, 
    KConst.weight:weight,
  };

  @override
  List<Object?> get props => [age,height,weight];
}