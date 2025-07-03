import 'package:snibbo_app/core/local_data_manager/profile/user_posts_helper.dart';
import 'package:snibbo_app/core/local_data_manager/profile/user_saved_posts_helper.dart';

class UserProfileCleanup {
  static void call({required String username}) {

    UserPostsHelper.posts.remove(username);
    UserPostsHelper.page.remove(username);
    UserPostsHelper.hasMore.remove(username);
    UserPostsHelper.isLoading.remove(username);

    UserSavedPostsHelper.posts.remove(username);
    UserSavedPostsHelper.page.remove(username);
    UserSavedPostsHelper.hasMore.remove(username);
    UserSavedPostsHelper.isLoading.remove(username);
  }
}
