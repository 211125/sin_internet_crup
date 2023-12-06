import '../../domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required int id,
    required String title,
    required String post,
  }) : super(id: id, title: title, post: post);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      post: json['post'],
    );
  }

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      title: post.title,
      post: post.post,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'post': post,
    };
  }
}
