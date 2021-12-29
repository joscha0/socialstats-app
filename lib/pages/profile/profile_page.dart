import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igstats/services/models.dart';
import 'package:video_player/video_player.dart';

import 'profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ProfileController>(
        init: ProfileController(),
        builder: (c) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: c.usernameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                            ),
                            labelText: 'username',
                            contentPadding: EdgeInsets.fromLTRB(24, 16, 16, 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: c.openProfile,
                        child: const Icon(
                          Icons.arrow_right,
                          size: 48,
                        ),
                      )
                    ],
                  ),
                ),
                if (!c.isException.value) ...[
                  if (c.showProfile.value) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(300),
                              child:
                                  Image.network(c.profile.value.profilePicUrl),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  c.profile.value.username,
                                  style: const TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '${c.profile.value.postCount}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const Text('posts'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '${c.profile.value.followerCount}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const Text('followers'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '${c.profile.value.followingCount}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const Text('following'),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    c.profile.value.fullName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(c.profile.value.bio),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    c.profile.value.websiteUrl,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                  Expanded(
                    child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 0, 32, 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TabBar(
                                      tabs: const [
                                        Tab(text: 'images'),
                                        Tab(text: 'videos'),
                                      ],
                                      labelColor: Colors.black,
                                      labelStyle: GoogleFonts.bangersTextTheme()
                                          .subtitle1,
                                      indicator: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(32)),
                                    ),
                                  ),
                                  ExpandIcon(
                                    onPressed: (value) {
                                      c.showProfile.value =
                                          !c.showProfile.value;
                                    },
                                    isExpanded: c.showProfile.value,
                                    size: 32,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(children: [
                                ImagesTab(c: c),
                                VideosTab(c: c),
                              ]),
                            )
                          ],
                        )),
                  )
                ] else ...[
                  const Center(
                    child: Text('Instagram request limit reached'),
                  )
                ],
              ],
            ),
          );
        });
  }
}

class ImagesTab extends StatefulWidget {
  final ProfileController c;
  const ImagesTab({
    Key? key,
    required this.c,
  }) : super(key: key);

  @override
  State<ImagesTab> createState() => _ImagesTabState();
}

class _ImagesTabState extends State<ImagesTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.c.profile.value.imageList.length,
      itemBuilder: (BuildContext context, int index) {
        ImageModel image = widget.c.profile.value.imageList[index];
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Row(
                children: [
                  Expanded(child: Image.network(image.mediaUrl)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '${image.likeCount}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const Text('likes'),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${image.commentCount}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const Text('comments'),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              image.datePosted,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(image.caption),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class VideosTab extends StatefulWidget {
  final ProfileController c;
  const VideosTab({
    Key? key,
    required this.c,
  }) : super(key: key);

  @override
  State<VideosTab> createState() => _VideosTabState();
}

class _VideosTabState extends State<VideosTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.c.profile.value.videoList.length,
      itemBuilder: (BuildContext context, int index) {
        VideoModel video = widget.c.profile.value.videoList[index];

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Row(
                children: [
                  Expanded(child: MyVideoPlayer(video: video, index: index)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '${video.views}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const Text('views'),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${video.likeCount}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const Text('likes'),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${video.commentCount}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const Text('comments'),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              video.datePosted,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(video.caption),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MyVideoPlayer extends GetWidget {
  const MyVideoPlayer({
    Key? key,
    required this.video,
    required this.index,
  }) : super(key: key);

  final VideoModel video;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetX<ProfileController>(
        init: ProfileController(),
        builder: (c) {
          if (c.videosLoaded.value[index]) {
            return FutureBuilder(
                future: c.loadVideo(video.mediaUrl),
                builder: (BuildContext context,
                    AsyncSnapshot<ChewieController> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.error == null) {
                    return SizedBox(
                      height: 200,
                      child: Chewie(
                        controller: snapshot.data ??
                            ChewieController(
                                videoPlayerController:
                                    VideoPlayerController.network('')),
                      ),
                    );
                  } else {
                    return const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()));
                  }
                });
          } else {
            return SizedBox(
              height: 200,
              child: IconButton(
                  onPressed: () {
                    c.loadVideoIndex(index);
                  },
                  icon: Image.network(video.previewImgUrl)),
            );
          }
        });
  }
}
