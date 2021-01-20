import 'package:meta/meta.dart';
import 'package:simple_streaming_app/core/errors/failures/failure.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_list_entity.dart';

abstract class SearchMusicState{}

class SearchMusicInitializedState extends SearchMusicState{}

class SearchMusicLoadingState extends SearchMusicState{}

class SearchMusicSuccessState extends SearchMusicState{
  MusicListEntity entity;

  SearchMusicSuccessState({
    @required this.entity
  });
}

class SearchMusicFailedState extends SearchMusicState{
  Failure failure;

  SearchMusicFailedState({
    @required this.failure
  });
}