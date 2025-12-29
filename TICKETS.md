# 📋 Development Tickets

## Before You Start

1. **Read the README.md** to understand the project structure
2. **Review the design files** in the `designs/` folder
3. **Run the base project** to see the current state
4. **Create your subtasks** - break down each ticket into smaller tasks (see examples below)

---

## 📋 Ticket 1: Implement Podcast Search

### Description
Users need to search for podcasts by keyword. Currently, the app shows only a hardcoded list.

### Acceptance Criteria

- [ ] User can type in the search TextField
- [ ] Search triggers API call after 500ms of no typing (debouncing)
- [ ] Results replace the hardcoded list
- [ ] Show `CircularProgressIndicator` while loading
- [ ] Show error message with retry option if request fails
- [ ] Show "No podcasts found" message when results are empty
- [ ] Each podcast displays: image, title, publisher, and description (max 2 lines)

### Technical Resources

- **API Endpoint**: `GET /search?q={query}`
- **Mock responses**: Already configured in `MockInterceptor`
- **Design**: See `designs/search_screen.md`

### Notes

- Don't implement pagination (limit to first 10 results)
- Use the `Debouncer` utility in `core/utils/`
- Use Riverpod's `StateNotifier` or `FutureProvider` for state management

### Example Subtasks

Here's how you might break this down (you can structure differently):

- [ ] Create `PodcastRepository` class with `searchPodcasts` method
- [ ] Create `PodcastRemoteDataSource` for API calls using `dioProvider`
- [ ] Create `SearchNotifier` extending `StateNotifier` with search states
- [ ] Create search state classes (Loading, Success, Error, Empty)
- [ ] Create `searchNotifierProvider` using `StateNotifierProvider`
- [ ] Update `HomeScreen` to use the search provider
- [ ] Make TextField functional and implement debouncing
- [ ] Add loading, error, and empty state widgets
- [ ] Handle `NetworkException` errors properly
- [ ] Add unit tests for `SearchNotifier`
- [ ] Add widget test for `PodcastCard`

### Architecture Example
```dart
// State classes
abstract class SearchState {}
class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchSuccess extends SearchState {
  final List<PodcastModel> podcasts;
  SearchSuccess(this.podcasts);
}
class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

// Notifier
class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier(this._repository) : super(SearchInitial());
  
  final PodcastRepository _repository;
  
  Future<void> search(String query) async {
    state = SearchLoading();
    try {
      final results = await _repository.searchPodcasts(query);
      state = SearchSuccess(results);
    } catch (e) {
      state = SearchError(e.toString());
    }
  }
}

// Provider
final searchNotifierProvider = 
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  final repository = ref.watch(podcastRepositoryProvider);
  return SearchNotifier(repository);
});
```

---

## 📋 Ticket 2: Add Podcast Detail Screen

### Description
When a user taps on a podcast, they should see detailed information and the latest episodes.

### Acceptance Criteria

- [ ] Tapping a podcast navigates to detail screen
- [ ] Screen shows: large image, title, publisher, full description, and genre
- [ ] Make API call to fetch the podcast with episodes
- [ ] Display the last 5 episodes showing: title, publish date, duration
- [ ] Include back button in AppBar that returns to search
- [ ] Show skeleton/shimmer loading while fetching details
- [ ] Show error state with retry button if request fails

### Technical Resources

- **API Endpoint**: `GET /podcasts/{id}`
- **Mock responses**: Already configured in `MockInterceptor`
- **Design**: See `designs/detail_screen.md`

### Notes

- Audio playback is NOT required
- Format dates nicely (e.g., "Dec 16, 2023")
- Format duration as "60 min" or "1h 30m"
- Use the `intl` package for date formatting

### Example Subtasks

Here's how you might break this down:

- [ ] Create `EpisodeModel` with `@JsonSerializable()`
- [ ] Create `PodcastDetailModel` with episodes list
- [ ] Run `build_runner` to generate `.g.dart` files
- [ ] Add `getPodcastById` method to repository
- [ ] Create `DetailNotifier` with detail states
- [ ] Create `detailNotifierProvider`
- [ ] Create `PodcastDetailScreen` widget
- [ ] Add route to `app_router.dart`
- [ ] Implement navigation from `HomeScreen` with podcast ID
- [ ] Create `EpisodeListTile` widget
- [ ] Add shimmer loading state using `shimmer` package
- [ ] Implement error state with retry button
- [ ] Add date formatter utility
- [ ] Add duration formatter utility
- [ ] Add tests for `DetailNotifier`

### Models Example
```dart
// Episode model
@JsonSerializable()
class EpisodeModel {
  final String id;
  final String title;
  final String? description;
  
  @JsonKey(name: 'pub_date_ms')
  final int publishDateMs;
  
  @JsonKey(name: 'audio_length_sec')
  final int audioLengthSec;
  
  const EpisodeModel({
    required this.id,
    required this.title,
    this.description,
    required this.publishDateMs,
    required this.audioLengthSec,
  });
  
  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);
}

// Detail model
@JsonSerializable()
class PodcastDetailModel {
  final String id;
  final String title;
  final String publisher;
  final String? image;
  final String? description;
  
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;
  
  final List<EpisodeModel> episodes;
  
  // ... constructors and methods
}
```

---

## 🎯 Tips for Success

### Breaking Down Tasks

Your subtasks should be **granular and actionable**. Good examples:

✅ "Create PodcastRepository with searchPodcasts method"  
✅ "Implement debounced search using Debouncer utility"  
✅ "Add error handling for network timeouts"

❌ "Do the search feature"  
❌ "Fix stuff"  
❌ "Make it work"

### Prioritization

If running short on time, prioritize:

1. **Core functionality** (search and detail work end-to-end)
2. **Error handling** (shows you think about edge cases)
3. **Loading states** (better UX)
4. **Tests** (at least a few key ones)
5. **Polish** (animations, perfect pixel matching)

### Git Commits

Make frequent, descriptive commits:

✅ "Add PodcastRepository with search method"  
✅ "Implement debounced search in HomeScreen"  
✅ "Add loading and error states to search"

❌ "Changes"  
❌ "WIP"  
❌ "Update code"

### Using AI

We encourage using AI tools! If you do, consider noting:
- What you used AI for
- What prompts worked well
- What you modified from AI suggestions

---

## 📤 When You're Done

1. Make sure all your changes are committed
2. Open a Pull Request with:
   - Summary of what you implemented
   - Checklist showing which acceptance criteria are complete
   - Any technical decisions or trade-offs
   - (Optional) Notes on AI assistance

3. If you didn't finish everything, explain:
   - What you prioritized and why
   - What you'd do differently with more time
   - What trade-offs you made

Remember: **It's okay not to finish everything!** We want to see your process, decision-making, and code quality more than 100% completion.

Good luck! 🚀