import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/home_screen.dart';
import 'bloc/schedule_bloc.dart';
import 'bloc/block_bloc.dart';
import 'bloc/user_preferences_bloc.dart';
import 'services/schedule_service.dart';
import 'database/database_helper.dart';
import 'models/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final UserPreferences userPreferences = await loadUserPreferences();
  runApp(MyApp(userPreferences: userPreferences));
}

Future<UserPreferences> loadUserPreferences() async {
  try {
    return await UserPreferences.loadPreferences();
  } catch (_) {
    // If loading preferences fails, return default preferences
    return UserPreferences.defaultPreferences();
  }
}

class MyApp extends StatelessWidget {
  final UserPreferences userPreferences;

  MyApp({Key? key, required this.userPreferences}) : super(key: key);

  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BlockBloc(databaseHelper),
        ),
        BlocProvider(
          create: (context) => UserPreferencesBloc(),
        ),
        BlocProvider(
          create: (context) => ScheduleBloc(
            blockBloc: BlocProvider.of<BlockBloc>(context),
            userPreferencesBloc: BlocProvider.of<UserPreferencesBloc>(context),
            scheduleService: ScheduleService(userPreferences),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Schedule App',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
          primaryColor: Colors.blueGrey[800],
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blueGrey,
            accentColor: Colors.blueGrey[600],
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: Colors.grey[900],
          appBarTheme: AppBarTheme(
            color: Colors.blueGrey[900],
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
