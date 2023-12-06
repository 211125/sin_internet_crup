import '../../domain/entities/Postcreate.dart';
class createModel extends Postcreate {

  createModel({
    required String title,
    required String post
  }) : super( title: title, post: post );

  factory createModel.fromJson(List<dynamic> json) {
    return createModel(
      title: json[1],
      post: json[2],
    );
  }

  factory createModel.fromEntity(Postcreate post) {
    return createModel(
      title: post.title,
      post: post.post,
    );
  }
}
