import 'package:github_viewer/domain/features/user/export.dart';

class RepositoryIssue {
  final String title;
  final User reporter;
  final String state;

  RepositoryIssue({
    required this.reporter,
    required this.state,
    required this.title,
  });
}
