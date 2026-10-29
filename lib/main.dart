import 'package:blog_app/core/network/api_client.dart';
import 'package:blog_app/features/auth/data/repository/auth_repo.dart';
import 'package:blog_app/features/auth/data/session_store.dart';
import 'package:blog_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:blog_app/features/blog/data/data_sources/repository/blog_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/blog/data/data_sources/local_storage/saved_posts_store.dart';
import 'features/blog/data/data_sources/repository/saved_post_repo.dart';
import 'features/blog/domain/repo/saved_post_repository.dart';

//go router, firebase, shared preferences, dio,

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseAuth>(create: (_) => FirebaseAuth.instance,),
        RepositoryProvider<SessionStore>(create: (_) => SessionStore(),),
        RepositoryProvider<SavedPostsStore>(create: (_) => SavedPostsStore(),),
        RepositoryProvider<SavedPostsRepository>(
          create: (context) => SavedPostsRepo(
            context.read<SavedPostsStore>(),
          ),
        ),
        RepositoryProvider<ApiClient>(
          create: (_) => ApiClient(),
        ),
        RepositoryProvider<BlogRepo>(create: (context)=>BlogRepo(context.read<ApiClient>())),
        RepositoryProvider<AuthRepo>(
          create: (context) => AuthRepo(
            context.read<FirebaseAuth>(),
            context.read<SessionStore>(),
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthCubit(
          context.read<AuthRepo>(),
        ),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Inkly',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}