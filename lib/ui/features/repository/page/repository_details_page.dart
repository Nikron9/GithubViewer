import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_viewer/domain/features/repository/export.dart';
import 'package:github_viewer/presentation/features/repository_details/export.dart';
import 'package:github_viewer/ui/features/repository/export.dart';

class RepositoryDetailsPage extends StatelessWidget {
  final Repository repository;

  const RepositoryDetailsPage({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repository details'),
        elevation: 4,
      ),
      body: BlocBuilder<RepositoryDetailsBloc, RepositoryDetailsState>(
        builder: (context, state) {
          if (state is RepositoryDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RepositoryDetailsLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    repository.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Author: ${repository.owner.username}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${repository.stargazersCount}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.call_split, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${repository.forksCount}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  state.openIssues.isNotEmpty
                      ? Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              const Divider(),
                              const SizedBox(height: 8),
                              const Text(
                                'Open Issues:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: state.openIssues.length,
                                  itemBuilder: (context, index) {
                                    final issue = state.openIssues[index];
                                    return RepositoryDetailsListItem(
                                      data: RepositoryDetailsListItemData(
                                        title: issue.title,
                                        owner: issue.reporter.username,
                                        state: issue.state,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                  state.pullRequests.isNotEmpty
                      ? Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              const Divider(),
                              const SizedBox(height: 8),
                              const Text(
                                'Pull Requests:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: state.pullRequests.length,
                                  itemBuilder: (context, index) {
                                    final pullRequest =
                                        state.pullRequests[index];
                                    return RepositoryDetailsListItem(
                                      data: RepositoryDetailsListItemData(
                                        title: pullRequest.title,
                                        owner: pullRequest.creator.username,
                                        state: pullRequest.state,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          } else if (state is RepositoryDetailsError) {
            return const Center(child: Text('An error occurred'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
