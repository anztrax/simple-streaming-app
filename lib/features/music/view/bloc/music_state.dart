import 'package:meta/meta.dart';
import 'package:simple_streaming_app/core/errors/failures/failure.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_entity.dart';

abstract class MusicState{}

class MusicPlayedState extends MusicState{
  final MusicEntity entity;

  MusicPlayedState({
    @required this.entity
  });
}

class MusicNotSelectedState extends MusicState{}

class MusicPausedState extends MusicState{
  final MusicEntity entity;

  MusicPausedState({
    @required this.entity
  });
}

class MusicFailureState extends MusicState{
  MusicEntity entity;
  Failure failure;

  MusicFailureState({
    @required this.entity,
    @required this.failure
  });
}