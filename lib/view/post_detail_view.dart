import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../MyHelper/my_modalsheet/my_modalsheet.dart';
import '../MyHelper/my_widgets/my_widgets.dart';
import '../blocs/post_bloc/bloc/post_bloc.dart';
import '../localDatabase/comment_db.dart';
import '../model/comment_model.dart';
import '../model/post_model.dart';


class PostDetailView extends StatefulWidget {
  final PostModel post;
  const PostDetailView({super.key, required this.post});

  @override
  State<PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<PostDetailView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostBloc()..add(GetCommentEvent(postId: widget.post.id.toString())),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: MyWidgets.myAppbar(title: 'Post'),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              MyWidgets.postDetail(post: widget.post),
              BlocConsumer<PostBloc, PostState>(
                listener: (context, state) {
                  if (state is GetCommentFailed) {
                    showSnackbar(context: context, message: 'Internet error! comments not refreshed!');
                  }
                },
                builder: (context, state) {
                  if (state is GetCommentLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Expanded(
                    child: FutureBuilder<List<CommentModel>>(
                        future: CommentDatabaseHelper.instance.getComments(
                            postId: int.parse(widget.post.id.toString())),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(child: Text('No comments found.'));
                          }
                          return Column(children: [
                            const Padding(
                                padding:
                                   EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  "Comments",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: ((context, index) {
                                    final comment = snapshot.data![index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const CircleAvatar(
                                              child: Icon(Icons.person_2_outlined),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        comment.name,
                                                        style: const TextStyle(color: Colors.white,fontSize: 12),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      Padding(
                                              padding: const EdgeInsets.all(3),
                                              child:  Text(comment.body,maxLines: 3,style: const TextStyle(
                                                color: Colors.white70
                                              ),),
                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(color: Colors.grey,thickness: 0.5,)
                                        ],
                                      ),
                                    );
                                  })),
                            ),
                          ]);
                        }),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
