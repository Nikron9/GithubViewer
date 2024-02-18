import 'package:github_viewer/domain/features/repository/export.dart';

abstract class IRepositoryService {
  Future<List<Repository>> searchRepositories(
    String query,
  );

  Future<List<RepositoryIssue>> getOpenIssues(
    Repository repository,
  );
  Future<List<RepositoryPullRequest>> getPullRequests(
    Repository repository,
  );
}
