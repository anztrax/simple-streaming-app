import 'package:flutter/material.dart';
import 'package:simple_streaming_app/core/view/theme/color_theme.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_entity.dart';

class MusicItemView extends StatelessWidget{
  final MusicEntity entity;
  final bool isActive;
  final bool isPlayed;

  MusicItemView({
    @required this.entity,
    @required this.isActive,
    @required this.isPlayed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (isActive) ? ColorTheme.lightGrey : ColorTheme.transparent,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0
      ),
      child: Row(
        children: [
          buildTrackImage(),
          SizedBox(
            width: 12.0
          ),
          Expanded(
            child: buildInfo(),
          ),
          SizedBox(
            width: 12.0,
          ),
          buildIndicator()
        ],
      ),
    );
  }

  Widget buildTrackImage(){
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Image.network(entity.trackImage,
        height: 60,
        width: 60,
        fit: BoxFit.contain
      ),
    );
  }

  Widget buildIndicator(){
    if(this.isPlayed && this.isActive){
      return Text('Playing', style: TextStyle(
        color: ColorTheme.neutralBlueGrey,
        fontSize: 12.0
      ));
    }

    return SizedBox();
  }

  Widget buildInfo(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(entity.trackName, style: TextStyle(
          color: ColorTheme.neutralBlueGrey,
          fontSize: 16.0,
          fontWeight: FontWeight.bold
        ),overflow: TextOverflow.ellipsis),
        SizedBox(
          height: 8.0,
        ),
        Text(entity.artistName, style: TextStyle(
          color: ColorTheme.neutralBlueGrey,
          fontSize: 14.0
        ),overflow: TextOverflow.ellipsis,),
        SizedBox(
          height: 8.0,
        ),
        Text(entity.collectionName, style: TextStyle(
          color: ColorTheme.neutralBlueGrey,
          fontSize: 12.0
        ),overflow: TextOverflow.ellipsis,),
      ],
    );
  }
}

