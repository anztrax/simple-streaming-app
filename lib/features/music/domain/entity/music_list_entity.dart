import 'package:meta/meta.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_entity.dart';

class MusicListEntity{
  final int resultCount;
  final List<MusicEntity> musics;

  MusicListEntity({
    @required this.resultCount,
    @required this.musics
  });
}