import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app/features/blog/domain/entities/post.dart';

import '../../data/data_sources/repository/blog_repository.dart';


sealed class BlogState{
  const BlogState();
}

class BlogInitial extends BlogState{
  const BlogInitial();
}

class BlogLoading extends BlogState{
  const BlogLoading();
}

class BlogSuccess extends BlogState {
  const BlogSuccess(this.posts);
  final List<Post> posts;
}

class BlogFailure extends BlogState{
  const BlogFailure(this.error);
  final String error;
}

class BlogCubit extends Cubit<BlogState>{
 BlogCubit (this._repository) : super(const BlogInitial());
 final BlogRepo _repository;


 Future<void> getPosts() async{
   emit (const BlogLoading());

   try{
     final posts = await _repository.getPosts();
     emit(BlogSuccess(posts));
   }catch(e){
     emit(BlogFailure("Failed to load posts. Please try again."));
   }
 }
}