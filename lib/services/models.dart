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
