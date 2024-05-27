part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

class GetPostLoading extends PostState{}
class GetPostFailed extends PostState{}
class GetPostSuccess extends PostState{}
class GetCommentLoading extends PostState{}
class GetCommentFailed extends PostState{}
class GetCommentSuccess extends PostState{}
