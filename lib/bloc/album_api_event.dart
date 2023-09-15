part of 'album_api_bloc.dart';

@immutable
abstract class AlbumApiEvent {}
@immutable 
class FetchAlbumEvent extends AlbumApiEvent {}

