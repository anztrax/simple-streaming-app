import 'package:simple_streaming_app/core/errors/failures/failure.dart';

class ServerUnavailableErrorFailure extends Failure{
  String titleText = 'Layanan kami saat ini tidak dapat digunakan';
  String descriptionText = 'Layanan kami saat ini tidak dapat digunakan. Kami akan segera kembali. Jika Anda membutuhkan bantuan Anda selalu dapat';
  ServerUnavailableErrorFailure(): super(message: 'Layanan kami saat ini tidak dapat digunakan');
}