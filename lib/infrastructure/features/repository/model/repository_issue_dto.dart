import 'package:github_viewer/infrastructure/features/user/export.dart';

class RepositoryIssueDTO {
  final String title;
  final UserDTO reporter;
  final String state;

  RepositoryIssueDTO({
    required this.reporter,
    required this.state,
    required this.title,
  });

  factory RepositoryIssueDTO.fromJson(Map<String, dynamic> json) {
    return RepositoryIssueDTO(
      title: json['title'],
      reporter: UserDTO.fromJson(json['user']),
      state: json['state'],
    );
  }
}
