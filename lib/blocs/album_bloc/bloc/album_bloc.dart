import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/api_services.dart';
import '../../../localDatabase/album_db.dart';
import '../../../localDatabase/photo_db.dart';





part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(AlbumInitial()) {
    on<GetAlbums>((event, emit) async{
      emit(GetAlbumLoading());
      List items = await ApiServices.fetchAlbums(userId: event.userId);
      if(items.isEmpty)
      {
        emit(GetAlbumFailed());
        return;
      }else{
        for(var item in items)
        {
          await AlbumDatabaseHelper.instance.insertAlbum(item);
        }
        emit(GetAlbumSuccess());
        return;
      }
    });
  
    on<GetPhotos>((event,emit)async{
    emit(GetPhotoLoading());
      List items = await ApiServices.fetchPhotos(albumId: event.albumId);
      if(items.isEmpty)
      {
        emit(GetPhotoFailed());
        return;
      }else{
        for(var item in items)
        {
          await PhotoDatabaseHelper.instance.insertPhoto(item);
        }
        emit(GetPhotoSuccess());
        return;
      }
  });
  }
}
