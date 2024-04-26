import 'package:bmi_tracker_app/core/constants/constants.dart';
import 'package:bmi_tracker_app/core/network/fire_store_helper/fire_store_helper.dart';
import 'package:bmi_tracker_app/core/network/hive_helper/hive_helper.dart';
import 'package:bmi_tracker_app/features/home/controllers/add_update_delete_bmi_result_cubit/add_update_delete_bmi_result_cubit_states.dart';
import 'package:bmi_tracker_app/features/home/model/bmi_result.dart';
import 'package:bmi_tracker_app/features/home/model/person_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateDeleteBmiResultCubit extends Cubit<AddUpdateDeleteBmiResultCubitStates>{
  static AddUpdateDeleteBmiResultCubit get(BuildContext context)=>BlocProvider.of(context);

  AddUpdateDeleteBmiResultCubit():super(AddUpdateDeleteBmiResultInitialgState());

  Future<void>addBmiResult({required UserInfo userInfo})async{
    return await _tryAndCatchBlock(
      failureMessage: "Failed To Add The New Bmi Result",
      methodToExcute: () async{
        FireStoreHelper.add(
          collectionPath: [KConst.bmiResultsCollection], 
          data: BmiResult.toMap(
            userId: HiveHelper.get(boxName: KConst.dataBoxName, key: KConst.userId),
            userInfo: userInfo, 
          ),
        );
      },
    );
  }

  Future<void>updateBmiResult({required BmiResult bmiResult,required UserInfo newPersonInfo})async{
    return await _tryAndCatchBlock(
      failureMessage: "Failed To Update The Bmi Result",
      methodToExcute: () async{
        FireStoreHelper.set(
          documentPath: [KConst.bmiResultsCollection,bmiResult.id], 
          data: BmiResult.toMap(
            date: bmiResult.date,
            userId: HiveHelper.get(boxName: KConst.dataBoxName, key: KConst.userId),
            userInfo: newPersonInfo, 
          ),
        );
      },
    );
  }

  Future<void>deleteBmiResult({required String id})async{
    return await _tryAndCatchBlock(
      failureMessage: "Failed To Delete The New Bmi Result",
      methodToExcute: () async{
        FireStoreHelper.deleteDocument(
          documentPath: [KConst.bmiResultsCollection,id], 
        );
      },
    );
  }

  Future<void>_tryAndCatchBlock({
    required Future<void> Function() methodToExcute,
    required String failureMessage,
  })async{
    emit(AddUpdateDeleteBmiResultLoadingState());
    try {
      await methodToExcute();
      emit(AddUpdateDeleteBmiResultSuccessState());
    } catch (e) {
      emit(AddUpdateDeleteBmiResultFailedState(message: failureMessage));
    }
  }
}