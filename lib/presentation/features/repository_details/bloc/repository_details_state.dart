import 'package:github_viewer/domain/features/repository/export.dart';

abstract class RepositoryDetailsState {}

class RepositoryDetailsLoading extends RepositoryDetailsState {}

class RepositoryDetailsLoaded extends RepositoryDetailsState {
  final Repository repository;
  final List<RepositoryIssue> openIssues;
  final List<RepositoryPullRequest> pullRequests;

  RepositoryDetailsLoaded({
    required this.repository,
    required this.openIssues,
    required this.pullRequests,
  });
}

class RepositoryDetailsError extends RepositoryDetailsState {}
