import 'package:meta/meta.dart';

class SearchByArtistDTO{
  final String artistName;

  SearchByArtistDTO({
    @required this.artistName
  });

  String getArtistName(){
    return artistName.trim();
  }
}