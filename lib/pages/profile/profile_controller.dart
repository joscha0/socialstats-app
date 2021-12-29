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
      followerCount: 12323,
      followingCount: 122353,
      postCount: 12233,
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
            previewImgUrl:
                'https://scontent-muc2-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/c0.280.720.720a/s640x640/269858105_107707791699719_3804842516887114861_n.jpg?_nc_ht=scontent-muc2-1.cdninstagram.com&_nc_cat=111&_nc_ohc=LB-Hka5-UEkAX_yhW_x&edm=ABfd0MgBAAAA&ccb=7-4&oh=00_AT_i7gjYAZmULCjMTBLE3WY2TQJQ7LQe_h6aOw-fqSskUA&oe=61CE9120&_nc_sid=7bff83'),
        VideoModel(
            mediaUrl:
                "https://scontent.cdninstagram.com/v/t50.2886-16/269963940_167078088960882_2382964492111403783_n.mp4?_nc_ht=scontent-muc2-1.cdninstagram.com&_nc_cat=106&_nc_ohc=_qyZl6-5jsMAX_sOhXF&tn=XqfqS9R8NKUacHO8&edm=ABfd0MgBAAAA&ccb=7-4&oe=61CE9E0A&oh=00_AT_4UL9hEdLq29tlX_UWJavu8rbS3_dlS9srw9KucFAB5w&_nc_sid=7bff83",
            caption: "caption",
            datePosted: "datePosted",
            likeCount: 123,
            commentCount: 123,
            views: 123,
            previewImgUrl:
                'https://scontent-muc2-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/c0.280.720.720a/s640x640/269858105_107707791699719_3804842516887114861_n.jpg?_nc_ht=scontent-muc2-1.cdninstagram.com&_nc_cat=111&_nc_ohc=LB-Hka5-UEkAX_yhW_x&edm=ABfd0MgBAAAA&ccb=7-4&oh=00_AT_i7gjYAZmULCjMTBLE3WY2TQJQ7LQe_h6aOw-fqSskUA&oe=61CE9120&_nc_sid=7bff83'),
      ]).obs;

  TextEditingController usernameController = TextEditingController();
  RxBool isException = false.obs;

  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  Rx<List<bool>> videosLoaded = Rx<List<bool>>([false, false]);

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.onClose();
  }

  void openProfile() async {
    isException.value = false;
    try {
      profile.value = await getProfileData(usernameController.text);
      videosLoaded.value = List.filled(profile.value.videoList.length, false);
    } catch (e) {
      isException.value = true;
    }
  }

  Future<ChewieController> loadVideo(String url) async {
    videoPlayerController = VideoPlayerController.network(url);
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: true,
      allowMuting: true,
    );

    return chewieController;
  }

  void loadVideoIndex(int index) {
    videosLoaded.value = List.filled(profile.value.videoList.length, false);
    videosLoaded.value[index] = true;
    update();
  }
}
