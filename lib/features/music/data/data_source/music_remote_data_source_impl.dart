import 'package:simple_streaming_app/core/file/file_manager.dart';
import 'package:simple_streaming_app/core/http/http_client.dart';
import 'package:simple_streaming_app/features/music/data/data_source/music_remote_data_source.dart';
import 'package:simple_streaming_app/features/music/data/data_source/search_by_serializer.dart';
import 'package:simple_streaming_app/features/music/data/model/music_list_model.dart';
import 'package:simple_streaming_app/features/music/dto/download_music_dto.dart';
import 'package:simple_streaming_app/features/music/dto/search_by_artist_dto.dart';


class MusicRemoteDataSourceImpl extends HttpClient implements MusicRemoteDataSource{
  MusicRemoteDataSourceImpl({
    String baseUrl,
  }): super(
    baseUrl: baseUrl
  );

  @override
  Future<MusicListModel> searchByArtist(SearchByArtistDTO params)  async{
    final response = await getDataFromRemoteTextFile(
      uri: "/search",
      queryParams: SearchBySerializer.searchBySongEntity(
        term: params.getArtistName()
      ),
    );

    return MusicListModel.fromJson(response);
  }

  @override
  Future<TempFileManager> downloadMusic(DownloadMusicDTO params) async{
    return this.downloadFile(uri: params.remoteMusicUrl);
  }
}