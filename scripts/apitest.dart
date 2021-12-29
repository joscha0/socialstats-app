import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

void main() async {
  // print(await getProfileData('joscha0'));
  // print(await getSearchResult('test'));
  print(await getTopAccounts());
}

String baseUrl = 'https://www.instagram.com/';

Future<Map<String, dynamic>> getProfileData(String username) async {
  String appendix = '/?__a=1';
  Uri uri = Uri.parse(baseUrl + username + appendix);
  print(uri.toString());
  return await request(uri);
}

Future<Map<String, dynamic>> getSearchResult(String searchString) async {
  String appendix = 'web/search/topsearch/?context=blended&query=';
  Uri uri = Uri.parse(baseUrl + appendix + searchString);
  print(uri.toString());
  return await request(uri);
}

Future<Map<String, dynamic>> getTopAccounts() async {
  Random random = Random();
  String appendix =
      'directory/profiles/${random.nextInt(100)}-${random.nextInt(10)}/?__a=1';
  Uri uri = Uri.parse(baseUrl + appendix);
  print(uri.toString());
  return await request(uri);
}

Future<Map<String, dynamic>> request(Uri uri) async {
  Map<String, dynamic> data = {};
  final response = await http.get(uri);
  print(response.statusCode);
  if (response.statusCode == 200) {
    if (response.body.startsWith('<!DOCTYPE html>')) {
      print('Instagram request limit reached');
    } else {
      data = jsonDecode(utf8.decode(response.bodyBytes));
    }
  }
  return data;
}
