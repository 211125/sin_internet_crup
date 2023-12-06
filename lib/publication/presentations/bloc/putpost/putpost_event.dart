// putpost_event.dart
import '../../../data/models/getuser_model.dart';

abstract class PutPostEvent {}

class UpdateUserEvent extends PutPostEvent {
  final PostModel user;
  UpdateUserEvent(this.user);
}

class ResetEvent extends PutPostEvent {}
