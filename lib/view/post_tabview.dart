import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishnatest/view/post_detail_view.dart';
import '../MyHelper/my_modalsheet/my_modalsheet.dart';
import '../MyHelper/my_widgets/my_widgets.dart';
import '../MyHelper/navigation/navigation.dart';
import '../blocs/export_blocs.dart';
import '../localDatabase/post_db.dart';
import '../model/post_model.dart';

class PostTabBarView extends StatefulWidget {
  final userId;
  const PostTabBarView({super.key, required this.userId});

  @override
  State<PostTabBarView> createState() => _PostTabBarViewState();
}

class _PostTabBarViewState extends State<PostTabBarView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider(
        create: (context) =>
            PostBloc()..add(GetPostEvent(userId: widget.userId)),
        child: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            if (state is GetPostFailed) {
                showSnackbar(context: context, message: "internet error! posts not refreshed.");
              }
          },
          builder: (context, state) {
            if (state is GetPostLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            /// in this we are getting data from local database after api call it updated into local database
            return FutureBuilder<List<PostModel>>(
                future: PostDatabaseHelper.instance
                    .getPosts(userId: int.parse(widget.userId)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No albums found.'));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        final post = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              navigatorPush(PostDetailView(post: post));
                            },
                            child: MyWidgets.postTile(post: post)),
                        );
                      }));
                });
          },
        ),
      ),
    );
  }
}
