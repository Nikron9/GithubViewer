import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_viewer/di.dart';
import 'package:github_viewer/presentation/features/repository_list/export.dart';
import 'package:github_viewer/ui/features/repository/export.dart';

void main() async {
  await dotenv.load(fileName: 'env/.env');

  di.setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Viewer',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => di.get<RepositoryListBloc>(),
        child: const RepositoryListPage(),
      ),
    );
  }
}
