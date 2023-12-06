abstract class DelitePostEvent {}

class DeleteUserEvent extends DelitePostEvent {
  final String id;
  DeleteUserEvent(this.id);
}
