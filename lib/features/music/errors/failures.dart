import 'package:simple_streaming_app/core/errors/failures/failure.dart';

class SearchMusicFailure extends Failure {
  SearchMusicFailure(String message) : super(message: message);
}

class DownloadMusicFailure extends Failure{
  DownloadMusicFailure(String message): super(message: message);
}