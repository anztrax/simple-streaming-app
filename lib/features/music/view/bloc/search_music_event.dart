import 'package:meta/meta.dart';

abstract class SearchMusicEvent{}

class DoSearchMusicByArtistName extends SearchMusicEvent{
  String searchedArtistName;
  bool force;

  DoSearchMusicByArtistName({
    @required this.searchedArtistName,
    this.force = false
  });
}