import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:simple_streaming_app/app/dependency_injection_objects.dart';
import 'package:simple_streaming_app/core/domain/result.dart';
import 'package:simple_streaming_app/core/errors/failures/failure.dart';
import 'package:simple_streaming_app/features/music/domain/entity/downloaded_music_entity.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_entity.dart';
import 'package:simple_streaming_app/features/music/domain/service/music_service.dart';
import 'package:simple_streaming_app/features/music/dto/delete_music_dto.dart';
import 'package:simple_streaming_app/features/music/dto/download_music_dto.dart';
import 'package:simple_streaming_app/features/music/view/bloc/music_event.dart';
import 'package:simple_streaming_app/features/music/view/bloc/music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState>{
  MusicEntity musicEntity;
  MusicService musicService;
  AudioPlayer audioPlayer;
  String musicLocalPath;

  MusicBloc(){
    musicService = DependencyInjectionObject.getMusicService();
    _initAudio();
  }

  void _initAudio(){
    audioPlayer = AudioPlayer();
    if(Platform.isIOS){
      audioPlayer.startHeadlessService();
    }
  }

  @override
  MusicState get initialState => MusicNotSelectedState();

  @override
  Stream<MusicState> mapEventToState(MusicEvent event) async*{
    if(event is SelectMusicEvent && (musicEntity == null || musicEntity.trackId != event.musicEntity.trackId)){
      musicEntity = event.musicEntity;
      audioPlayer.play(musicEntity.previewUrl);
      yield MusicPlayedState(
        entity: musicEntity,
      );
    }

    if(event is PauseMusicEvent){
      await audioPlayer.pause();
      yield MusicPausedState(
        entity: musicEntity,
      );
    }


    if(event is ResumeMusicEvent){
      await audioPlayer.resume();
      yield MusicPlayedState(
        entity: musicEntity,
      );
    }
  }
}