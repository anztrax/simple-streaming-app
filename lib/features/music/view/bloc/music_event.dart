import 'package:meta/meta.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_entity.dart';

abstract class MusicEvent{}

class InitMusicEvent extends MusicEvent{}

class SelectMusicEvent extends MusicEvent{
  MusicEntity musicEntity;

  SelectMusicEvent({
    @required this.musicEntity
  });
}

class ResumeMusicEvent extends MusicEvent{}

class PauseMusicEvent extends MusicEvent{}