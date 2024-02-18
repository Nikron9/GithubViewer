abstract class RepositoryListEvent {}

class RepositoryListSearchEvent extends RepositoryListEvent {
  final String searchValue;

  RepositoryListSearchEvent({required this.searchValue});
}

class RepositoryListRefreshEvent extends RepositoryListEvent {
  RepositoryListRefreshEvent();
}
