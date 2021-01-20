import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_streaming_app/features/music/view/bloc/music_bloc.dart';
import 'package:simple_streaming_app/features/music/view/bloc/search_music_bloc.dart';

class BlocContainer extends StatefulWidget{
  final Widget child;

  BlocContainer({
    @required this.child
  });

  @override
  State<StatefulWidget> createState() {
    return _BlocContainerState();
  }
}

class _BlocContainerState extends State<BlocContainer>{
  SearchMusicBloc searchMusicBloc;
  MusicBloc musicBloc;

  @override
  void initState() {
    super.initState();
    searchMusicBloc = SearchMusicBloc();
    musicBloc = MusicBloc();
  }

  @override
  void dispose() {
    searchMusicBloc.close();
    musicBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchMusicBloc>( create: (_) => searchMusicBloc),
        BlocProvider<MusicBloc>(create: (_) => musicBloc)
      ],
      child: widget.child,
    );
  }
}