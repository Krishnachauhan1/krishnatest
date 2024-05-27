part of 'user_bloc.dart';


sealed class UserState {}

final class UserInitial extends UserState {}

class GetUserProfileLoading extends UserState{}
class GetUserProfileFailed extends UserState{}
class GetUserProfileSuccess extends UserState{
  List<UserModel>? users;
  GetUserProfileSuccess({this.users});
}