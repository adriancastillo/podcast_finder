import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/podcast_model.dart';

class PodcastCard extends StatelessWidget {
  const PodcastCard({
    super.key,
    required this.podcast,
    this.onTap,
  });

  final PodcastModel podcast;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Podcast image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: podcast.imageUrl ?? '',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 80,
                    height: 80,
                    color: AppColors.surfaceVariant,
                    child: const Icon(
                      Icons.podcasts,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 80,
                    height: 80,
                    color: AppColors.surfaceVariant,
                    child: const Icon(
                      Icons.podcasts,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Podcast info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      podcast.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      podcast.publisher,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (podcast.description != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        podcast.description!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textTertiary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}