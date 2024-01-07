import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/user_preferences_builder_bloc.dart';
import 'bloc/user_preferences_builder_event.dart';
import 'bloc/schedule_builder_bloc.dart';
import 'bloc/block_bloc.dart';

import 'screens/home_screen.dart';

import 'services/schedule_service.dart';
import 'services/preferences_service.dart';

import 'repositories/schedule_repository.dart';
import 'repositories/block_repository.dart';

import 'models/user_preferences_builder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TakuTime());
}

class TakuTime extends StatelessWidget {
  const TakuTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider<ScheduleRepository>(
        //   create: (_) => ScheduleRepository(),
        // ),
        // Provider<BlockRepository>(
        //   create: (_) => BlockRepository(),
        // ),
        // Provider<ScheduleService>(
        //   create: (_) => ScheduleService(
        //     Provider.of<ScheduleRepository>(_, listen: false),
        //   ),
        // ),
        Provider<PreferencesService>(
          create: (_) => PreferencesService(),
        ),
        BlocProvider(
            create: (context) => UserPreferencesBuilderBloc(
                preferencesService:
                    Provider.of<PreferencesService>(context, listen: false))),
        // BlocProvider(
        //   create: (context) => ScheduleBuilderBloc(
        //     scheduleService:
        //         Provider.of<ScheduleService>(context, listen: false),
        //   ),
        // ),
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
