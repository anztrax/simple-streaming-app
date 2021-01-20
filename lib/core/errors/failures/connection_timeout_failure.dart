import 'package:simple_streaming_app/core/errors/failures/failure.dart';

class ConnectionTimeoutFailure extends Failure{
  String titleText = 'Koneksi terputus';
  String descriptionText = 'Pastikan untuk menyambungkan ulang perangkat dengan data seluler atau wifi ';
  ConnectionTimeoutFailure() : super(message: "Koneksi terputus");
}