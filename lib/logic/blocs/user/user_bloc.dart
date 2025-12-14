import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_fund/data/local/database/app_database.dart';
import 'package:track_fund/data/repositories/user_data_repositories.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserDataRepositories _repository;

  // We inject the database instance here
  UserBloc(this._repository) : super(UserInitial()) {
    on<CheckSession>((event, emit) async {
      // Don't emit UserLoading() here usually, or it flickers.
      // Just check fast.
      try {
        final prefs = await SharedPreferences.getInstance();
        final userId = prefs.getInt('userId');

        if (userId != null) {
          // Attempt to find the user in DB
          final user = await _repository.getUserById(userId);
          if (user != null) {
            emit(UserLoginSuccess(user));
          } else {
            emit(UserInitial()); // ID found but user deleted from DB?
          }
        } else {
          emit(UserInitial()); // No saved session
        }
      } catch (e) {
        emit(UserInitial());
      }
    });

    // Listen for the 'CreateUser' event
    on<CreateUser>((event, emit) async {
      emit(UserLoading()); // 1. Emit Loading State

      try {
        // 2. Perform the Database Operation
        await _repository.createUser(event.newUser);
        emit(UserSuccess());
      } catch (e) {
        // 4. Emit Failure State if it crashes
        emit(const UserFailure("Failed to create account. Please try again."));
        // In a real app, you might log 'e' to a crash reporting service
        print(e);
      }
    });

    on<LoginUser>((event, emit) async {
      emit(UserLoading());

      try {
        // 1. Call the repository to find the user
        final User? user = await _repository.loginUser(event.username, event.password);

        // 2. Check if user exists
        if (user != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('userId', user.id);
          emit(UserLoginSuccess(user));
        } else {
          // If null, the username or password was wrong
          emit(const UserFailure("Invalid username or password"));
        }
      } catch (e) {
        emit(UserFailure(e.toString()));
      }
    });

    on<LoadUsers>((event, emit) async {
      emit(UserLoading());

      await emit.forEach(
        _repository.getUserData(),
        onData: (List<User> data) {
          if (data.isEmpty) return UserInitial();
          return UserLoaded(data);
        },
        onError: (error, stackTrace) => UserFailure(error.toString()),
      );
    });

    on<LogoutUser>((event, emit) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('userId');
        await Future.delayed(const Duration(seconds: 1));
        emit(UserInitial());
      } catch (e) {
        emit(UserFailure("Failed to logout. Please try again"));
      }
    });
  }
}
