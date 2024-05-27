import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/api_services.dart';
import '../../../localDatabase/comment_db.dart';
import '../../../localDatabase/post_db.dart';
import '../../../model/export_models.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<GetPostEvent>((event, emit)async {
      emit(GetPostLoading());
      List<PostModel> data = await ApiServices.fetchPosts(userId: event.userId);
      if(data.isEmpty)
      {
        emit(GetPostFailed());
        return;
      }else{
        for(var item in data)
        {
          await PostDatabaseHelper.instance.insertPost(item);
        }
        emit(GetPostSuccess());
        return;
      }
    });
  
    on<GetCommentEvent>((event,emit) async{
      emit(GetCommentLoading());
      List<CommentModel> data = await ApiServices.fetchComments(postId: event.postId);
      if(data.isEmpty)
      {
        emit(GetPostFailed());
      }else{
        for(var item in data)
        {
          await CommentDatabaseHelper.instance.insertComment(item);
        }
        emit(GetCommentSuccess());
        return;
      }
    });
  }
}
