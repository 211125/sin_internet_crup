abstract class DelitePostState {}

class UserInitial extends DelitePostState {}

class UserDeleting extends DelitePostState {}

class UserDeletedSuccessfully extends DelitePostState {}

class UserDeleteFailure extends DelitePostState {
  final String error;

  UserDeleteFailure(this.error);
}
