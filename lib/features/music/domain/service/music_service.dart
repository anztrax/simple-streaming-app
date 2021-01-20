import 'package:simple_streaming_app/core/domain/result.dart';
import 'package:simple_streaming_app/core/errors/failures/failure.dart';
import 'package:simple_streaming_app/features/music/domain/entity/downloaded_music_entity.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_entity.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_list_entity.dart';
import 'package:simple_streaming_app/features/music/dto/delete_music_dto.dart';
import 'package:simple_streaming_app/features/music/dto/download_music_dto.dart';
import 'package:simple_streaming_app/features/music/dto/search_by_artist_dto.dart';

abstract class MusicService{
  Future<Result<Failure, MusicListEntity>> searchByArtist(SearchByArtistDTO params);

  Future<Result<Failure, DownloadedMusicEntity>> downloadMusic(DownloadMusicDTO params);

  Future<Result<Failure, bool>> deleteMusic(DeleteMusicDTO params);
}
