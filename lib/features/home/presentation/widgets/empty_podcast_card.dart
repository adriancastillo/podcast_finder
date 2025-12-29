import 'package:flutter/material.dart';
import 'package:podcast_finder/core/theme/app_colors.dart';

class EmptyPodcastsCard extends StatelessWidget {
  const EmptyPodcastsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.podcasts, size: 56, color: AppColors.primaryLight),
          SizedBox(height: 12),
          Text(
            'No podcasts found',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
