part of 'post_bloc.dart';


sealed class PostEvent {}

class GetPostEvent extends PostEvent{
  final userId;
  GetPostEvent({required this.userId});
}
class GetCommentEvent extends PostEvent{
  final postId;
  GetCommentEvent({required this.postId});
}