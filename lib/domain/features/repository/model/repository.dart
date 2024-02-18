import 'package:github_viewer/domain/features/user/export.dart';

class Repository {
  final String name;
  final User owner;
  final int forksCount;
  final int stargazersCount;
  final String issuesUrl;
  final String pullRequestsUrl;

  Repository({
    required this.name,
    required this.owner,
    required this.forksCount,
    required this.stargazersCount,
    required this.issuesUrl,
    required this.pullRequestsUrl,
  });
}
