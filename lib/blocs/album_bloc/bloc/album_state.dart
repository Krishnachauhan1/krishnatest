part of 'album_bloc.dart';

@immutable
sealed class AlbumState {}

final class AlbumInitial extends AlbumState {}

class GetAlbumLoading extends AlbumState{}
class GetAlbumFailed extends AlbumState{}
class GetAlbumSuccess extends AlbumState{}
class GetPhotoLoading extends AlbumState{}
class GetPhotoFailed extends AlbumState{}
class GetPhotoSuccess extends AlbumState{}