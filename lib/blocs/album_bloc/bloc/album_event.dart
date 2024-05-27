part of 'album_bloc.dart';


sealed class AlbumEvent {}


class GetAlbums extends AlbumEvent{
  String userId;
  GetAlbums({required this.userId});
}

class GetPhotos extends AlbumEvent{
  String albumId;
  GetPhotos({required this.albumId});
}