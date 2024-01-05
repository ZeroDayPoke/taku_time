import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user_preferences_builder_bloc.dart';
import 'bloc/user_preferences_builder_event.dart';
import 'bloc/schedule_bloc.dart';
import 'bloc/block_bloc.dart';

import 'screens/home_screen.dart';
import 'database/database_helper.dart';

import 'services/schedule_service.dart';
import 'services/preferences_service.dart';

import 'models/user_preferences_builder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TakuTime());
}

class TakuTime extends StatelessWidget {
  TakuTime({Key? key}) : super(key: key);

  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  final PreferencesService preferencesService = PreferencesService();

  @override
  Widget build(BuildContext context) {
    UserPreferencesBuilder userPreferencesBuilder =
        UserPreferencesBuilder.defaultBuilder();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BlockBloc(databaseHelper),
        ),
        BlocProvider(
          create: (context) =>
              UserPreferencesBuilderBloc(preferencesService: preferencesService)
                ..add(LoadUserPreferencesBuilder()),
        ),
        BlocProvider(
          create: (context) => ScheduleBloc(
            blockBloc: BlocProvider.of<BlockBloc>(context),
            userPreferencesBuilderBloc:
                BlocProvider.of<UserPreferencesBuilderBloc>(context),
            scheduleService: ScheduleService(userPreferencesBuilder),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'TakuTime',
        theme: _appTheme(),
        home: const HomeScreen(),
      ),
    );
  }

  ThemeData _appTheme() {
    return ThemeData(
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
    );
  }
}
