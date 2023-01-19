abstract class UseCaseParams<Type, Params> {
  Future<void> call(Params params);
}

abstract class UseCase<Type> {
  Future<Type> call();
}
