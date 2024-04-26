abstract class SignInCubitStates{}

class SignInInitialState extends SignInCubitStates{}
class SignInLoadingState extends SignInCubitStates{}
class SignInFailedtate extends SignInCubitStates{
  final String message;
  SignInFailedtate({required this.message});
}
class SignInSuccessState extends SignInCubitStates{}