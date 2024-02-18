import 'package:flutter_test/flutter_test.dart';
import 'package:github_viewer/infrastructure/features/repository/export.dart';
import 'package:github_viewer/infrastructure/features/user/export.dart';

void main() {
  group('RepositoryDTO to Domain Mapper', () {
    test('should map RepositoryDTO to Repository domain object', () {
      // Given
      final repositoryDto = RepositoryDTO(
        name: 'repo',
        owner: UserDTO(login: 'user'),
        forksCount: 10,
        stargazersCount: 20,
        issuesUrl: 'issuesUrl',
        pullRequestsUrl: 'pullRequestsUrl',
      );

      // When
      final repository = repositoryDto.toDomain();

      // Then
      expect(repository.name, repositoryDto.name);
      expect(repository.owner.login, repositoryDto.owner.login);
      expect(repository.forksCount, repositoryDto.forksCount);
      expect(repository.stargazersCount, repositoryDto.stargazersCount);
      expect(repository.issuesUrl, repositoryDto.issuesUrl);
      expect(repository.pullRequestsUrl, repositoryDto.pullRequestsUrl);
    });
  });

  group('RepositoryIssueDTO to Domain Mapper', () {
    test('should map RepositoryIssueDTO to RepositoryIssue domain object', () {
      // Given
      final repositoryIssueDto = RepositoryIssueDTO(
        title: 'issue',
        reporter: UserDTO(login: 'user'),
        state: 'open',
      );

      // When
      final repositoryIssue = repositoryIssueDto.toDomain();

      // Then
      expect(repositoryIssue.title, repositoryIssueDto.title);
      expect(repositoryIssue.reporter.login, repositoryIssueDto.reporter.login);
      expect(repositoryIssue.state, repositoryIssueDto.state);
    });
  });

  group('RepositoryPullRequestDTO to Domain Mapper', () {
    test(
        'should map RepositoryPullRequestDTO to RepositoryPullRequest domain object',
        () {
      // Given
      final repositoryPullRequestDto = RepositoryPullRequestDTO(
        title: 'PR',
        creator: UserDTO(login: 'user'),
        state: 'open',
      );

      // When
      final repositoryPullRequest = repositoryPullRequestDto.toDomain();

      // Then
      expect(repositoryPullRequest.title, repositoryPullRequestDto.title);
      expect(repositoryPullRequest.creator.login,
          repositoryPullRequestDto.creator.login);
      expect(repositoryPullRequest.state, repositoryPullRequestDto.state);
    });
  });
}
