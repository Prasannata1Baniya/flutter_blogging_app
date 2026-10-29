import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/auth_repo.dart';

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState{
  const AuthLoading();
}

class Authenticated extends AuthState {
  const Authenticated();
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthFailure extends AuthState {
  const AuthFailure(this.message);
  final String message;
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(const AuthInitial()) {
    _authSubscription = _repository.authStateChanges.listen((user) {
      if (user == null) {
        emit(const Unauthenticated());
      } else {
        emit(const Authenticated());
      }
    });
  }

  final AuthRepo _repository;
  late final StreamSubscription<User?> _authSubscription;

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoading());
    try {
      await _repository.signIn(email: email, password: password);
    } catch (error) {
      emit(AuthFailure(_messageFor(error)));
    }
  }

  Future<void> register({required String email, required String password, required String name}) async {
    emit(const AuthLoading());
    try {
      await _repository.register(email: email, password: password, name: name);
    } catch (error) {
      emit(AuthFailure(_messageFor(error)));
    }
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    try {
      await _repository.signOut();
    } catch (error) {
      emit(AuthFailure(_messageFor(error)));
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  String _messageFor(Object error) {
    final text = error.toString();
    if (text.contains('email-already-in-use')) {
      return 'That email already has an account.';
    }
    if (text.contains('wrong-password') ||
        text.contains('invalid-credential')) {
      return 'Your email or password is incorrect.';
    }
    if (text.contains('user-not-found')) {
      return 'No account exists for that email.';
    }
    return 'Authentication failed. Please try again.';
  }
}