import 'package:bloc/bloc.dart';
import 'package:simple_streaming_app/app/dependency_injection_objects.dart';
import 'package:simple_streaming_app/core/domain/result.dart';
import 'package:simple_streaming_app/core/errors/failures/failure.dart';
import 'package:simple_streaming_app/features/music/domain/entity/music_list_entity.dart';
import 'package:simple_streaming_app/features/music/domain/service/music_service.dart';
import 'package:simple_streaming_app/features/music/dto/search_by_artist_dto.dart';
import 'package:simple_streaming_app/features/music/view/bloc/search_music_event.dart';
import 'package:simple_streaming_app/features/music/view/bloc/search_music_state.dart';

class SearchMusicBloc extends Bloc<SearchMusicEvent, SearchMusicState>{
  MusicService musicService;
  String currentSearchText;

  SearchMusicBloc(){
    musicService = DependencyInjectionObject.getMusicService();
  }

  @override
  SearchMusicState get initialState => SearchMusicInitializedState();

  @override
  Stream<SearchMusicState> mapEventToState(SearchMusicEvent event) async*{
    if(event is DoSearchMusicByArtistName){
      String trimmedSearchText = (event.force)
        ? currentSearchText
        : event.searchedArtistName.trim();

      bool isDoSearch = (event.force)
        ? true
        : currentSearchText != trimmedSearchText && event.searchedArtistName.length > 3;

      if(isDoSearch){
        currentSearchText = trimmedSearchText;
        yield SearchMusicLoadingState();
        Result<Failure, MusicListEntity> result = await musicService.searchByArtist(SearchByArtistDTO(
          artistName: currentSearchText
        ));

        if(result.isFailure()){
          yield SearchMusicFailedState(
            failure: result.failure
          );
        }else{
          yield SearchMusicSuccessState(
            entity: result.data
          );
        }
      }
    }
  }
}