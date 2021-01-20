import 'package:simple_streaming_app/core/errors/failures/failure.dart';

class NetworkOfflineFailure extends Failure{
  String titleText = 'Anda tidak terhubung dengan internet';
  String descriptionText = 'Pastikan untuk menyambungkan ulang perangkat dengan data seluler atau wifi ';
  NetworkOfflineFailure() : super(message: "Tidak ada Jaringan Internet");
}