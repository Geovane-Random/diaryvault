import 'package:dairy_app/app/routes/routes.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';
import 'package:dairy_app/core/pages/home_page.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:dairy_app/features/sync/presentation/bloc/notes_sync/notesync_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/servicecontrol/v2.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthSessionBloc>(
          create: (context) => sl<AuthSessionBloc>(),
        ),
        BlocProvider<NotesBloc>(
          create: (context) => sl<NotesBloc>(),
        ),
        BlocProvider<NotesFetchCubit>(
          create: (context) => sl<NotesFetchCubit>(),
        ),
        BlocProvider<SelectableListCubit>(
          create: (context) => sl<SelectableListCubit>(),
        ),
        BlocProvider<NoteSyncCubit>(
          create: (context) => sl<NoteSyncCubit>(),
        ),
        BlocProvider<UserConfigCubit>(
          create: (context) => sl<UserConfigCubit>(),
        )
      ],
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  AppView({
    Key? key,
  }) : super(key: key);

  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'My dairy',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.pinkAccent.withOpacity(0.5),
            ),
          ),
        ),
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(
          secondary: Colors.pinkAccent,
        ),
      ),
      builder: (BuildContext context, child) {
        final log = printer("App");

        return BlocListener<AuthSessionBloc, AuthSessionState>(
          listener: (context, state) {
            log.d("state is $state");
            if (state is Unauthenticated) {
              _navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => AuthPage()),
                  (route) => false);
            } else if (state is Authenticated) {
              _navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => HomePage()),
                  (route) => false);
            }
          },
          child: child,
        );
      },
      initialRoute: AuthPage.route,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
