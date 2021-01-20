import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_streaming_app/core/view/theme/color_theme.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_entity.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_list_entity.dart';
import 'package:meta/meta.dart';
import 'package:simple_streaming_app/features/music/view/components/music_items/music_item_view.dart';


class MusicItemListView extends StatelessWidget{
  final MusicEntity activeMusicEntity;
  final bool isPlayed;
  final MusicListEntity entity;
  final Function(MusicEntity) onTapItem;

  MusicItemListView({
    @required this.activeMusicEntity,
    @required this.isPlayed,
    @required this.entity,
    @required this.onTapItem
  });

  @override
  Widget build(BuildContext context) {
    return buildListView();
  }

  Widget buildListView(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: this.entity.musics.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context,int index) {
        MusicEntity musicEntity = this.entity.musics[index];
        return buildChildItem(
          musicEntity: musicEntity
        );
      },
    );
  }

  Widget buildChildItem({
    MusicEntity musicEntity
  }){
    var isActive = (this.activeMusicEntity != null) ? musicEntity.trackId == this.activeMusicEntity.trackId : false;
    return GestureDetector(
      onTap: () => this.onTapItem(musicEntity),
      child: Container(
        decoration: BoxDecoration(
          color: ColorTheme.transparent,
        ),
        child: MusicItemView(
          isActive: isActive,
          isPlayed: isPlayed,
          entity: musicEntity,
        ),
      ),
    );
  }
}