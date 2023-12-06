import 'package:bloc/bloc.dart';
import '../../../domain/usecases/poshpost_usercase.dart';
import 'createpost_event.dart';
import 'createpost_state.dart';
import '../connectivity_service.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final CreateUserUseCase? createUserUseCase;
  final ConnectivityService connectivityService;

  CreatePostBloc(
      {required this.createUserUseCase, required this.connectivityService})
      : super(UserInitial());

  @override
  Stream<CreatePostState> mapEventToState(CreatePostEvent event) async* {
    if (event is CreateUserEvent) {
      yield UserLoading();
      try {
        bool isConnected = connectivityService.isConnected;

        await createUserUseCase!.execute(event.user, isConnected);
        yield UserCreatedSuccessfully();
      } catch (e) {
        yield UserCreationFailure(e.toString());
      }
    }
  }
}
