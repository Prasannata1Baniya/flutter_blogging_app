abstract class SavedPostsRepository {
  Future<List<int>> getSavedPostIds();
  Future<void> savePost(int postId);
  Future<void> removePost(int postId);
  Future<bool> isSaved(int postId);
}