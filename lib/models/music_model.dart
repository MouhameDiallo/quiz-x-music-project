class Music{
  String? title;
  String? preview;
  String? artistName;
  String? artistPicture;
  bool? isPaused;

  Music.fromJson(Map<String, dynamic> jsonData){
    title = jsonData['title'];
    preview = jsonData['preview'];
    artistName = jsonData['artist']['name'];
    artistPicture = jsonData['artist']['picture_medium'];
    isPaused = true;
  }
}