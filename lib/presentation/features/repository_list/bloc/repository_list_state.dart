import 'package:github_viewer/domain/features/repository/export.dart';

abstract class RepositoryListState {
  final String searchValue;
  final List<Repository> repositories;

  RepositoryListState({
    required this.searchValue,
    required this.repositories,
  });
}

class RepositoryListInit extends RepositoryListState {
  RepositoryListInit()
      : super(
          repositories: [],
          searchValue: '',
        );
}

class RepositoryListLoading extends RepositoryListState {
  RepositoryListLoading({
    required super.searchValue,
  }) : super(
          repositories: [],
        );
}

class RepositoryListLoaded extends RepositoryListState {
  RepositoryListLoaded({
    required super.searchValue,
    required super.repositories,
  });
}

class RepositoryListError extends RepositoryListState {
  RepositoryListError({
    required super.searchValue,
  }) : super(
          repositories: [],
        );
}
