abstract class ILessonService {
  Future<bool?> updateLastWatch(int userId, List<String> lastWatchedVideos);
}
