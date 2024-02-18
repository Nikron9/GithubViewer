import 'package:github_viewer/domain/features/repository/export.dart';
import 'package:github_viewer/infrastructure/features/repository/export.dart';
import 'package:github_viewer/infrastructure/features/user/export.dart';

extension RepositoryMapping on RepositoryDTO {
  Repository toDomain() {
    return Repository(
      name: name,
      owner: owner.toDomain(),
      forksCount: forksCount,
      stargazersCount: stargazersCount,
      issuesUrl: issuesUrl,
      pullRequestsUrl: pullRequestsUrl,
    );
  }
}

extension RepositoryIssueMapping on RepositoryIssueDTO {
  RepositoryIssue toDomain() {
    return RepositoryIssue(
      title: title,
      reporter: reporter.toDomain(),
      state: state,
    );
  }
}

extension RepositoryPullRequestMapping on RepositoryPullRequestDTO {
  RepositoryPullRequest toDomain() {
    return RepositoryPullRequest(
      title: title,
      creator: creator.toDomain(),
      state: state,
    );
  }
}
