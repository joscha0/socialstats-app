import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igstats/services/ig_api.dart';
import 'package:igstats/services/models.dart';

class SearchController extends GetxController {
  Rx<SearchResultsModel> searchResults = SearchResultsModel(
    users: [],
    places: [],
    hashtags: [],
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
