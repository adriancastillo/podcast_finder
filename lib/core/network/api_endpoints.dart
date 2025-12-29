class ApiEndpoints {
  static const String baseUrl = 'https://listen-api.listennotes.com/api/v2';
  
  // Search
  static const String search = '/search';
  
  // Podcast detail
  static String podcastDetail(String id) => '/podcasts/$id';
  
  // Mock API key for the interceptor
  static const String mockApiKey = 'mock_api_key_12345';
}