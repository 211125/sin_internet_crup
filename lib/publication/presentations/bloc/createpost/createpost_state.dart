// createpost_state.dart

abstract class CreatePostState {}

class UserInitial extends CreatePostState {}

class UserLoading extends CreatePostState {}

class UserCreatedSuccessfully extends CreatePostState {}

class UserCreationFailure extends CreatePostState {
  final String error;

  UserCreationFailure(this.error);
}
