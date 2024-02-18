import 'package:flutter/material.dart';
import 'package:github_viewer/domain/features/repository/export.dart';

class RepositoryListItem extends StatelessWidget {
  final Repository repository;
  final Function()? onTap;

  RepositoryListItem({required this.repository, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                repository.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Author: ${repository.owner.username}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 4),
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
            ],
          ),
        ),
      ),
    );
  }
}
