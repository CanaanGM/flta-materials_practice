import 'package:flutter/material.dart';
import 'package:yummy/models/models.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.apply(
          displayColor: Theme.of(context).colorScheme.onSurface,
        );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(post.profileImageUrl),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.comment,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium,
                ),
                Text(
                  '${post.timestamp} mins ago',
                  style: textTheme.bodySmall,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
