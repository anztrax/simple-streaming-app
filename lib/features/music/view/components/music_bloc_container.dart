import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_entity.dart';
import 'package:simple_streaming_app/features/music/view/bloc/music_bloc.dart';
import 'package:simple_streaming_app/features/music/view/bloc/music_state.dart';

typedef MusicBlocChildrenBuilder = Widget Function(BuildContext context, {
  MusicEntity playedMusicEntity,
  bool isPlayed
});

class MusicBlocContainer extends StatefulWidget{
  final MusicBlocChildrenBuilder builder;

  MusicBlocContainer({
    @required this.builder,
  });

  @override
  State<StatefulWidget> createState() {
    return _MusicBlocContainerState();
  }
}

class _MusicBlocContainerState extends State<MusicBlocContainer>{
  MusicBloc musicBloc;

  @override
  void initState() {
    super.initState();
    musicBloc = BlocProvider.of<MusicBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicBloc,MusicState>(
      bloc: musicBloc,
      listener: (context, state){

      },
      builder: (context,MusicState state){
        MusicEntity entity;
        if(state is MusicPlayedState){
          entity = state.entity;
        }else if(state is MusicPausedState){
          entity = state.entity;
        }

        return widget.builder(context,
          playedMusicEntity: entity,
          isPlayed: (state is MusicPlayedState)
        );
      },
    );
  }
}