
import 'package:blog_app/features/blog/domain/repo/saved_post_repository.dart';

import '../local_storage/saved_posts_store.dart';

class SavedPostsRepo implements SavedPostsRepository {
  final SavedPostsStore _store;

  SavedPostsRepo(this._store);

  @override
  Future<List<int>> getSavedPostIds() {
    return _store.getSavedPostIds();
  }

  @override
  Future<void> savePost(int postId) {
    return _store.savePost(postId);
  }

  @override
  Future<void> removePost(int postId) {
    return _store.removePost(postId);
  }

  @override
  Future<bool> isSaved(int postId) {
    return _store.isSaved(postId);
  }
}