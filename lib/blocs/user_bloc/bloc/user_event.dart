part of 'user_bloc.dart';

sealed class UserEvent {}

class GetUserProfile extends UserEvent{
  String? id;
  GetUserProfile({this.id});
}
