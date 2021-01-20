import 'package:meta/meta.dart';
import 'package:simple_streaming_app/features/music/domain/entity/downloaded_music_entity.dart';

class DownloadMusicDTO{
  final String remoteMusicUrl;

  DownloadMusicDTO({
    @required this.remoteMusicUrl
  });
}
