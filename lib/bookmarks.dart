import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_library/TrackDetails.dart';
import 'package:music_library/TrackModel.dart';
import 'package:music_library/TrackRepo.dart';
import 'package:music_library/home.dart';

import 'TrackBloc.dart';

class BookMarksView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color:Colors.black
          ),
        title: Text("Bookmarks",style: TextStyle(color:Colors.black),),
      ),
      body:BlocProvider(create: (context)=>BookMarkBloc(TrackRepo()),child:BookMarkListPage()) 

    );
  }
}

var bookmarkBloc;
class BookMarkListPage extends StatelessWidget {
  
 
  @override
  Widget build(BuildContext context) {

  
      bookmarkBloc = BlocProvider.of<BookMarkBloc>(context);
            bookmarkBloc.add(GetBookMark());

      return      BlocBuilder<BookMarkBloc, BookMarkState>(
          builder: (context, state){
            if(state is BookMarkIsNotLoaded)
              bookmarkBloc.add(GetBookMark());
             
            if(state is BookMarkIsLoading)
               return CircularProgressIndicator();
               else if (state is BookMarkIsNotLoaded)
                  return Text("NO data");
                else if(state is BookMarkIsLoaded)
                   return BookMarkViewList(state.getbookmark);
          });
  } 
  }
  class BookMarkViewList extends StatelessWidget {
 List<BookMarkModel> data;
  BookMarkViewList(this.data);
    @override
    Widget build(BuildContext context) {
      return Container(
        child:  ListView.separated(separatorBuilder: (context, index) => Padding(
   padding: const EdgeInsets.symmetric(horizontal:15.0),
   child: Divider(
          color: Colors.black38,
        ),
 ),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
      return ListTile(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>TrackDetailPage(data[index].track_id))).then((onValue){
            print("herer");
            bookmarkBloc.add(GetBookMark());
          });
        },
        leading: Icon(Icons.library_music),
        title: Text("${data[index].name }",style: TextStyle(color:Colors.black),
        ),
        );
        
     },
    )
 
      );
    }
  }