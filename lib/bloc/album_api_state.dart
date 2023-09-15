part of 'album_api_bloc.dart';

@immutable
abstract class AlbumApiState {}
@immutable
class AlbumApiInitialState extends AlbumApiState {}
@immutable
class  AlbumApiLoadingState extends AlbumApiState{}
@immutable
class AlbumApiLoadedState extends AlbumApiState{
  final List<Album> albums;
  AlbumApiLoadedState({required this.albums});
}
@immutable
class AlbumApiError extends AlbumApiState{
  final String errorMessage;
  AlbumApiError({required this.errorMessage}) ;
    
  
}
