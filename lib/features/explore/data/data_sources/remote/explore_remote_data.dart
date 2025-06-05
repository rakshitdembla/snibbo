import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/features/feed/data/models/post_model.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/service_locator.dart';

class ExploreRemoteData {
  Future<(bool success, List<PostEntity>? postEntity, String? message)>
  getExplorePosts(String userId, int page, int limit) async {
    try {
      final response = await sl<ApiService>().get(
        path: ApiRoutes.allPosts,
        headers: {MyStrings.userIdHeader: userId},
        queryParameters: {
          MyStrings.pageParam: page,
          MyStrings.limitParam: limit,
        },
      );

      if (response != null) {
        final responseData = await response.data;
        if (response.statusCode == 200) {
          final postsJson = responseData["posts"] as List;
          final postEntities =
              postsJson.map((x) => PostModel.fromJson(x).toEntity()).toList();
          return (true, postEntities, "Feed fetched successfully.");
        } else {
          return (false, null, responseData["message"].toString());
        }
      } else {
        return (
          false,
          null,
          "No response from server. Please try again later.",
        );
      }
    } catch (e) {
      return (false, null, "Unexpected error occurred: ${e.toString()}");
    }
  }
}
