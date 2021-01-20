import '../errors/failures/failure.dart';

class Result<F extends Failure, D>{
  final F failure;
  final D data;

  Result({
    this.failure,
    this.data
  });

  factory Result.success(D data){
    return Result(
      data: data
    );
  }

  factory Result.failure(F failure){
    return Result(
      failure: failure
    );
  }

  bool isFailure(){
    return (this.failure != null);
  }
}