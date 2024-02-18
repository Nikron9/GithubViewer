import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_viewer/di.dart';
import 'package:github_viewer/presentation/features/repository_details/export.dart';
import 'package:github_viewer/presentation/features/repository_list/export.dart';
import 'package:github_viewer/ui/features/repository/export.dart';
import 'package:github_viewer/ui/features/search/app_search_bar.dart';

class RepositoryListPage extends StatelessWidget {
  const RepositoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Viewer'),
        elevation: 4,
      ),
      body: BlocBuilder<RepositoryListBloc, RepositoryListState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: AppSearchBar(
                  onChanged: (searchValue) =>
                      BlocProvider.of<RepositoryListBloc>(context).add(
                    RepositoryListSearchEvent(
                      searchValue: searchValue,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<RepositoryListBloc>(context).add(
                      RepositoryListRefreshEvent(),
                    );
                  },
                  child: state is RepositoryListLoading
                      ? const Center(child: CircularProgressIndicator())
                      : state is RepositoryListLoaded
                          ? ListView.builder(
                              itemCount: state.repositories.length,
                              itemBuilder: (context, index) {
                                return RepositoryListItem(
                                  repository: state.repositories[index],
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) =>
                                            di.get<RepositoryDetailsBloc>()
                                              ..add(
                                                LoadRepositoryDetailsEvent(
                                                  repository:
                                                      state.repositories[index],
                                                ),
                                              ),
                                        child: RepositoryDetailsPage(
                                            repository:
                                                state.repositories[index]),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : state is RepositoryListError
                              ? const Center(child: Text('An error occurred'))
                              : Container(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
