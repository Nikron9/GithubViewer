import 'package:github_viewer/infrastructure/features/user/export.dart';

class RepositoryDTO {
  final String name;
  final UserDTO owner;
  final int forksCount;
  final int stargazersCount;
  final String issuesUrl;
  final String pullRequestsUrl;

  RepositoryDTO({
    required this.name,
    required this.owner,
    required this.issuesUrl,
    required this.pullRequestsUrl,
    required this.forksCount,
    required this.stargazersCount,
  });

  factory RepositoryDTO.fromJson(Map<String, dynamic> json) {
    return RepositoryDTO(
      name: json['name'],
      owner: UserDTO.fromJson(json['owner']),
      issuesUrl: json['issues_url'],
      pullRequestsUrl: json['pulls_url'],
      forksCount: json['forks_count'],
      stargazersCount: json['stargazers_count'],
    );
  }
}
