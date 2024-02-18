import 'package:github_viewer/domain/features/user/export.dart';

class RepositoryPullRequest {
  final String title;
  final User creator;
  final String state;

  RepositoryPullRequest({
    required this.creator,
    required this.state,
    required this.title,
  });
}
