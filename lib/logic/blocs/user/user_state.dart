part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoginSuccess extends UserState {
  final User user;

  const UserLoginSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserLoggingOut extends UserState {}

class UserLoaded extends UserState {
  final List<User> userData;
  const UserLoaded(this.userData);
}

class UserSuccess extends UserState {}

class UserFailure extends UserState {
  final String message;

  const UserFailure(this.message);

  @override
  List<Object> get props => [message];
}
