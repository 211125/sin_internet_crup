import 'package:bloc/bloc.dart';
import '../../../domain/usecases/getpost_usercase.dart.dart';
import '../connectivity_service.dart';
import 'getpost_event.dart';
import 'getpost_state.dart';

class GetPostBloc extends Bloc<GetPostEvent, GetPostState> {
  final GetUsersUseCase? getUsersUseCase;
  final ConnectivityService connectivityService;

  GetPostBloc({required this.getUsersUseCase, required this.connectivityService}) : super(PostsInitial());

  @override
  Stream<GetPostState> mapEventToState(GetPostEvent event) async* {
    if (event is FetchPostsEvent) {
      yield PostsLoading();
      try {
                    bool isConnected = connectivityService.isConnected;

        final posts = await getUsersUseCase!.execute(isConnected);

        yield PostsLoaded(posts);
      } catch (e) {
        yield PostsLoadFailure(e.toString());
      }
    }
  }
}