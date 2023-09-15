import 'dart:convert';

import 'package:http/http.dart';

import 'album.dart';

extension APIResponse on Response{
  bool isSuccess()=> statusCode == 200;
}
abstract class ApiProvider{
   final baseUrl = 'https://jsonplaceholder.typicode.com';
   String get apiUrl;
  Uri getUrl({String endPoint=' '})=> Uri.parse(baseUrl+apiUrl+endPoint);

  _fetch({String endPoint=''}) async {
    var response=await get(getUrl(endPoint: endPoint));
    if(response.isSuccess()){
      return jsonDecode(response.body);
    }else{
      return null;
    }
  }
   }
   class AlbumAPIProvider extends ApiProvider{
     @override
    
     String get apiUrl => '/albums';
     Future<List<Album>> fetchAlbums() async{
      var listMap= await _fetch() as List;
      return listMap.map((map) =>Album.fromMap(map)).toList();

     }

   }
