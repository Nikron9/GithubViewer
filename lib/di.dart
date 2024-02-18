import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:github_viewer/domain/features/repository/export.dart';
import 'package:github_viewer/infrastructure/features/repository/export.dart';
import 'package:github_viewer/presentation/features/repository_details/bloc/repository_details_bloc.dart';
import 'package:github_viewer/presentation/features/repository_list/bloc/repository_list_bloc.dart';

final di = GetIt.instance;

extension DI on GetIt {
  void setup() {
    di.registerSingleton<Dio>(
      Dio(),
    );

    di.registerFactory<IRepositoryService>(
      () => RepositoryService(
        httpClient: di.get(),
      ),
    );

    di.registerFactory<RepositoryListBloc>(
      () => RepositoryListBloc(
        repositoryService: di.get(),
      ),
    );

    di.registerFactory<RepositoryDetailsBloc>(
      () => RepositoryDetailsBloc(
        repositoryService: di.get(),
      ),
    );
  }
}
