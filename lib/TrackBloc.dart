
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music_library/TrackModel.dart';
import 'package:music_library/TrackRepo.dart';

/// Track List Bloc Starts Here ----------------------------------------------------------------------
class TrackListEvent extends Equatable{
  @override
  List<Object> get props => [];

}

class FetchTracks extends TrackListEvent{


  @override
  List<Object> get props => [];
}
class ResetTracks extends TrackListEvent{


  @override
  List<Object> get props => [];
}
class TrackListState extends Equatable{
  @override
  List<Object> get props => [];

}

class TrackListIsLoading extends TrackListState{

}
class TrackListIsLoaded extends TrackListState{
  final _tracklist;

  TrackListIsLoaded(this._tracklist);

  List<TrackListModel> get gettracklist => _tracklist;

  @override
  List<Object> get props => [_tracklist];
}
class TrackListLoadError extends TrackListState{

}
class TrackListIsNotLoaded extends TrackListState{

}

class TrackListBloc extends Bloc<TrackListEvent, TrackListState>{

  TrackRepo trackRepo;

  TrackListBloc(this.trackRepo);

  @override
  TrackListState get initialState => TrackListIsNotLoaded();

  @override
  Stream<TrackListState> mapEventToState(TrackListEvent event) async*{
 if(event is FetchTracks){
      yield TrackListIsLoading();

      try{
        List<TrackListModel> tracklist = await trackRepo.getTracklist();
        yield TrackListIsLoaded(tracklist);
      }catch(_){
        print(_);
        yield TrackListLoadError();
      }
    }else if(event is ResetTracks){
      yield TrackListIsNotLoaded();
    }
    
  }

}

////Track List BLoc Ends Here ----------------------------------------------------------------------------

//Lyrics BLoc Start Here --------------------------------------------------------------------------------------
class LyricsEvent extends Equatable{
@override
  List<Object> get props => [];

}

class ViewLyrics extends LyricsEvent{
final id;

  ViewLyrics(this.id);

  @override
  List<Object> get props => [id];
}

class LyricsState extends Equatable{
  @override
  List<Object> get props => [];

}
class LyricsLoadError extends LyricsState{

}
class LyricsIsLoading extends LyricsState{

}

class LyricsIsLoaded extends LyricsState{
  final _track;

  LyricsIsLoaded(this._track);

  TrackLyricsModel get getlyrics => _track;

  @override
  List<Object> get props => [_track];
}

class LyricsIsNotLoaded extends LyricsState{

}
class LyricsBloc extends Bloc<LyricsEvent, LyricsState>{

  TrackRepo trackRepo;

  LyricsBloc(this.trackRepo);

  @override
  LyricsState get initialState => LyricsIsNotLoaded();

  @override
  Stream<LyricsState> mapEventToState(LyricsEvent event) async*{
  if(event is ViewLyrics){
      yield LyricsIsLoading();
      try{
        TrackLyricsModel track  =await trackRepo.getlyrics(event.id);
        yield LyricsIsLoaded(track);
      }catch(_){
        print(_);
      yield LyricsLoadError();

      }
    }else{
      yield LyricsLoadError();
    }   
  }

} 

/// Lyrics Bloc Ends here -------------------------------------------------------------------------------------------



/// Tracd Details Bloc Starts Heree --------------------------------------------------------------------------------------
class TrackDetailEvent extends Equatable{
  @override
  List<Object> get props => [];

}


class ViewTrack extends TrackDetailEvent{
final id;

  ViewTrack(this.id);

  @override
  List<Object> get props => [id];
}

class ResetTrackDetail extends TrackDetailEvent{


  @override
  List<Object> get props => [];
}


class TrackDetailState extends Equatable{
  @override
  List<Object> get props => [];

}

 
class TrackDetailLoadError extends TrackDetailState{

}
class TrackDetailIsLoading extends TrackDetailState{

}

class TrackDetailIsLoaded extends TrackDetailState{
  final _track;

  TrackDetailIsLoaded(this._track);

  TrackDetailModel get gettrackdetail => _track;

  @override
  List<Object> get props => [_track];
}

class TrackDetailIsNotLoaded extends TrackDetailState{

}


class TrackDetailBloc extends Bloc<TrackDetailEvent, TrackDetailState>{

  TrackRepo trackRepo;

  TrackDetailBloc(this.trackRepo);

  @override
  TrackDetailState get initialState => TrackDetailIsNotLoaded();

  @override
  Stream<TrackDetailState> mapEventToState(TrackDetailEvent event) async*{
  if(event is ViewTrack){
      yield TrackDetailIsLoading();
      try{
        TrackDetailModel track  =await trackRepo.getTrackdetail(event.id);
        yield TrackDetailIsLoaded(track);
      }catch(_){
        print(_);
        yield TrackDetailLoadError();
      }
    }else if(event is ResetTrackDetail){
      yield TrackDetailIsNotLoaded();
    }  
  }

}

//// Track Details BLoc Ends Here ------------------------------------------------------------------------------------------------------------------------


////// BookMArk Bloc STarts Here---------------------------------------------------------------------------------------

class BookMarkEvent extends Equatable{
  @override
  List<Object> get props => [];

}

class CheckBookMark extends BookMarkEvent{
final id;
CheckBookMark(this.id);
  @override
  List<Object> get props => [];
}

class DeleteBookMark extends BookMarkEvent{
final id;
DeleteBookMark(this.id);
  @override
  List<Object> get props => [];
}
class GetBookMark extends BookMarkEvent{


  @override
  List<Object> get props => [];
}
class AddBookMark extends BookMarkEvent{
   final id;
   final name;
   AddBookMark(this.id,this.name);

  @override
  List<Object> get props => [id,name];
}


class BookMarkState extends Equatable{
  @override
  List<Object> get props => [];

}


class BookMarkTrue extends BookMarkState{

}

class BookMarkFalse extends BookMarkState{

}
 
class BookMarkError extends BookMarkState{

}
class BookMarkIsLoading extends BookMarkState{

}
class BookMarkAddedSuccesfully extends BookMarkState{
final msg;
BookMarkAddedSuccesfully(this.msg);

  BookMarkAddedSuccesfully get getmsg => msg;

  @override
  List<Object> get props => [msg];
}

class BookMarkIsLoaded extends BookMarkState{
  final _bookmark;

  BookMarkIsLoaded(this._bookmark);

  List<BookMarkModel> get getbookmark => _bookmark;

  @override
  List<Object> get props => [_bookmark];
}

class BookMarkIsNotLoaded extends BookMarkState{

}


class BookMarkBloc extends Bloc<BookMarkEvent, BookMarkState>{

  TrackRepo trackRepo;

  BookMarkBloc(this.trackRepo);

  @override
  BookMarkState get initialState => BookMarkIsNotLoaded();

  @override
  Stream<BookMarkState> mapEventToState(BookMarkEvent event) async*{
  if(event is GetBookMark){
      yield BookMarkIsLoading();
      try{
        List<BookMarkModel> track  =await trackRepo.getbookmark();
        yield BookMarkIsLoaded(track);
      }catch(_){
        print(_);
        yield BookMarkError();
      }
    }
    else if(event is AddBookMark){
      print("hereaaddd");
      try{
       String msg =  await trackRepo.addbookmark(event.id.toString(), event.name.toString());
          print(msg);
            yield BookMarkTrue();               
      }catch(_){
        yield BookMarkFalse();
      }
    }else if(event is CheckBookMark){
      print("wow${event.id}");
           bool val = await trackRepo.checkbookmark(event.id.toString());
           print(val);
           if(val){
             yield BookMarkTrue();
           }else{
             yield BookMarkFalse();

           }
    }else if(event is DeleteBookMark){
      print("hereaaddd");
      try{
       String msg =  await trackRepo.deletebookmark(event.id.toString());
          print(msg);
            yield BookMarkFalse();               
      }catch(_){
        yield BookMarkTrue();
      }
    }  
  }

}
