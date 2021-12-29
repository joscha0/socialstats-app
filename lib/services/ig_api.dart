import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:igstats/services/models.dart';
import 'package:intl/intl.dart';

String baseUrl = 'https://www.instagram.com/';

Future<ProfileModel> getProfileData(String username) async {
  String appendix = '/?__a=1';
  Uri uri = Uri.parse(baseUrl + username + appendix);
  // print(uri.toString());
  Map<String, dynamic> data = (await request(uri))['graphql']['user'];
  ProfileModel returnData = ProfileModel(
    username: data['username'],
    fullName: data['full_name'],
    bio: data['biography'],
    profilePicUrl: data['profile_pic_url'],
    websiteUrl: data['external_url'],
    followerCount: data['edge_followed_by']['count'],
    followingCount: data['edge_follow']['count'],
    postCount: data['edge_owner_to_timeline_media']['count'],
    imageList: [],
    videoList: [],
  );

  for (Map<String, dynamic> media in data['edge_owner_to_timeline_media']
      ['edges']) {
    if (media['node']['is_video']) {
      returnData.videoList.add(VideoModel(
        mediaUrl: media['node']['video_url'],
        caption: media['node']['edge_media_to_caption']['edges'][0]['node']
            ['text'],
        datePosted: DateFormat('dd/MM/yyyy, HH:mm').format(
            DateTime.fromMillisecondsSinceEpoch(
                media['node']['taken_at_timestamp'] * 1000)),
        likeCount: media['node']['edge_liked_by']['count'],
        commentCount: media['node']['edge_media_to_comment']['count'],
        views: media['node']['video_view_count'],
        previewImgUrl: media['node']['thumbnail_src'],
      ));
    } else {
      returnData.imageList.add(ImageModel(
        mediaUrl: media['node']['display_url'],
        caption: media['node']['edge_media_to_caption']['edges'][0]['node']
            ['text'],
        datePosted: DateTime.fromMillisecondsSinceEpoch(
                media['node']['taken_at_timestamp'] * 1000)
            .toIso8601String(),
        likeCount: media['node']['edge_liked_by']['count'],
        commentCount: media['node']['edge_media_to_comment']['count'],
      ));
    }
  }

  return returnData;
}

Future<SearchResultsModel> getSearchResult(String searchString) async {
  String appendix = 'web/search/topsearch/?context=blended&query=';
  Uri uri = Uri.parse(baseUrl + appendix + searchString);
  // print(uri.toString());

  Map<String, dynamic> data = await request(uri);

  SearchResultsModel returnData = SearchResultsModel(
    users: [],
    places: [],
    hashtags: [],
  );

  for (Map<String, dynamic> user in data['users']) {
    returnData.users.add(SearchUserModel(
      username: user['user']['username'],
      fullName: user['user']['full_name'],
      profilePicUrl: user['user']['profile_pic_url'],
    ));
  }

  for (Map<String, dynamic> place in data['places']) {
    returnData.places.add(SearchPlaceModel(
      title: place['place']['title'],
      subtitle: place['place']['subtitle'],
      id: place['place']['location']['facebook_places_id'],
    ));
  }

  for (Map<String, dynamic> hashtag in data['hashtags']) {
    returnData.hashtags.add(SearchHashtagModel(
      name: hashtag['hashtag']['name'],
      subtitle: hashtag['hashtag']['search_result_subtitle'],
      id: hashtag['hashtag']['id'],
    ));
  }
  return returnData;
}

Future<Map<String, dynamic>> getTopAccounts() async {
  math.Random random = math.Random();
  String appendix =
      'directory/profiles/${random.nextInt(100)}-${random.nextInt(10)}/?__a=1';
  Uri uri = Uri.parse(baseUrl + appendix);
  // print(uri.toString());
  return await request(uri);
}

Future<Map<String, dynamic>> request(Uri uri) async {
  Map<String, dynamic> data = {};
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    if (response.body.startsWith('<!DOCTYPE html>')) {
      log('Instagram request limit reached');
      throw Exception('Instagram request limit reached');
    } else {
      data = jsonDecode(utf8.decode(response.bodyBytes));
    }
  }
  return data;
}
