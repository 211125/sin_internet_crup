// getpost_state.dart

import '../../../data/models/getuser_model.dart';

abstract class GetPostState {}

class PostsInitial extends GetPostState {}

class PostsLoading extends GetPostState {}

class PostsLoaded extends GetPostState {
  final List<PostModel> posts;

  PostsLoaded(this.posts);
}

class PostsLoadFailure extends GetPostState {
  final String error;

  PostsLoadFailure(this.error);
}
