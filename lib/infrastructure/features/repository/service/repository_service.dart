import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_viewer/domain/features/repository/export.dart';
import 'package:github_viewer/infrastructure/features/repository/export.dart';

class RepositoryService implements IRepositoryService {
  final Dio httpClient;

  RepositoryService({
    required this.httpClient,
  });

  @override
  Future<List<Repository>> searchRepositories(String query) async {
    httpClient.options.headers['Authorization'] = dotenv.env['API_KEY'];

    final response = await httpClient.get(
      'https://api.github.com/search/repositories?q=$query',
    );

    final List<dynamic> jsonList = response.data['items'];

    return jsonList
        .map((json) => RepositoryDTO.fromJson(json).toDomain())
        .toList();
  }

  @override
  Future<List<RepositoryIssue>> getOpenIssues(
    Repository repository,
  ) async {
    httpClient.options.headers['Authorization'] = dotenv.env['API_KEY'];

    final response = await httpClient.get(
        'https://api.github.com/repos/${repository.owner.login}/${repository.name}/issues');
    final List<dynamic> jsonList = response.data;
    return jsonList
        .map((json) => RepositoryIssueDTO.fromJson(json).toDomain())
        .toList();
  }

  @override
  Future<List<RepositoryPullRequest>> getPullRequests(
    Repository repository,
  ) async {
    httpClient.options.headers['Authorization'] = dotenv.env['API_KEY'];

    final response = await httpClient.get(
        'https://api.github.com/repos/${repository.owner.login}/${repository.name}/pulls');
    final List<dynamic> jsonList = response.data;
    return jsonList
        .map((json) => RepositoryPullRequestDTO.fromJson(json).toDomain())
        .toList();
  }
}
