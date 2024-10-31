import 'package:df_ist_flutter/src/features/user/presentation/cubit/user_cubit.dart';
import 'package:df_ist_flutter/src/features/user/presentation/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(
              child: Text("Press the button to load user data"),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (user) => Center(
              child: Text("Hello, ${user.name}"),
            ),
            error: (message) => Center(
              child: Text("Error: $message"),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<UserCubit>().getUser(1);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
