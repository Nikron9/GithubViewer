import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_viewer/domain/features/repository/export.dart';
import 'package:github_viewer/presentation/features/repository_details/export.dart';

class RepositoryDetailsBloc
    extends Bloc<RepositoryDetailsEvent, RepositoryDetailsState> {
  final IRepositoryService repositoryService;

  RepositoryDetailsBloc({
    required this.repositoryService,
  }) : super(RepositoryDetailsLoading());

  @override
  Stream<RepositoryDetailsState> mapEventToState(
    RepositoryDetailsEvent event,
  ) async* {
    if (event is LoadRepositoryDetailsEvent) {
      yield RepositoryDetailsLoading();
      try {
        final openIssues = await repositoryService.getOpenIssues(
          event.repository,
        );
        final pullRequests = await repositoryService.getPullRequests(
          event.repository,
        );

        yield RepositoryDetailsLoaded(
            repository: event.repository,
            openIssues: openIssues,
            pullRequests: pullRequests);
      } catch (e) {
        yield RepositoryDetailsError();
      }
    }
  }
}
