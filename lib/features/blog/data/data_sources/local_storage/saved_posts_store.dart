import 'package:shared_preferences/shared_preferences.dart';

class SavedPostsStore {
  static const _key = 'saved_post_ids';

  Future<List<int>> getSavedPostIds() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key) ?? [];

    return ids.map(int.parse).toList();
  }

  Future<void> savePost(int postId) async {
    final prefs = await SharedPreferences.getInstance();

    final ids = prefs.getStringList(_key) ?? [];

    if (!ids.contains(postId.toString())) {
      ids.add(postId.toString());
      await prefs.setStringList(_key, ids);
    }
  }

  Future<void> removePost(int postId) async {
    final prefs = await SharedPreferences.getInstance();

    final ids = prefs.getStringList(_key) ?? [];

    ids.remove(postId.toString());

    await prefs.setStringList(_key, ids);
  }

  Future<bool> isSaved(int postId) async {
    final prefs = await SharedPreferences.getInstance();

    final ids = prefs.getStringList(_key) ?? [];

    return ids.contains(postId.toString());
  }
}