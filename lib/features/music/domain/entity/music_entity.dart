import 'package:meta/meta.dart';

class MusicEntity{
  String trackId;
  String trackName;
  String artistName;
  String collectionName;
  String artistViewUrl;
  String trackImage;
  String releaseDate;
  String previewUrl;

  MusicEntity({
    @required this.trackId,
    @required this.trackName,
    @required this.artistName,
    @required this.collectionName,
    @required this.artistViewUrl,
    @required this.trackImage,
    @required this.releaseDate,
    @required this.previewUrl
  });
}