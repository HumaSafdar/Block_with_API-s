import 'package:bloc/bloc.dart';
import 'package:bloc_api/api_provider_bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

import '../album.dart';

part 'album_api_event.dart';
part 'album_api_state.dart';

class AlbumApiBloc extends Bloc<AlbumApiEvent, AlbumApiState> {
  AlbumApiBloc() : super(AlbumApiInitialState()) {
    AlbumAPIProvider albumAPIProvider=AlbumAPIProvider();

    on<FetchAlbumEvent>((event, emit)async {
      emit(AlbumApiLoadingState());
      try{
        List<Album> albums=await albumAPIProvider.fetchAlbums();
        emit(AlbumApiLoadedState(albums: albums));
      }catch(e){
        emit(AlbumApiError(errorMessage: e.toString()));
      }
      
    });
  }
}
