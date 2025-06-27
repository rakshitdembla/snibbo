import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';

class UserSavedPostsHelper {
  static Map<String,List<PostEntity>> posts = {};
  static Map<String,int> page = {};
  static Map<String,bool> isLoading = {};
  static Map<String,bool> hasMore = {};
}