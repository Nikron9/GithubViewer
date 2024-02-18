import 'package:github_viewer/domain/features/repository/export.dart';

class RepositoryDetailsEvent {
  final Repository repository;

  RepositoryDetailsEvent({required this.repository});
}

class LoadRepositoryDetailsEvent extends RepositoryDetailsEvent {
  LoadRepositoryDetailsEvent({required super.repository});
}
