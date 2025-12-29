import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_finder/core/theme/app_colors.dart';
import 'package:podcast_finder/features/home/data/models/podcast_detail_model.dart';
import 'package:podcast_finder/features/home/data/models/podcast_model.dart';
import 'package:podcast_finder/features/home/presentation/providers/detail/podcast_detail_provider.dart';
import 'package:podcast_finder/features/home/presentation/providers/detail/podcasts_detail_state.dart';
import 'package:podcast_finder/features/home/presentation/widgets/detail/episode_list_tile.dart';
import 'package:podcast_finder/features/home/presentation/widgets/error_card.dart';

class PodcastDetailScreen extends ConsumerWidget {
  const PodcastDetailScreen({required this.podcast, super.key});

  final PodcastModel podcast;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          podcast.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        children: [
          /// Hero Image
          SizedBox(
            height: 300,
            width: double.infinity,
            child: podcast.imageUrl == null
                ? Container(color: Colors.grey.shade300)
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(podcast.imageUrl!, fit: BoxFit.cover),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black54,
                              Colors.transparent,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),

          /// Content
          /// Title
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              podcast.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          /// Publisher
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              podcast.publisher,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ),

          /// Description
          if (podcast.description != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                podcast.description!,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

          PodcastDetailExtra(podcastId: podcast.id),
        ],
      ),
    );
  }
}

class PodcastDetailExtra extends ConsumerStatefulWidget {
  const PodcastDetailExtra({required this.podcastId, super.key});

  final String podcastId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PodcastDetailExtraState();
}

class _PodcastDetailExtraState extends ConsumerState<PodcastDetailExtra> {
  @override
  void initState() {
    ref
        .read(podcastDetailNotifierProvider(widget.podcastId).notifier)
        .getPodcastById(widget.podcastId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final detailPodcastState = ref.watch(
      podcastDetailNotifierProvider(widget.podcastId),
    );
    return switch (detailPodcastState) {
      PodcastDetailLoading() => Column(
        children: List.generate(5, (index) => const EpisodeListTileShimmer()),
      ),
      PodcastDetailSuccess(:final podcastDetail) => PoscastDetailExtraContent(
        podcastDetail: podcastDetail,
      ),
      PodcastDetailError(:final message) => ErrorCard(
        message: message,
        onRetry: () => ref
            .read(podcastDetailNotifierProvider(widget.podcastId).notifier)
            .getPodcastById(widget.podcastId),
      ),
    };
  }
}

class PoscastDetailExtraContent extends StatelessWidget {
  const PoscastDetailExtraContent({required this.podcastDetail, super.key});

  final PodcastDetailModel podcastDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Genres
        if (podcastDetail.genreIds != null &&
            podcastDetail.genreIds!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              children: podcastDetail.genreLabels!.map((genre) {
                return Chip(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  labelPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  label: Text(
                    genre,
                    style: const TextStyle(color: AppColors.primary),
                  ),
                  backgroundColor: AppColors.surfaceVariant,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                );
              }).toList(),
            ),
          ),
        const SizedBox(height: 16),

        /// Episodes Header
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Recent Episodes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 8),

        /// Episodes List
        ...podcastDetail.lastFiveEpisodes.map(
          (episode) => EpisodeListTile(episode: episode),
        ),
      ],
    );
  }
}
