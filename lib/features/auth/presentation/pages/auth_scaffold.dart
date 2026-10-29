
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.formKey,
    required this.children,
    required this.actionLabel,
    required this.onSubmit,
    required this.footer,
    required this.footerAction,
    required this.onFooter,
    required this.isLoading
  });

  final String title, subtitle, actionLabel, footer, footerAction;
  final GlobalKey<FormState> formKey;
  final List<Widget> children;
  final VoidCallback onSubmit, onFooter;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: AppTheme.lavender,
                    foregroundColor: AppTheme.ink,
                  ),
                ),

                const SizedBox(height: 38),

                // Brand
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppTheme.purple,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.auto_stories_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Inkly',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 36),

                // Header
                Text(
                  title,
                  style: theme.textTheme.displaySmall,
                ),

                const SizedBox(height: 12),

                Text(
                  subtitle,
                  style: theme.textTheme.bodyLarge,
                ),

                const SizedBox(height: 38),

                // Form Fields
                ...children,

                const SizedBox(height: 28),

                // Submit Button
                FilledButton(
                  onPressed: isLoading? null: onSubmit,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(58),
                    backgroundColor: AppTheme.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: isLoading? const CircularProgressIndicator(): Text(actionLabel),
                ),

                const SizedBox(height: 22),

                // Footer
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        footer,
                        style: theme.textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: onFooter,
                        child: Text(
                          footerAction,
                          style: const TextStyle(
                            color: AppTheme.purple,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}