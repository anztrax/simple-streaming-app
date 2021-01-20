import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:simple_streaming_app/core/config/config.dart';
import 'package:simple_streaming_app/core/file/file_manager.dart';
import 'package:simple_streaming_app/features/music/data/data_source/music_remote_data_source.dart';
import 'package:simple_streaming_app/features/music/data/data_source/music_remote_data_source_impl.dart';
import 'package:simple_streaming_app/features/music/data/service/music_service_impl.dart';
import 'package:simple_streaming_app/features/music/domain/service/music_service.dart';

class DependencyInjectionObject {
  void init({
    @required Config config
  }) {
    GetIt.I.registerLazySingleton<Config>(() => config);

    MusicRemoteDataSource musicRemoteDataSource = MusicRemoteDataSourceImpl(
      baseUrl: config.envUrl.baseUrl
    );

    MusicService musicService = MusicServiceImpl(
      musicRemoteDataSource: musicRemoteDataSource
    );

    GetIt.I.registerLazySingleton<MusicService>(() => musicService);
  }

  static MusicService getMusicService(){
    return GetIt.I<MusicService>();
  }
}

