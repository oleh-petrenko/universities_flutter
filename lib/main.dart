import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universitytest/university_bloc/university_bloc.dart';
import 'package:universitytest/university_bloc/university_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universities loading test proj',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: BlocProvider<UniversityBloc>(
        create: (BuildContext context) => UniversityBloc(),
        child: const UniversityView(),
      ),
    );
  }
}
