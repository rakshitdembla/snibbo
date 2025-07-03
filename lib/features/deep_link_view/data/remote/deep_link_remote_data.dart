import 'package:snibbo_app/core/constants/api_constants.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/network/base_api/api_services.dart';
import 'package:snibbo_app/features/feed/data/models/post_model.dart';
import 'package:snibbo_app/features/feed/domain/entities/post_entity.dart';
import 'package:snibbo_app/service_locator.dart';

class DeepLinkRemoteData {
  Future<(bool success, PostEntity? postEntity, String? message)>
  getSinglePostById({required String tokenId, required String postId}) async {
    try {
      final response = await sl<ApiService>().get(
        path: "${ApiRoutes.getSinglePost}/$postId",
        headers: {MyStrings.userIdHeader: tokenId},
      );

      if (response != null) {
        final responseData = await response.data;

        if (response.statusCode == 200) {
          final postJson = responseData["post"];
          final postEntity = PostModel.fromJson(postJson).toEntity();
          return (true, postEntity, "Post fetched successfully.");
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
