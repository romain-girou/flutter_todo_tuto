import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/home.dart';
import 'package:flutter_todo/simple_bloc_observer.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'todo_bloc/todo_bloc.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	HydratedBloc.storage = await HydratedStorage.build(
		storageDirectory: await getTemporaryDirectory(),
	);
	Bloc.observer = SimpleBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Todo App',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
					background: Colors.white,
					onBackground: Colors.black,
					primary: Colors.yellowAccent,
					onPrimary: Colors.black,
					secondary: Colors.lightGreen,
					onSecondary: Colors.white
				),
      ),
      home: BlocProvider<TodoBloc>(
				create: (context) => TodoBloc()..add(
					TodoStarted()
				),
				child: const HomeScreen(),
			),
    );
  }
}
