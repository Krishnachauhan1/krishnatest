import 'package:flutter/material.dart';

import '../../model/album_model.dart';
import '../../model/photo_model.dart';
import '../../model/post_model.dart';
import '../../model/user_model.dart';

class MyWidgets {
  static AppBar myAppbar({required String title}) {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      title: Text(title),
    );
  }

  static Widget profileListTile(
      {required UserModel user, required Function onTap}) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF242323),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                offset: Offset(1, 1),
                color: Colors.white10,
                spreadRadius: 1,
                blurRadius: 1)
          ]),
      child: ListTile(
        onTap: () {
          onTap();
        },
        // onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) =>
        //           UserProfile(user: user),
        //     ));
        // },
        contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        leading: const CircleAvatar(
          child: Icon(Icons.person_2_rounded),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white60,
        ),
        title: Text(
          '@${user.username ?? user.name!}',
          style: TextStyle(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          children: [
            Text(
              user.name ?? '',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  static Widget albumContainer({required AlbumModel album}) {
    return Container(
      height: 300,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF242323)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Icon(
            Icons.folder_copy_outlined,
            size: 50,
            color: Colors.white,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 50,
                width: 100,
                child: Text(
                  album.title,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
        ],
      ),
    );
  }

  static Widget postTile({required PostModel post}) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          color: const Color(0xFF242323),
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            post.body,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'read more..',
                style: TextStyle(color: Colors.blue),
              ))
        ],
      ),
    );
  }

  static Widget photoThumbnail({required PhotoModel photo}) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1)),
      child: Stack(children: [
        Center(
            child: Image.network(photo.thumbnailUrl,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          return child;
        }, loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
        }, errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
          return Container(
              color: Colors.grey[200], child: Icon(Icons.broken_image));
        })),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                photo.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ))
      ]),
    );
  }

  static Widget postDetail({required PostModel post}) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            post.body,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
