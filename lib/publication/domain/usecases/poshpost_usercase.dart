import '../../data/models/posh_model.dart';
import '../repositories/user_repository.dart';

class CreateUserUseCase {
  final UserRepository userRepository;
  CreateUserUseCase(this.userRepository);
  Future<void> execute(createModel user, bool connection) async {
    try {
      await userRepository.createUser(user, connection);
    } catch (e, stackTrace) {
      print('Error al crear el usuario: $e');
      print('StackTrace: $stackTrace');
      throw e;
    }

  }
}