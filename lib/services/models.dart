class SearchUserModel {
  late String username;
  late String fullName;
  late String profilePicUrl;

  SearchUserModel({
    required this.username,
    required this.fullName,
    required this.profilePicUrl,
  });
}

class SearchPlaceModel {
  late String title;
  late String subtitle;
  late int id;

  SearchPlaceModel({
    required this.title,
    required this.subtitle,
    required this.id,
  });
}

class SearchHashtagModel {
  late String name;
  late String subtitle;
  late int id;

  SearchHashtagModel({
    required this.name,
    required this.subtitle,
    required this.id,
  });
}

class SearchResultsModel {
  late List<SearchUserModel> users;
  late List<SearchPlaceModel> places;
  late List<SearchHashtagModel> hashtags;

  SearchResultsModel({
    required this.users,
    required this.places,
    required this.hashtags,
  });
}

class ProfileModel {
  late String username;
  late String fullName;
  late String bio;
  late String profilePicUrl;
  late String websiteUrl;
  late int followerCount;
  late int followingCount;
  late int postCount;
  late List<ImageModel> imageList;
  late List<VideoModel> videoList;

  ProfileModel({
    required this.username,
    required this.fullName,
    required this.bio,
    required this.profilePicUrl,
    required this.websiteUrl,
    required this.followerCount,
    required this.followingCount,
    required this.postCount,
    required this.imageList,
    required this.videoList,
  });
}

class MediaModel {
  late String mediaUrl;
  late String caption;
  late String datePosted;
  late int likeCount;
  late int commentCount;

  MediaModel({
    required this.mediaUrl,
    required this.caption,
    required this.datePosted,
    required this.likeCount,
    required this.commentCount,
  });
}

class ImageModel extends MediaModel {
  ImageModel({
    required mediaUrl,
    required caption,
    required datePosted,
    required likeCount,
    required commentCount,
  }) : super(
          mediaUrl: mediaUrl,
          caption: caption,
          datePosted: datePosted,
          likeCount: likeCount,
          commentCount: commentCount,
        );
}

class VideoModel extends MediaModel {
  late int views;

  VideoModel(
      {required mediaUrl,
      required caption,
      required datePosted,
      required likeCount,
      required commentCount,
      required this.views})
      : super(
          mediaUrl: mediaUrl,
          caption: caption,
          datePosted: datePosted,
          likeCount: likeCount,
          commentCount: commentCount,
        );
}
