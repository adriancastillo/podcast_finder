import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:podcast_finder/features/home/presentation/widgets/search/podcast_card.dart';

import '../../../../builders/podcast_model_builder.dart';

void main() {
  Widget buildTestable(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }

  group('PodcastCard', () {
    testWidgets(
      'Should display podcast information and trigger onTap when card is tapped',
      (WidgetTester tester) async {
        // Arrange
        bool tapped = false;

        final podcast = PodcastModelBuilder()
            .withTitle('Tech Talk Daily')
            .withPublisher('Tech Media Inc')
            .withDescription(
              'Your daily dose of technology news and insights. We cover everything from startups to AI.',
            )
            .build();

        // Act
        await tester.pumpWidget(
          buildTestable(
            PodcastCard(podcast: podcast, onTap: () => tapped = true),
          ),
        );

        await tester.pumpAndSettle();

        await tester.tap(find.byType(InkWell));
        await tester.pump();

        // Assert
        expect(find.text('Tech Talk Daily'), findsOneWidget);
        expect(find.text('Tech Media Inc'), findsOneWidget);
        expect(
          find.text(
            'Your daily dose of technology news and insights. We cover everything from startups to AI.',
          ),
          findsOneWidget,
        );
        expect(find.byIcon(Icons.chevron_right), findsOneWidget);
        expect(tapped, isTrue);
      },
    );

    testWidgets(
      'Should not display description when podcast description is null',
      (WidgetTester tester) async {
        // Arrange
        final podcast = PodcastModelBuilder()
            .withTitle('Tech Talk Daily')
            .withPublisher('Tech Media Inc')
            .withDescription(null)
            .build();

        // Act
        await tester.pumpWidget(buildTestable(PodcastCard(podcast: podcast)));

        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Tech Talk Daily'), findsOneWidget);
        expect(find.text('Tech Media Inc'), findsOneWidget);

        // Only title and publisher should be rendered
        expect(find.byType(Text), findsNWidgets(2));
      },
    );

    testWidgets(
      'Should display fallback icon when podcast image fails to load',
      (WidgetTester tester) async {
        // Arrange
        final podcast = PodcastModelBuilder().build();

        // Act
        await tester.pumpWidget(buildTestable(PodcastCard(podcast: podcast)));

        await tester.pumpAndSettle();

        // Assert
        expect(find.byIcon(Icons.podcasts), findsOneWidget);
      },
    );

    testWidgets('Should not throw when onTap callback is null', (
      WidgetTester tester,
    ) async {
      // Arrange
      final podcast = PodcastModelBuilder()
          .withTitle('Tech Talk Daily')
          .build();

      // Act
      await tester.pumpWidget(buildTestable(PodcastCard(podcast: podcast)));

      await tester.pumpAndSettle();

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      // Assert
      expect(find.text('Tech Talk Daily'), findsOneWidget);
    });

    testWidgets('Should render long texts without layout overflow', (
      WidgetTester tester,
    ) async {
      // Arrange
      final podcast = PodcastModelBuilder()
          .withTitle(
            'This is a very very very very very very long podcast title that should be truncated',
          )
          .withPublisher('Tech Media Inc')
          .build();

      // Act
      await tester.pumpWidget(buildTestable(PodcastCard(podcast: podcast)));

      await tester.pumpAndSettle();

      // Assert
      expect(find.textContaining('This is a very very'), findsOneWidget);
      expect(find.textContaining('Tech Media Inc'), findsOneWidget);
    });
  });
}
