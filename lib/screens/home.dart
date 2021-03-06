import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hiltube/blocs/favorite_bloc.dart';
import 'package:hiltube/blocs/videos_bloc.dart';
import 'package:hiltube/delegates/data_search.dart';
import 'package:hiltube/screens/favorites.dart';
import 'package:hiltube/widgets/videotile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Novo jeito de pegar o bloc
    final VideosBloc bloc = BlocProvider.getBloc<VideosBloc>();
    final FavoriteBloc blocFavorites = BlocProvider.getBloc<FavoriteBloc>();
  
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 30.0,
          child: Image.asset("images/hilTube-logo2.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: blocFavorites.outFavorites,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Text("${snapshot.data.length}");
                }
                else{
                  return Container();
                }
              }
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Favorites()));
            }
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(context: context, delegate: DataSearch());
              
              if(result != null){
                bloc.inSearch.add(result);
              }
            }
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
        stream: bloc.outVideos,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length +1, // Macete pra lista infinita
              itemBuilder: (context, index){
                if(index < snapshot.data.length){
                  return VideoTile(snapshot.data[index]);
                }
                else if(index > 1){
                  bloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
                  );
                }
                else{
                  return Container();
                }
              }
            );
          }
          else{
            return Container();
          }
        }
      ),
    );
  }
}