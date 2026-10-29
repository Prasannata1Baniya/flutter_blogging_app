import 'package:blog_app/features/auth/presentation/pages/auth_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    if (!RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }
  String? _passwordValidator(String? value) =>
      value != null && value.length >= 6 ? null : 'Use at least 6 characters';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context,state){
          if(state is Authenticated){
            context.go('/home');
          }
          if(state is AuthFailure){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message))
          );
          }
        },
    builder: (context,state){
      return  AuthScaffold(
        title: 'Make space\nfor ideas.',
        subtitle: 'Create your reading nook in under a minute.',
        formKey: _formKey,

        actionLabel: 'Create account',
        onSubmit: () {
          if (_formKey.currentState!.validate()) {
            context.read<AuthCubit>().register(email: _email.text.trim(),
                password: _password.text,
            name:_name.text.trim());
          }
        },
        footer: 'Already a member?',
        footerAction: 'Sign in',
        onFooter: () => context.go('/login'),
        isLoading: state is AuthLoading,
        children: [
          TextFormField(
            controller: _name,
            decoration: const InputDecoration(
              labelText: 'Your name',
              prefixIcon: Icon(Icons.person_outline_rounded),
            ),
            validator: (v) => (v == null || v.trim().length < 2)
                ? 'Please enter your name'
                : null,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email address',
              prefixIcon: Icon(Icons.alternate_email_rounded),
            ),
            validator: _emailValidator,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline_rounded),
            ),
            validator: _passwordValidator,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _confirmPassword,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: Icon(Icons.lock_outline_rounded),
            ),
            validator: (value){
              if(value==null || value.isEmpty){
                return 'Confirm your password';
              }
              if(value!=_password.text){
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      );
    });
  }
}