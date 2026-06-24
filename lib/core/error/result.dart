sealed class Result<T> {}
final class Ok<T> extends Result<T> { final T value; Ok(this.value); }
final class Err<T> extends Result<T> { final Object error; Err(this.error); }
