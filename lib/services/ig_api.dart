import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:igstats/services/models.dart';

String baseUrl = 'https://www.instagram.com/';

Future<Map<String, dynamic>> getProfileData(String username) async {
  String appendix = '/?__a=1';
  Uri uri = Uri.parse(baseUrl + username + appendix);
  // print(uri.toString());
  return await request(uri);
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
      id: place['place']['location']['facebook_place_id'],
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
    } else {
      data = jsonDecode(utf8.decode(response.bodyBytes));
    }
  }
  return data;
}
