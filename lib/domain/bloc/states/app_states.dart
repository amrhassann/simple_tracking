abstract class AppStates{}
class AppInitialState extends AppStates{}
class LoginSuccessState extends AppStates{}
class LoginErrorState extends AppStates{
  String error;
  LoginErrorState(this.error);
}
class UpdateDriverLocationError extends AppStates{
  String error;
  UpdateDriverLocationError(this.error);
}
class UpdateDriverSuccessState  extends AppStates{}
class LoginLoadingState  extends AppStates{}
