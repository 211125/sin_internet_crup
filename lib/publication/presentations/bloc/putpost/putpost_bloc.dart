// putpost_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/publication/domain/usecases/putpost_usercase.dart';
import './putpost_event.dart';
import 'putpost_state.dart';
import '../connectivity_service.dart';

class PutPostBloc extends Bloc<PutPostEvent, PutPostState> {
  final UpdateUserUseCase? updateUserUseCase;
  final ConnectivityService connectivityService;

  PutPostBloc(
      {required this.updateUserUseCase, required this.connectivityService})
      : super(InitialState());

  @override
  Stream<PutPostState> mapEventToState(PutPostEvent event) async* {
    if (event is UpdateUserEvent) {
      yield LoadingState();
      try {
        bool isConnected = connectivityService.isConnected;

        await updateUserUseCase?.execute(event.user,isConnected);
        yield UpdatedState();
        yield PostUpdatedSuccessfullyState();
      } catch (e) {
        yield ErrorState(e.toString());
      }
    } else if (event is ResetEvent) {
      yield InitialState();
    }
  }
}
