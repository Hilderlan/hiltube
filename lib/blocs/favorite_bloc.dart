import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hiltube/models/video.dart';

class FavoriteBloc implements BlocBase{
  Map<String, Video> _favorites = {};

  final StreamController<Map<String, Video>> _favoritesController = StreamController<Map<String, Video>>.broadcast();
  Stream<Map<String, Video>> get outFavorites => _favoritesController.stream;

  void toggleFavorites(Video video){
    if(_favorites.containsKey(video.id)){
      _favorites.remove(video.id);
    }
    else{
      _favorites[video.id] = video;
    }

    _favoritesController.sink.add(_favorites);
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _favoritesController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }

  

}