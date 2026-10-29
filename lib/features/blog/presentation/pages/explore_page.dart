import 'package:blog_app/features/blog/presentation/cubit/blog_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/post.dart';
import '../cubit/saved_post_cubit.dart';
import 'post_details_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> _categories = [
    'All',
    'Technology',
    'Design',
    'Lifestyle',
    'Education',
    'Business',
    'Travel',
  ];

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: BlocBuilder<BlogCubit, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is BlogFailure) {
            return _ErrorState(
              message: state.error,
              onRetry: () {
                context.read<BlogCubit>().getPosts();
              },
            );
          }

          if (state is BlogSuccess) {
            final posts = state.posts.where((post) {
              final matchesSearch =
                  post.title.toLowerCase().contains(_searchQuery) ||
                      post.body.toLowerCase().contains(_searchQuery);

              return matchesSearch;
            }).toList();

            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 12, 4, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discover something new',
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Find stories worth reading, saving, and sharing.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),

                // Search
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Search stories...',
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                        ),
                      )
                          : null,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // Categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Browse by topic',
                      style: theme.textTheme.titleLarge,
                    ),
                    Icon(
                      Icons.tune_rounded,
                      size: 20,
                      color: colorScheme.primary,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (_, _) =>
                    const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final selected = category == _selectedCategory;

                      return ChoiceChip(
                        label: Text(category),
                        selected: selected,
                        onSelected: (_) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),

                // Results header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        _searchQuery.isEmpty
                            ? 'Latest stories'
                            : 'Search results',
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${posts.length}',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                if (posts.isEmpty)
                  _EmptySearchResult(
                    searchQuery: _searchQuery,
                  )
                else
                  ...posts.map(
                        (post) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _ExplorePostCard(
                        post: post,
                      ),
                    ),
                  ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ExplorePostCard extends StatelessWidget {
  const _ExplorePostCard({
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<SavedPostsCubit>(),
                child: PostDetailsPage(post: post),
              ),
            ),
          );
        },
        child: SizedBox(
          height: 124,
          child: Row(
            children: [
              // Image
              Image.network(
                post.imageUrl,
                width: 124,
                height: 124,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) {
                  return Container(
                    width: 124,
                    height: 124,
                    color: colorScheme.secondaryContainer,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: colorScheme.onSecondaryContainer,
                    ),
                  );
                },
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    14,
                    12,
                    14,
                    12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'STORY #${post.id}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 17,
                            color: colorScheme.primary,
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Expanded(
                        child: Text(
                          post.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        post.body,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptySearchResult extends StatelessWidget {
  const _EmptySearchResult({
    required this.searchQuery,
  });

  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 60,
      ),
      child: Column(
        children: [
          Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 42,
              color: colorScheme.primary,
            ),
          ),

          const SizedBox(height: 22),

          Text(
            'No stories found',
            style: theme.textTheme.titleLarge,
          ),

          const SizedBox(height: 8),

          Text(
            searchQuery.isEmpty
                ? 'There are no stories to show right now.'
                : 'We couldn’t find anything matching "$searchQuery".',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),

          if (searchQuery.isNotEmpty) ...[
            const SizedBox(height: 18),
            OutlinedButton.icon(
              onPressed: () {
                // The controller is owned by the parent.
                // Empty state remains informational for now.
              },
              icon: const Icon(Icons.tips_and_updates_outlined),
              label: const Text('Try another search'),
            ),
          ],
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cloud_off_rounded,
                size: 42,
                color: colorScheme.primary,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Something went wrong',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),

            const SizedBox(height: 8),

            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(height: 20),

            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}