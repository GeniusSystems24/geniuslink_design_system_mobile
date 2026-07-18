abstract class StreamUseCase<Result, Params> {
  Stream<Result> call(Params params);
}
