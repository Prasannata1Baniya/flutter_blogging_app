
import '../../../domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.body,
    required super.imageUrl
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    return PostModel(
        id: id,
        userId: json['userId'] as int,
        title: json['title'] as String,
        body: json['body'] as String,
        imageUrl:"https://picsum.photos/seed/$id/600/400"
    );
  }
}
