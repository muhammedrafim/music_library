import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_library/TrackBloc.dart';
import 'package:music_library/TrackDetails.dart';
import 'package:music_library/TrackModel.dart';
import 'package:music_library/TrackRepo.dart';
import 'package:music_library/bookmarks.dart';
import 'package:music_library/enums/connectivity_status.dart';
import 'package:provider/provider.dart';
import 'package:music_library/util.dart'as ut;

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:BlocProvider(create: (context)=>TrackListBloc(TrackRepo()),child:TrackListPage()) 
    
  //  connectionStatus == ConnectivityStatus.Offline ? ut.networkerror() : 
      );
  }
}


class TrackListPage extends StatelessWidget {
  
 
  @override
  Widget build(BuildContext context) {

  
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
      final counterBloc = BlocProvider.of<TrackListBloc>(context);

    return Scaffold(
        appBar: AppBar(
                centerTitle: true,
                    backgroundColor: Colors.white,
          title:Text("Trending",style: TextStyle(color:Colors.black),),
          actions: <Widget>[
           IconButton(icon: Icon(Icons.collections_bookmark,color: Colors.black,),
           onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>BookMarksView()));
           },
           )
          ],
),
        body:  
    connectionStatus == ConnectivityStatus.Offline ? ut.networkerror() : 
     BlocBuilder<TrackListBloc, TrackListState>(
          builder: (context, state){
         if(state is TrackListIsNotLoaded)
                counterBloc.add(FetchTracks());
              if(state is TrackListLoadError)
              return Container(
                padding: EdgeInsets.only(left: 32, right: 32,),
                child: Text("Error While Loading")
              );
            else if(state is TrackListIsLoading)
              return Center(child : CircularProgressIndicator());
            else if(state is TrackListIsLoaded){
              return ShowTracks(state.gettracklist);
              
              }
            else
              return Text("Error",style: TextStyle(color: Colors.black),);
          },
        

      
    ));
  }
}
class ShowTracks extends StatelessWidget{
  List<TrackListModel> tracks;

  ShowTracks(this.tracks);

  @override
  Widget build(BuildContext context) {
 return
 
  ListView.separated(separatorBuilder: (context, index) => Padding(
   padding: const EdgeInsets.symmetric(horizontal:15.0),
   child: Divider(
          color: Colors.black38,
        ),
 ),
      itemCount: tracks.length,
      itemBuilder: (BuildContext context, int index) {
      return  ListTile(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>TrackDetailPage(tracks[index].id.toString())));
       //    tracklistBloc.add(ViewTrack(tracks[index].id.toString()));          
        },
        leading: Icon(Icons.library_music),
        subtitle: Text("${tracks[index].album}"),
        title: Text("${tracks[index].name}",style: TextStyle(color:Colors.black),
        ),
        trailing: Container(
          width: MediaQuery.of(context).size.width*0.2,
          child: Wrap(
            children: <Widget>[
              Text("${tracks[index].artist}"),
            ],
          )),
        );
        
     },
    );
 
}
}
