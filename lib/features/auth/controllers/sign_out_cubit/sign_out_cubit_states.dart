abstract class SignOutCubitStates{}

class SignOutInitialState extends SignOutCubitStates{}
class SignOutLoadingState extends SignOutCubitStates{}
class SignOutFailedtate extends SignOutCubitStates{
  final String message;
  SignOutFailedtate({required this.message});
}
class SignOutSuccessState extends SignOutCubitStates{}