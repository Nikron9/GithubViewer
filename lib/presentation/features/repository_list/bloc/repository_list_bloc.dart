import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_viewer/domain/features/repository/export.dart';
import 'package:github_viewer/presentation/features/repository_list/export.dart';

class RepositoryListBloc
    extends Bloc<RepositoryListEvent, RepositoryListState> {
  RepositoryListBloc({
    required this.repositoryService,
  }) : super(RepositoryListInit());

  final IRepositoryService repositoryService;

  @override
  Stream<RepositoryListState> mapEventToState(
    RepositoryListEvent event,
  ) async* {
    if (event is RepositoryListSearchEvent) {
      yield RepositoryListLoading(searchValue: event.searchValue);
      try {
        final repositories = await _fetchRepositories(event.searchValue);
        yield RepositoryListLoaded(
          searchValue: event.searchValue,
          repositories: repositories,
        );
      } catch (e) {
        yield RepositoryListError(searchValue: event.searchValue);
      }
    }

    if (event is RepositoryListRefreshEvent) {
      yield RepositoryListLoading(searchValue: state.searchValue);
      try {
        final repositories = await _fetchRepositories(state.searchValue);
        yield RepositoryListLoaded(
          searchValue: state.searchValue,
          repositories: repositories,
        );
      } catch (e) {
        yield RepositoryListError(searchValue: state.searchValue);
      }
    }
  }

  Future<List<Repository>> _fetchRepositories(String query) async =>
      repositoryService.searchRepositories(query);
}
