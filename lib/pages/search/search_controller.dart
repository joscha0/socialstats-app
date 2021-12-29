import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igstats/services/ig_api.dart';
import 'package:igstats/services/models.dart';

class SearchController extends GetxController {
  Rx<SearchResultsModel> searchResults = SearchResultsModel(
    users: [
      SearchUserModel(
          username: 'test',
          fullName: 'test',
          profilePicUrl:
              'https://scontent-muc2-1.cdninstagram.com/v/t51.2885-19/s150x150/269758791_137719595310972_2372104152346344032_n.jpg?_nc_ht=scontent-muc2-1.cdninstagram.com&_nc_cat=100&_nc_ohc=F4lQOdcU0AEAX_2WH4D&edm=AHG7ALcBAAAA&ccb=7-4&oh=00_AT_jB4tRtxQb8DGllPHWK3Ruj4-f4etcqI2YIsrfgP-0sA&oe=61D31A41&_nc_sid=5cbaad'),
    ],
    places: [SearchPlaceModel(title: "title", subtitle: "subtitle", id: 123)],
    hashtags: [SearchHashtagModel(name: "name", subtitle: "subtitle", id: 123)],
  ).obs;

  RxBool isException = false.obs;

  TextEditingController searchController = TextEditingController();

  void search() async {
    isException.value = false;
    try {
      searchResults.value = await getSearchResult(searchController.text);
    } catch (e) {
      isException.value = true;
    }
  }
}
