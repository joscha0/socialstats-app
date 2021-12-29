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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(300),
                          child: Image.network(c.profile.value.profilePicUrl),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(c.profile.value.username),
                            Row(
                              children: [
                                Text('${c.profile.value.postCount} posts'),
                                Text(
                                    '${c.profile.value.followerCount} followers'),
                                Text(
                                    '${c.profile.value.followingCount} following'),
                              ],
                            ),
                            Text(c.profile.value.fullName),
                            Text(c.profile.value.bio),
                            Text(c.profile.value.websiteUrl),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(32, 0, 32, 8),
                            child: TabBar(
                              tabs: const [
                                Tab(text: 'images'),
                                Tab(text: 'videos'),
                              ],
                              labelColor: Colors.black,
                              labelStyle:
                                  GoogleFonts.bangersTextTheme().subtitle1,
                              indicator: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(32)),
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${image.likeCount} likes'),
                            Text('${image.commentCount} comments'),
                          ],
                        ),
                        Text(image.datePosted),
                        Text(image.caption),
                      ],
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
                  Expanded(
                      child: FutureBuilder(
                          future: widget.c.loadVideo(video.mediaUrl),
                          builder: (BuildContext context,
                              AsyncSnapshot<ChewieController> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.error == null) {
                              return SizedBox(
                                height: 200,
                                child: Chewie(
                                  controller: snapshot.data ??
                                      ChewieController(
                                          videoPlayerController:
                                              VideoPlayerController.network(
                                                  '')),
                                ),
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          })),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${video.views} views'),
                            Text('${video.likeCount} likes'),
                            Text('${video.commentCount} comments'),
                          ],
                        ),
                        Text(video.datePosted),
                        Text(video.caption),
                      ],
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
