import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:podcast_finder/features/home/data/models/podcast_model.dart';
import 'package:podcast_finder/features/home/presentation/widgets/search/podcast_card.dart';

class PodcastList extends StatelessWidget {
  const PodcastList({required this.podcasts, super.key});

  final List<PodcastModel> podcasts;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: podcasts.length,
        itemBuilder: (context, index) {
          final podcast = podcasts[index];
          return PodcastCard(
            podcast: podcast,
            onTap: () => context.goNamed(
              'detail',
              pathParameters: {'id': podcast.id},
              extra: podcast,
            ),
          );
        },
      ),
    );
  }
}