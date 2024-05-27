import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../model/export_models.dart';
import 'export_data.dart';

class ApiServices{

  /// fetch user profiles
  static Future<List<UserModel>> fetchUserProfiles ({String? id})async
  {
    List<UserModel> users = [];

    id = id == null ? '': 'id=$id';
    final url = '${ApiUrls.userProfile}?$id';
    

    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200)
      {
        List data = jsonDecode(response.body);
        for(var item in data)
        {
          users.add(UserModel.fromJson(item));
        }
      }else{
        if(true)
        {

        }
      }
    }catch(err)
    {
      if(true)
      {
        if (kDebugMode) {
          print(err);
        }
      }
    }
    return users;
  }

  static Future<List<AlbumModel>> fetchAlbums({String? userId})async{
    List<AlbumModel> albums = [];

    userId = userId == null ? '': 'userId=$userId';
    final url = '${ApiUrls.albums}?$userId';
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200)
      {
        if(kDebugMode)
        {
          print(jsonDecode(response.body));
        }
        List items = jsonDecode(response.body);
        for(var item in items)
        {
          albums.add(AlbumModel.fromJson(item));
        }
      }else{
        if(kDebugMode)
        {
          print(response.statusCode);
        }
      }
    }catch(err)
    {
      if(kDebugMode)
      {
        print(err);
      }
    }
    return albums;
  }

  static Future<List<PostModel>> fetchPosts({String? userId})async{
    List<PostModel> posts = [];
    userId = userId == null ? '':'?userId=$userId';

    final url = ApiUrls.post+userId;
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200)
      {
        if(kDebugMode)
        {
          print(response.body);
        }
        List items = jsonDecode(response.body);
        for(var item in items)
        {
          posts.add(PostModel.fromJson(item));
        }
      }else{
        if(kDebugMode)
        {
          print(response.statusCode);
        }
      }
    } catch (err) {
      if(kDebugMode)
      {
        print(err);
      }
    }
    return posts;
  }

  static Future<List<PhotoModel>> fetchPhotos({String? albumId})async{
    List<PhotoModel> photos = [];
    albumId = albumId == null ? '':'?albumId=$albumId';

    final url = ApiUrls.photos+albumId;
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200)
      {
        if(kDebugMode)
        {
          print(response.body);
        }
        List items = jsonDecode(response.body);
        for(var item in items)
        {
          photos.add(PhotoModel.fromJson(item));
        }
      }else{
        if(kDebugMode)
        {
          print(response.statusCode);
        }
      }
    } catch (err) {
      if(kDebugMode)
      {
        print(err);
      }
    }
    return photos;
  }

  static Future<List<CommentModel>> fetchComments({String? postId})async{
    List<CommentModel> comments = [];
    postId = postId == null ? '':'?postId=$postId';

    final url = ApiUrls.comments+postId;
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200)
      {
        if(kDebugMode)
        {
          print('here ->${response.request}');
          print(response.body);
        }
        List items = jsonDecode(response.body);
        for(var item in items)
        {
          comments.add(CommentModel.fromJson(item));
        }
      }else{
        if(kDebugMode)
        {
          print(response.statusCode);
        }
      }
    } catch (err) {
      if(kDebugMode)
      {
        print(err);
      }
    }
    return comments;
  }

}