
import '../../../data/models/posh_model.dart';
import '../../../domain/entities/Postcreate.dart';

abstract class CreatePostEvent {}

class CreateUserEvent extends CreatePostEvent {
  final createModel user;

  CreateUserEvent(this.user);
}

