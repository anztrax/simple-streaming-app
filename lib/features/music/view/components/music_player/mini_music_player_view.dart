import 'package:flutter/material.dart';
import 'package:simple_streaming_app/core/view/theme/color_theme.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_entity.dart';

class MiniMusicPlayerView extends StatefulWidget{
  final MusicEntity musicEntity;
  final bool isPlayed;
  final Function onToggleMusic;

  MiniMusicPlayerView({
    @required this.musicEntity,
    @required this.isPlayed,
    @required this.onToggleMusic
  });

  @override
  State<StatefulWidget> createState() {
    return _MiniMusicPlayerViewState();
  }
}

class _MiniMusicPlayerViewState extends State<MiniMusicPlayerView>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: ColorTheme.lightGrey
          ),
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: buildCurrentTrackView(),
          ),
          buildControlButton(),
        ],
      ),
    );
  }

  Widget buildCurrentTrackView(){
    const double _IMAGE_SIZE = 76.0;

    return Row(
      children: [
        Image.network(
          widget.musicEntity.trackImage,
          width: _IMAGE_SIZE,
          height: _IMAGE_SIZE,
        ),
        SizedBox(
          width: 12.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.musicEntity.trackName, style: TextStyle(
                color: ColorTheme.neutralBlueGrey,
                fontSize: 16.0
              )),
              SizedBox(
                height: 6.0,
              ),

              Text(widget.musicEntity.artistName, style: TextStyle(
                color: ColorTheme.neutralBlueGrey,
                fontSize: 14.0
              ), overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ],
          ) ,
        )
      ],
    );
  }


  Widget buildControlButton({
    String iconUrl,
  }){
    const double _SIZE_WIDTH = 50.0;
    IconData iconData = (widget.isPlayed)
      ? Icons.pause_rounded
      : Icons.play_arrow_rounded;

    return Container(
      padding: EdgeInsets.only(
        top: 12.0,
        right: 12.0,
        bottom: 12.0
      ),
      child: GestureDetector(
        onTap: widget.onToggleMusic,
        child: Container(
          width: _SIZE_WIDTH,
          height: _SIZE_WIDTH,
          decoration: new BoxDecoration(
            color: ColorTheme.lightGrey,
            shape: BoxShape.circle,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.0
            ),
            child: Icon(
              iconData,
              color: ColorTheme.neutralDarkGrey
            ),
          ),
        )
      ),
    );
  }
}