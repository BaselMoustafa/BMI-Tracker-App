import '../../model/bmi_result.dart';

abstract class GetBmiResultsCubitStates{}

class GetBmiResultsInitialgState extends GetBmiResultsCubitStates{}
class GetBmiResultsLoadingState extends GetBmiResultsCubitStates{}
class GetBmiResultsSuccessState extends GetBmiResultsCubitStates{
  final bool thereAreNoMoreBmiResults;
  final List<BmiResult>bmiResults;
  GetBmiResultsSuccessState({required this.thereAreNoMoreBmiResults,required this.bmiResults});
}
class GetBmiResultsFailedState extends GetBmiResultsCubitStates{
  final String message;
  final List<BmiResult>bmiResults;
  GetBmiResultsFailedState({required this.message,required this.bmiResults});
}