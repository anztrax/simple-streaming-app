import 'package:meta/meta.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_entity.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_list_entity.dart';

class MusicListModel{
  final MusicListEntity entity;

  // keys
  static const String _TRACK_ID_KEY = 'trackId';
  static const String _RESULT_COUNT_KEY = 'resultCount';
  static const String _RESULT_KEY = 'results';
  static const String _RELEASE_DATE_KEY = 'releaseDate';
  static const String _TRACK_NAME_KEY = 'trackName';
  static const String _ARTIST_NAME_KEY = 'artistName';
  static const String _PREVIEW_URL_KEY = 'previewUrl';
  static const String _COLLECTION_NAME_KEY = 'collectionName';
  static const String _ARTIST_VIEW_URL_KEY = 'artistViewUrl';
  static const String _ARTWORK_URL_100_KEY = 'artworkUrl100';

  MusicListModel({
    @required this.entity
  });

  static MusicListModel fromJson(Map<String,dynamic> json) {
    return MusicListModel(
      entity: MusicListEntity(
        musics: _generateMusicsEntity(json[_RESULT_KEY]),
        resultCount: json[_RESULT_COUNT_KEY]
      )
    );
  }

  static List<MusicEntity> _generateMusicsEntity(List jsonData){
    List<MusicEntity> result = jsonData.map((item){
      return MusicEntity(
        trackId: item[_TRACK_ID_KEY].toString(),
        artistName: item[_ARTIST_NAME_KEY],
        artistViewUrl: item[_ARTIST_VIEW_URL_KEY],
        collectionName: item[_COLLECTION_NAME_KEY],
        releaseDate: item[_RELEASE_DATE_KEY],
        trackName: item[_TRACK_NAME_KEY],
        trackImage: item[_ARTWORK_URL_100_KEY],
        previewUrl: item[_PREVIEW_URL_KEY]
      );
    }).toList();

    return result;
  }

}