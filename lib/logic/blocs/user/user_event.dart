part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

// Event triggered when the "Get Started" button is pressed
class CreateUser extends UserEvent {
  // We pass the data needed to create a user
  final UsersCompanion newUser;

  const CreateUser(this.newUser);

  @override
  List<Object> get props => [newUser];
}

class LoginUser extends UserEvent {
  final String username;
  final String password;

  const LoginUser({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class CheckSession extends UserEvent {}

class LoadUsers extends UserEvent {}

class LogoutUser extends UserEvent {}
