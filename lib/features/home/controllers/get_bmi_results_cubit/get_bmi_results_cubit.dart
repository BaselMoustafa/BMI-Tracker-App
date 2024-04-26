import 'dart:async';
import 'package:bmi_tracker_app/core/constants/constants.dart';
import 'package:bmi_tracker_app/core/network/hive_helper/hive_helper.dart';
import 'package:bmi_tracker_app/features/home/model/bmi_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'get_bmi_results_cubit_states.dart';

class GetBmiResultsCubit extends Cubit<GetBmiResultsCubitStates>{
  static GetBmiResultsCubit get(BuildContext context)=>BlocProvider.of(context);

  GetBmiResultsCubit():super(GetBmiResultsInitialgState());

  final int _limit=10;
  int _page=0;
  StreamSubscription? _streamSubscription;
  List<BmiResult>_bmiResults=[];
  bool _thereAreNoMoreBmiResults=false;

  void init(){
    _page=0;
    _streamSubscription=null;
    _bmiResults=[];
    _thereAreNoMoreBmiResults=false;
    emit(GetBmiResultsInitialgState());
  }

  Future<void> getBmiResults()async{
    if( ! await InternetConnectionChecker().hasConnection){
      emit(GetBmiResultsFailedState(
        message: "Please Check Your Netwok Connection", 
        bmiResults: _bmiResults
      ));
      return ;
    }
    if(_thereAreNoMoreBmiResults){
      return ;
    }

    if(_bmiResults.isEmpty){
      emit(GetBmiResultsLoadingState());
    }
    
    _page++;

    if(_streamSubscription!=null){
      _streamSubscription!.cancel();
    }

    _initializeStremSubsribtion();

  }

  void _initializeStremSubsribtion(){
    _streamSubscription=_bmiResultsQuery.snapshots().listen(
      _onData,
      onError: _onError,
    );
  }

  Query get _bmiResultsQuery=>FirebaseFirestore.instance
    .collection(KConst.bmiResultsCollection)
    .where(
      KConst.userId,
      isEqualTo: HiveHelper.get(boxName: KConst.dataBoxName, key: KConst.userId),
    )
    .orderBy(KConst.date,descending: true)
    .limit(_page*_limit);
    

  void _onError(_){
    _page--;
    emit(
      GetBmiResultsFailedState(
        bmiResults: _bmiResults,
        message: "Failed To Get Bmi Results",
      )
    );
  }

  void _onData(QuerySnapshot event) {
    _bmiResults=[];
    if(event.docs.length<_page*_limit){
      _thereAreNoMoreBmiResults=true;
    }else{
      _thereAreNoMoreBmiResults=false;
    }
    for (var i = 0; i < event.docs.length; i++) {
      _bmiResults.add(BmiResult.fromMap(event.docs[i].data() as Map<String,dynamic>));
    }
    emit(
      GetBmiResultsSuccessState(
      thereAreNoMoreBmiResults: _thereAreNoMoreBmiResults,
      bmiResults: _bmiResults,
      )
    );
  }

}