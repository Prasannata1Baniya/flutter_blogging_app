import 'package:blog_app/core/network/api_client.dart';
import '../../../domain/entities/post.dart';
import '../models/post_model.dart';

class BlogRepo{
  final ApiClient _apiClient;
  BlogRepo(this._apiClient);

  Future<List<Post>> getPosts() async {
    final response = await _apiClient.dio.get('/posts');

    return (response.data as List)
        .map<Post>(
          (item) => PostModel.fromJson(
        item as Map<String, dynamic>,
      ),
    ).toList();
  }
}