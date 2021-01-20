import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_streaming_app/core/view/theme/color_theme.dart';
import 'package:simple_streaming_app/features/common/view/components/connectivity_layout.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_entity.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_list_entity.dart';
import 'package:simple_streaming_app/features/music/view/bloc/music_bloc.dart';
import 'package:simple_streaming_app/features/music/view/bloc/music_event.dart';
import 'package:simple_streaming_app/features/music/view/bloc/music_state.dart';
import 'package:simple_streaming_app/features/music/view/bloc/search_music_bloc.dart';
import 'package:simple_streaming_app/features/music/view/bloc/search_music_event.dart';
import 'package:simple_streaming_app/features/music/view/bloc/search_music_state.dart';
import 'package:simple_streaming_app/features/music/view/components/loading_view.dart';
import 'package:simple_streaming_app/features/music/view/components/header/search_header_view.dart';
import 'package:simple_streaming_app/features/music/view/components/music_bloc_container.dart';
import 'package:simple_streaming_app/features/music/view/components/music_items/music_item_list_view.dart';
import 'package:simple_streaming_app/features/music/view/components/music_player/mini_music_player_view.dart';
import 'package:simple_streaming_app/features/music/view/components/search_result_pristine_view.dart';

class PlaylistPage extends StatefulWidget{
  static const String routeName = '/';

  @override
  State<StatefulWidget> createState() {
    return _PlaylistPageState();
  }
}

class _PlaylistPageState extends State<PlaylistPage>{
  SearchMusicBloc searchMusicBloc;
  MusicBloc musicBloc;

  @override
  void initState() {
    searchMusicBloc = BlocProvider.of<SearchMusicBloc>(context);
    musicBloc = BlocProvider.of<MusicBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: SearchHeaderView(
        viewData: SearchHeaderViewData(
          placeholderText: 'Search artist',
          onSearch: this.handleOnSearchArtist
        ),
      ),
      body: ConnectivityLayout(
        onAbleToReconnectInternet: this.handleOnReconnectInternet,
        builder: (context){
          return buildBodyView();
        },
      )
    );
  }

  Widget buildBodyView(){
    return MusicBlocContainer(
      builder: (BuildContext context, {
        MusicEntity playedMusicEntity,
        bool isPlayed
      }){

        return Column(
          children: [
            Expanded(
              child: buildSearchMusicView(
                playedMusicEntity: playedMusicEntity,
                isSongPlayed: isPlayed,
              ),
            ),
            (playedMusicEntity != null )
              ?  MiniMusicPlayerView(
                musicEntity: playedMusicEntity,
                isPlayed: isPlayed,
                onToggleMusic: () => this.handleOnToggleMusic(isPlayed)
              )
              : SizedBox()
          ],
        );
      }
    );
  }

  Widget buildSearchMusicView({
    @required MusicEntity playedMusicEntity,
    @required bool isSongPlayed
  }){
    return BlocConsumer<SearchMusicBloc, SearchMusicState>(
      bloc: searchMusicBloc,
      listener: (context, state){

      },
      builder: (BuildContext context, SearchMusicState state){
        if(state is SearchMusicInitializedState){
          return SearchResultPristineView();
        }

        if(state is SearchMusicLoadingState){
          return LoadingView();
        }

        if(state is SearchMusicSuccessState){
          return buildSearchResultView(state.entity,
            playedMusicEntity: playedMusicEntity,
            isSongPlayed: isSongPlayed,
          );
        }

        if(state is SearchMusicFailedState){
          return buildNotFoundView();
        }

        return SizedBox();
      }
    );
  }

  Widget buildSearchResultView(MusicListEntity musicListEntity, {
    @required MusicEntity playedMusicEntity,
    @required bool isSongPlayed
  }){
    if(musicListEntity != null && musicListEntity.resultCount > 0){
      return MusicItemListView(
        activeMusicEntity: playedMusicEntity,
        entity: musicListEntity,
        isPlayed: isSongPlayed,
        onTapItem: this.handleOnTapItem,
      );
    }

    return buildNotFoundView();
  }

  Widget buildNotFoundView(){
    return Container(
      child: Center(
        child: Text("Tidak dapat menemukan artis atau lagu yang anda cari "),
      ),
    );
  }

  /// handlers
  void handleOnSearchArtist({ String searchedText }){
    searchMusicBloc.add(DoSearchMusicByArtistName(
      searchedArtistName: searchedText
    ));
  }

  void handleOnTapItem(MusicEntity musicEntity){
    musicBloc.add(SelectMusicEvent(
      musicEntity: musicEntity
    ));
  }

  void handleOnToggleMusic(bool isPlayed){
    if(isPlayed){
      musicBloc.add(PauseMusicEvent());
    }else{
      musicBloc.add(ResumeMusicEvent());
    }
  }

  void handleOnReconnectInternet(){
    searchMusicBloc.add(DoSearchMusicByArtistName(
      force: true
    ));
  }
}