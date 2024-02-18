import 'package:github_viewer/infrastructure/features/user/export.dart';

class RepositoryPullRequestDTO {
  final String title;
  final UserDTO creator;
  final String state;

  RepositoryPullRequestDTO({
    required this.title,
    required this.creator,
    required this.state,
  });

  factory RepositoryPullRequestDTO.fromJson(Map<String, dynamic> json) {
    return RepositoryPullRequestDTO(
      title: json['title'],
      creator: UserDTO.fromJson(json['user']),
      state: json['state'],
    );
  }
}
