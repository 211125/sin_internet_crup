// putpost_state.dart
abstract class PutPostState {}

class InitialState extends PutPostState {}

class LoadingState extends PutPostState {}

class UpdatedState extends PutPostState {}

class ErrorState extends PutPostState {
  final String error;
  ErrorState(this.error);
}
class PostUpdatedSuccessfullyState extends PutPostState {}
