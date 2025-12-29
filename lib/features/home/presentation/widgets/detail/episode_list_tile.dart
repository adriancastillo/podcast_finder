import 'package:flutter/material.dart';
import 'package:podcast_finder/core/theme/app_colors.dart';
import 'package:podcast_finder/core/utils/format_date.dart';
import 'package:podcast_finder/core/utils/shimmer.dart';
import 'package:podcast_finder/features/home/data/models/episode_model.dart';

class EpisodeListTile extends StatelessWidget {
  const EpisodeListTile({required this.episode, super.key});

  final EpisodeModel episode;

  @override
  Widget build(BuildContext context) {
    final date = formatDate(
      DateTime.fromMillisecondsSinceEpoch(episode.publishDateMs),
    );
    final duration = formatDuration(episode.audioLengthSec);
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Playback not implemented')),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              episode.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '$date • $duration',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EpisodeListTileShimmer extends StatelessWidget {
  const EpisodeListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Episode title').skeletonMask(),
          const SizedBox(height: 6),
          const Text('date ** ** • duration ** **').skeletonMask(),
        ],
      ),
    );
  }
}
