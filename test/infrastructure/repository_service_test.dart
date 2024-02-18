import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_viewer/domain/features/repository/export.dart';
import 'package:github_viewer/domain/features/user/export.dart';
import 'package:github_viewer/infrastructure/features/repository/export.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'repository_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group('RepositoryService', () {
    late RepositoryService repositoryService;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      repositoryService = RepositoryService(httpClient: mockDio);
      when(mockDio.options).thenReturn(BaseOptions());

      dotenv.testLoad(fileInput: '''API_KEY=foo''');
    });

    test('searchRepositories should make correct HTTP request', () async {
      // Given
      final query = 'flutter';
      final responseData = {
        'items': [
          {
            'name': 'repo1',
            'owner': {'login': 'user1'},
            'issues_url': '',
            'pulls_url': '',
            'forks_count': 0,
            'stargazers_count': 0
          },
          {
            'name': 'repo2',
            'owner': {'login': 'user2'},
            'issues_url': '',
            'pulls_url': '',
            'forks_count': 0,
            'stargazers_count': 0
          }
        ]
      };
      final response = Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(
          path: '',
        ),
      );

      when(mockDio.get(any)).thenAnswer((_) async => response);

      // When
      final result = await repositoryService.searchRepositories(query);

      // Then
      verify(mockDio.get('https://api.github.com/search/repositories?q=$query'))
          .called(1);
      expect(result.length, 2);
      expect(result[0].name, 'repo1');
      expect(result[0].owner.login, 'user1');
      expect(result[1].name, 'repo2');
      expect(result[1].owner.login, 'user2');
    });

    test('getOpenIssues should make correct HTTP request', () async {
      // Given
      final repository = Repository(
        name: 'repo',
        owner: User(login: 'user'),
        forksCount: 0,
        issuesUrl: '',
        pullRequestsUrl: '',
        stargazersCount: 0,
      );
      final responseData = [
        {
          'title': 'issue1',
          'user': {'login': 'user1'},
          'state': 'open'
        },
        {
          'title': 'issue2',
          'user': {'login': 'user1'},
          'state': 'open'
        }
      ];
      final response = Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(
          path: '',
        ),
      );

      when(mockDio.get(any)).thenAnswer((_) async => response);

      // When
      final result = await repositoryService.getOpenIssues(repository);

      // Then
      verify(mockDio.get(
              'https://api.github.com/repos/${repository.owner.login}/${repository.name}/issues'))
          .called(1);
      expect(result.length, 2);
      expect(result[0].title, 'issue1');
      expect(result[1].title, 'issue2');
    });

    test('getPullRequests should make correct HTTP request', () async {
      // Given
      final repository = Repository(
        name: 'repo',
        owner: User(login: 'user'),
        forksCount: 0,
        issuesUrl: '',
        pullRequestsUrl: '',
        stargazersCount: 0,
      );
      final responseData = [
        {
          'title': 'PR1',
          'user': {'login': 'user1'},
          'state': 'open'
        },
        {
          'title': 'PR2',
          'user': {'login': 'user1'},
          'state': 'open'
        }
      ];
      final response = Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(
          path: '',
        ),
      );

      when(mockDio.get(any)).thenAnswer((_) async => response);

      // When
      final result = await repositoryService.getPullRequests(repository);

      // Then
      verify(mockDio.get(
              'https://api.github.com/repos/${repository.owner.login}/${repository.name}/pulls'))
          .called(1);
      expect(result.length, 2);
      expect(result[0].title, 'PR1');
      expect(result[1].title, 'PR2');
    });
  });
}
