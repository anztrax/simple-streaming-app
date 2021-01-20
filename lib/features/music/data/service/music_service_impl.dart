import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:simple_streaming_app/core/domain/base_service.dart';
import 'package:simple_streaming_app/core/domain/result.dart';
import 'package:simple_streaming_app/core/errors/exceptions/base_exception.dart';
import 'package:simple_streaming_app/core/errors/failures/failure.dart';
import 'package:simple_streaming_app/core/file/file_manager.dart';
import 'package:simple_streaming_app/features/music/data/data_source/music_remote_data_source.dart';
import 'package:simple_streaming_app/features/music/data/model/music_list_model.dart';
import 'package:simple_streaming_app/features/music/domain/entity/downloaded_music_entity.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_list_entity.dart';
import 'package:simple_streaming_app/features/music/domain/service/music_service.dart';
import 'package:simple_streaming_app/features/music/dto/delete_music_dto.dart';
import 'package:simple_streaming_app/features/music/dto/download_music_dto.dart';
import 'package:simple_streaming_app/features/music/dto/search_by_artist_dto.dart';
import 'package:meta/meta.dart';
import 'package:simple_streaming_app/features/music/errors/failures.dart';

class MusicServiceImpl extends BaseService implements MusicService{
  MusicRemoteDataSource musicRemoteDataSource;
  TempFileManager _currentTempFileManager;

  MusicServiceImpl({
    @required this.musicRemoteDataSource
  });

  @override
  Future<Result<Failure, MusicListEntity>> searchByArtist(SearchByArtistDTO params) async{
    return this.request<MusicListEntity>(
      callback: () async{
        MusicListModel model = await musicRemoteDataSource.searchByArtist(params);
        return model.entity;
      },
      otherErrorCallback: this._handleOnErrorSearchByArtistData
    );
  }

  Failure _handleOnErrorSearchByArtistData(BaseException ex) {
    return SearchMusicFailure(ex.message);
  }

  @override
  Future<Result<Failure, bool>> deleteMusic(DeleteMusicDTO params) async{
    try{
      bool result = await _currentTempFileManager.deleteFile();
      return Result.success(result);
    }catch(ex){
      return Result.success(false);
    }
  }

  @override
  Future<Result<Failure, DownloadedMusicEntity>> downloadMusic(DownloadMusicDTO params) async{
    return this.request<DownloadedMusicEntity>(
      callback: () async{
        TempFileManager tempFileManager = await musicRemoteDataSource.downloadMusic(params);
        return DownloadedMusicEntity(
          musicLocalPath: tempFileManager.getFullFilePath()
        );
      },
      otherErrorCallback: this._handleOnErrorDownloadMusic
    );
  }

  Failure _handleOnErrorDownloadMusic(BaseException ex) {
    return DownloadMusicFailure(ex.message);
  }
}