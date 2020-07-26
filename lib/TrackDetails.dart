import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_library/TrackBloc.dart';
import 'package:music_library/TrackModel.dart';
import 'package:music_library/TrackRepo.dart';
import 'package:music_library/enums/connectivity_status.dart';
import 'package:music_library/main.dart';
import 'package:provider/provider.dart';
import 'package:music_library/util.dart' as ut;
class TrackDetailPage extends StatelessWidget {
  final id;
  TrackDetailPage(this.id);
 
  @override
  Widget build(BuildContext context) {
   //inal tracklistBloc = BlocProvider.of<TrackListBloc>(context);
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
  
    return BlocProvider(
            create: (context)=>TrackDetailBloc(TrackRepo()),
          child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
            onPressed:(){
              Navigator.pop(context);
            }
          ),
          backgroundColor: Colors.white,
          title:Text("Track Details",style: TextStyle(color:Colors.black),)
        ),
        
        body:
         connectionStatus == ConnectivityStatus.Offline ? ut.networkerror() :  
         TrackDetail(id)
        
      ),
    );
  }
  
}
class TrackDetail extends StatelessWidget {
final id;
TrackDetail(this.id);
  @override
  Widget build(BuildContext context) {
      final counterBloc = BlocProvider.of<TrackDetailBloc>(context);

    return BlocBuilder<TrackDetailBloc, TrackDetailState>(
            builder: (context, state){
              if(state is TrackDetailIsNotLoaded)
                  counterBloc.add(ViewTrack(id.toString()));
                  
              if(state is TrackDetailLoadError)
                return Container(
                  padding: EdgeInsets.only(left: 32, right: 32,),
                  child: Text("Error While Loading")
                );
              else if(state is TrackDetailIsLoading)
                return Center(child : CircularProgressIndicator());
              else if(state is TrackDetailIsLoaded)
                return  ShowTrack(state.gettrackdetail); //ShowTrack(state.gettrackdetail);
              else
                return Text("Error",style: TextStyle(color: Colors.white),);
            },
          );

  }
}

class ShowTrack extends StatelessWidget{
  TrackDetailModel tracks;

  ShowTrack(this.tracks);

  @override
  Widget build(BuildContext context) {
 return    Container(
   margin: EdgeInsets.all(10),
   padding: EdgeInsets.only(left:10),
   child: ListView(
          children:[
   Row(
     children: <Widget>[
       Text("Name",style:ut.textstyle()),
       Expanded(child: SizedBox(),),
       BlocProvider(
            create: (context)=>BookMarkBloc(TrackRepo()),
       child:BookMarkButton(tracks.id,tracks.name)
       )
     ],
   ),
   SizedBox(height:2),
   Text("${tracks.name}",style:ut.textstyle1(),
          ),
   SizedBox(height:10),

   Text("Artist",style:ut.textstyle()),
   SizedBox(height:2),

                Text("${tracks.artist}",style: ut.textstyle1(),),
   SizedBox(height:10),
  
   Text("Album",style:ut.textstyle()),
   SizedBox(height:2),
                
                Text("${tracks.album}",style: ut.textstyle1()),
   SizedBox(height:10),
   
   Text("Explicit",style:ut.textstyle()),
   SizedBox(height:2),
                
             tracks.explicit == 0 ?   Text("False",style: ut.textstyle1()) : Text("True",style: ut.textstyle1()),
   SizedBox(height:10),
   
   Text("Rating",style:ut.textstyle()),
   SizedBox(height:2),
                Text("${tracks.rating}",style: ut.textstyle1()),
   SizedBox(height:10),
   Text("Lyrics",style:ut.textstyle()),
   SizedBox(height:2),
                
                BlocProvider(
            create: (context)=>LyricsBloc(TrackRepo()),
               child:Lyrics(tracks.id.toString()) ,    )
                
              ],
            
          ),
 );
        
     
    
 
}
}
class BookMarkButton extends StatelessWidget {
final id;
final name;
BookMarkButton(this.id,this.name);
  @override
  Widget build(BuildContext context) {
       final bookBloc = BlocProvider.of<BookMarkBloc>(context);

    return BlocBuilder<BookMarkBloc, BookMarkState>(
            builder: (context, state){
              if(state is BookMarkIsNotLoaded){
                bookBloc.add(CheckBookMark(id));
                return Container();
              } 
              if(state is BookMarkTrue){
                return Container(
                  child: InkWell(
                    onTap: (){
                      bookBloc.add(DeleteBookMark(id));

                    },
                    child: Icon(Icons.bookmark,color: Colors.red,),));
              }else if(state is BookMarkFalse){
                return Container(
                  child: InkWell(
                    onTap: (){
                      bookBloc.add(AddBookMark(id,name));
                    },
                    child: Icon(Icons.bookmark_border),));

              }        
  });
  }
}
class Lyrics extends StatelessWidget {
final id;
Lyrics(this.id);
  @override
  Widget build(BuildContext context) {
      final counterBloc = BlocProvider.of<LyricsBloc>(context);

    return BlocBuilder<LyricsBloc, LyricsState>(
            builder: (context, state){
              if(state is LyricsIsNotLoaded)
                  counterBloc.add(ViewLyrics(id));
                  
              if(state is LyricsLoadError)
                return Container(
                  padding: EdgeInsets.only(left: 32, right: 32,),
                  child: Text("Error While Loading")
                );
              else if(state is LyricsIsLoading)
                return Center(child : CircularProgressIndicator());
              else if(state is LyricsIsLoaded)
                return  Container(
                  padding: EdgeInsets.only(right:20,top:5),
                  child: Text(state.getlyrics.lyrics,style:TextStyle(fontSize:17,fontWeight: FontWeight.w400))); //ShowTrack(state.gettrackdetail);
              else
                return Text("Error",style: TextStyle(color: Colors.white),);
            },
          );

  }
}