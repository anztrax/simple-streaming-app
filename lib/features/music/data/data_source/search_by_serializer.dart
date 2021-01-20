import 'package:meta/meta.dart';

abstract class SearchBySerializer{
  static Map<String, String> _searchBy({
    @required String type,
    @required int limit,
    @required String country,
    @required String explicit,
    @required String lang,
    @required String term
  }){
    Map<String, String> data = {
      'term' :  term,
      'lang' : lang,
      'explicit': explicit,
      'country' : country,
      'limit' : limit.toString(),
      'entity' :  type
    };

    return data;
  }


  static Map<String, String> searchBySongEntity({
    String type = 'song',
    int limit = 20,
    String country = 'ID',
    String explicit = 'yes',
    String lang = 'ID',
    @required String term
  }) {
    Map<String, dynamic> data = _searchBy(
      type: type,
      limit: limit,
      country: country,
      explicit: explicit,
      lang: lang,
      term: term,
    );

    return data;
  }
}