import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:music_library/TrackModel.dart';
import 'package:music_library/globals.dart';
import 'package:sqflite/sqflite.dart';

class TrackRepo{
  Future<List<TrackListModel>> getTracklist() async{
    final result = await http.Client().get(tracklist_url);
    if(result.statusCode != 200)
      throw Exception();
      
    
    return parsedJson(result.body);
  }
  
  List<TrackListModel> parsedJson(final response){
    final jsonDecoded = json.decode(response);
    
var objsJson = jsonDecoded["message"]["body"]["track_list"] as List;
  List<TrackListModel> trackObjs = objsJson.map((tagJson) => TrackListModel.fromJson(tagJson)).toList();

    return trackObjs;
  }

  Future<TrackDetailModel> getTrackdetail(String trackid) async{
    final result = await http.Client().get("$trackdetail_url=$trackid&apikey=$apiKey");
    print(result);
    if(result.statusCode != 200)
      throw Exception();
      
    
    return parsedJsonDetail(result.body);
  }
  
  TrackDetailModel parsedJsonDetail(final response){
    final jsonDecoded = json.decode(response);
    
    return TrackDetailModel.fromJson(jsonDecoded["message"]["body"]["track"]);
  }
  
   Future<TrackLyricsModel> getlyrics(String trackid) async{
    final result = await http.Client().get("$lyrics_url=$trackid&apikey=$apiKey");
    print(result);
    if(result.statusCode != 200)
      throw Exception();
      
    
    return parsedJsonLyrics(result.body);
  }
  
  TrackLyricsModel parsedJsonLyrics(final response){
    final jsonDecoded = json.decode(response);
    
    return TrackLyricsModel.fromJson(jsonDecoded["message"]["body"]["lyrics"]);
  }
  
Future<String> addbookmark(String id,String name)async{
  
var db = await openDatabase('bookmark.db');

 int id1 = await db.rawInsert('INSERT INTO bookmarks(track_id,name) VALUES(?, ?)',[id,name]);
      
print("thisssssss");

return "yes";
}
Future<String> deletebookmark(String id)async{
  
var db = await openDatabase('bookmark.db');

 int id1 = await db.rawDelete('DELETE FROM bookmarks where track_id = ?',[id]);
      
print("thisssssss");

return "yes";
}
Future<List<BookMarkModel>> getbookmark()async{
  final Database database = await openDatabase(
  // Set the path to the database.
   'bookmark.db',
  // When the database is first created, create a table to store dogs.
  onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
      "CREATE TABLE bookmarks(id INTEGER PRIMARY KEY, track_id TEXT, name TEXT)",
    );
  },
  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  version: 1,
);
final List<Map<String, dynamic>> maps = await database.query('bookmarks');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return BookMarkModel(
      maps[i]['id'],
    maps[i]['track_id'],
     maps[i]['name'],
    );
  });
}
Future<bool> checkbookmark(String id)async{
print("this");

 final Database database = await openDatabase(
  // Set the path to the database.
   'bookmark.db',
  // When the database is first created, create a table to store dogs.
  onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
      "CREATE TABLE bookmarks(id INTEGER PRIMARY KEY, track_id TEXT, name TEXT)",
    );
  },
  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  version: 1,
);

var list = await database.rawQuery('SELECT * FROM bookmarks where track_id = $id');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  if(list.length > 0 ) return true; else return false;
}
}