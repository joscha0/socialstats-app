import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igstats/services/ig_api.dart';
import 'package:igstats/services/models.dart';
import 'package:video_player/video_player.dart';

class ProfileController extends GetxController {
  Rx<ProfileModel> profile = ProfileModel(
      username: "username",
      fullName: "fullName",
      bio: "bio",
      profilePicUrl:
          "https://scontent-muc2-1.cdninstagram.com/v/t51.2885-19/s150x150/103280599_561183587922801_1306027535501666726_n.jpg?_nc_ht=scontent-muc2-1.cdninstagram.com&_nc_cat=1&_nc_ohc=PI2lGGBbNyEAX-AkKEo&tn=XqfqS9R8NKUacHO8&edm=ABfd0MgBAAAA&ccb=7-4&oh=00_AT9OHzUhp0iZLk20czhlhJ6HBBbuoaeTtwKRSjnsPrAUmg&oe=61D292A7&_nc_sid=7bff83",
      websiteUrl: "websiteUrl",
      followerCount: 123,
      followingCount: 123,
      postCount: 123,
      imageList: [
        ImageModel(
            mediaUrl:
                "https://scontent-muc2-1.cdninstagram.com/v/t51.2885-15/e35/s1080x1080/269929586_1057406471761748_7922553736794719620_n.jpg?_nc_ht=scontent-muc2-1.cdninstagram.com&_nc_cat=108&_nc_ohc=ZsLZB99rf7IAX8MxD8d&edm=ABfd0MgBAAAA&ccb=7-4&oh=00_AT8-rWmq_Ah5iGxgbbiV_r8sPTjXTlcFwcjrbVPd-ZbgcA&oe=61D410B0&_nc_sid=7bff83",
            caption: "caption",
            datePosted: "datePosted",
            likeCount: 123,
            commentCount: 123)
      ],
      videoList: [
        VideoModel(
          mediaUrl:
              "https://scontent.cdninstagram.com/v/t50.2886-16/269963940_167078088960882_2382964492111403783_n.mp4?_nc_ht=scontent-muc2-1.cdninstagram.com&_nc_cat=106&_nc_ohc=_qyZl6-5jsMAX_sOhXF&tn=XqfqS9R8NKUacHO8&edm=ABfd0MgBAAAA&ccb=7-4&oe=61CE9E0A&oh=00_AT_4UL9hEdLq29tlX_UWJavu8rbS3_dlS9srw9KucFAB5w&_nc_sid=7bff83",
          caption: "caption",
          datePosted: "datePosted",
          likeCount: 123,
          commentCount: 123,
          views: 123,
        ),
        VideoModel(
          mediaUrl:
              "https://scontent.cdninstagram.com/v/t50.2886-16/269963940_167078088960882_2382964492111403783_n.mp4?_nc_ht=scontent-muc2-1.cdninstagram.com&_nc_cat=106&_nc_ohc=_qyZl6-5jsMAX_sOhXF&tn=XqfqS9R8NKUacHO8&edm=ABfd0MgBAAAA&ccb=7-4&oe=61CE9E0A&oh=00_AT_4UL9hEdLq29tlX_UWJavu8rbS3_dlS9srw9KucFAB5w&_nc_sid=7bff83",
          caption: "caption",
          datePosted: "datePosted",
          likeCount: 123,
          commentCount: 123,
          views: 123,
        )
      ]).obs;

  TextEditingController usernameController = TextEditingController();
  RxBool isException = false.obs;

  List<VideoPlayerController> _videoControllers = [];
  List<ChewieController> _chewieControllers = [];

  @override
  void onClose() {
    closeVideoControllers();
    super.onClose();
  }

  void closeVideoControllers() {
    for (VideoPlayerController vc in _videoControllers) {
      vc.dispose();
    }
    for (ChewieController cc in _chewieControllers) {
      cc.dispose();
    }
  }

  void openProfile() async {
    closeVideoControllers();
    isException.value = false;
    try {
      profile.value = await getProfileData(usernameController.text);
    } catch (e) {
      isException.value = true;
    }
  }

  Future<ChewieController> loadVideo(String url) async {
    final VideoPlayerController videoPlayerController =
        VideoPlayerController.network(url);
    await videoPlayerController.initialize();

    final ChewieController chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: true,
    );

    _videoControllers.add(videoPlayerController);
    _chewieControllers.add(chewieController);

    return chewieController;
  }
}
