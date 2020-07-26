class TrackListModel{
  final id;
  final name;
  final  album;
  final artist;



  TrackListModel(this.id, this.name, this.album, this.artist);

  factory TrackListModel.fromJson(Map json){
    return TrackListModel(
      json["track"]["track_id"],
      json["track"]["track_name"],
      json["track"]["album_name"],
      json["track"]["artist_name"],
    );
  }
}
class TrackDetailModel{
  final id;
  final name;
  final  album;
  final artist;
  final explicit;
  final rating;


  TrackDetailModel(this.id, this.name, this.album, this.artist,this.explicit,this.rating);

  factory TrackDetailModel.fromJson(Map json){
    return TrackDetailModel(
      json["track_id"],
      json["track_name"],
      json["album_name"],
      json["artist_name"],
      json["explicit"],
      json["track_rating"]
    );
  }
}
class TrackLyricsModel{
  final id;
  final lyrics;


  TrackLyricsModel(this.id,this.lyrics);

  factory TrackLyricsModel.fromJson(Map json){
    return TrackLyricsModel(
      json["lyrics_id"],
      json["lyrics_body"],
    );
  }
}
class BookMarkModel{
  final id;
  final track_id;
  final name;
  BookMarkModel(this.id,this.track_id,this.name);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'track_id':track_id,
      'name': name,
    };
  }
  factory BookMarkModel.fromJson(Map json){
    return BookMarkModel(
      json["id"],
      json["track_id"],
      json["name"],
    );
  }
}
