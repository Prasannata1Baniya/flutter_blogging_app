import 'package:blog_app/features/blog/domain/repo/saved_post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedPostsCubit extends Cubit<Set<int>> {
  SavedPostsCubit(this._repository) : super({});

  final SavedPostsRepository _repository;

  Future<void> loadSavedPosts() async {
    final ids = await _repository.getSavedPostIds();
    emit(ids.toSet());
  }

  Future<void> toggleSaved(int postId) async {
    if (state.contains(postId)) {
      await _repository.removePost(postId);

      final updated = Set<int>.from(state)
        ..remove(postId);

      emit(updated);
    } else {
      await _repository.savePost(postId);

      final updated = Set<int>.from(state)
        ..add(postId);

      emit(updated);
    }
  }
}