import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igstats/services/ig_api.dart';
import 'package:igstats/services/models.dart';
import 'package:video_player/video_player.dart';

class ProfileController extends GetxController {
  Rx<ProfileModel> profile = ProfileModel(
      username: "no user",
      fullName: "",
      bio: "",
      profilePicUrl:
          "https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg",
      websiteUrl: "",
      followerCount: 0,
      followingCount: 0,
      postCount: 0,
      imageList: [],
      videoList: []).obs;

  TextEditingController usernameController = TextEditingController();
  RxBool isException = false.obs;
  RxBool showProfile = true.obs;

  VideoPlayerController videoPlayerController =
      VideoPlayerController.network('');
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
    if (videoPlayerController.value.isInitialized &&
        chewieController.isPlaying) {
      chewieController.pause();
    }
    videosLoaded.value = List.filled(profile.value.videoList.length, false);
    videosLoaded.value[index] = true;
    update();
  }
}
