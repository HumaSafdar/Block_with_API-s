import 'package:bloc_api/bloc/album_api_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'album.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AlbumApiBloc>(
        create: (context) => AlbumApiBloc(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AlbumApiBloc albumApiBloc = AlbumApiBloc();
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc with Api'),
      ),
      body: BlocBuilder<AlbumApiBloc, AlbumApiState>(
        bloc: albumApiBloc,
        builder: (context, state) {
          if (state is AlbumApiInitialState) {
            return InitialStateWidget();
          } else if (state is AlbumApiLoadingState) {
            return LoadingStateWidget();
          } else if (state is AlbumApiLoadedState) {
            return LoadedStateWidget(album: state.albums);
          } else {
            return ErrorStateWidget(
                errorMessage: (state as AlbumApiError).errorMessage);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          albumApiBloc.add(FetchAlbumEvent());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class InitialStateWidget extends StatelessWidget {
  const InitialStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Click to load data',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class LoadedStateWidget extends StatelessWidget {
  const LoadedStateWidget({required this.album, super.key});
  final List<Album> album;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: album.length,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            child: Text(
              album[index].id.toString(),
            ),
          ),
          title: (Text(album[index].title!)),
          subtitle: Text(album[index].userId.toString()),
        ),
      ),
    );
  }
}

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({required this.errorMessage, super.key});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.all(20),
      color: Colors.red,
      child: Text('ErrorMessage'),
    ));
  }
}
