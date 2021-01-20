import 'package:flutter/cupertino.dart';
import 'package:simple_streaming_app/core/file/file_manager.dart';
import 'package:simple_streaming_app/features/music/data/model/music_list_model.dart';
import 'package:simple_streaming_app/features/music/dto/download_music_dto.dart';
import 'package:simple_streaming_app/features/music/dto/search_by_artist_dto.dart';

abstract class MusicRemoteDataSource{
  Future<MusicListModel> searchByArtist(SearchByArtistDTO params);
  Future<TempFileManager> downloadMusic(DownloadMusicDTO params);
}

