import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igstats/services/models.dart';

import 'search_controller.dart';

class SearchPage extends GetView<SearchController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<SearchController>(
        init: SearchController(),
        builder: (c) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
            ),
            body: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'IG stats',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 48,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: c.searchController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                            ),
                            labelText: 'Search',
                            contentPadding: EdgeInsets.fromLTRB(24, 16, 16, 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: c.search,
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                          child: Icon(Icons.search),
                        ),
                      )
                    ],
                  ),
                ),
                if (!c.isException.value) ...[
                  Expanded(
                    child: DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 0, 32, 8),
                              child: TabBar(
                                tabs: const [
                                  Tab(text: 'users'),
                                  Tab(text: 'places'),
                                  Tab(text: 'hashtags'),
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
                                ListView.builder(
                                  itemCount: c.searchResults.value.users.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    SearchUserModel user =
                                        c.searchResults.value.users[index];
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          24, 4, 24, 4),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32)),
                                        child: ListTile(
                                          title: Text(user.username),
                                          subtitle: Text(user.fullName),
                                          leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.network(
                                                  user.profilePicUrl)),
                                          onTap: () {},
                                          contentPadding:
                                              const EdgeInsets.only(left: 24),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32)),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                ListView.builder(
                                  itemCount:
                                      c.searchResults.value.places.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    SearchPlaceModel place =
                                        c.searchResults.value.places[index];
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          24, 4, 24, 4),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32)),
                                        child: ListTile(
                                          title: Text(place.title),
                                          subtitle: Text(place.subtitle),
                                          leading: const Icon(
                                            Icons.place,
                                            size: 35,
                                            color: Colors.black,
                                          ),
                                          onTap: () {},
                                          contentPadding:
                                              const EdgeInsets.only(left: 24),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32)),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                ListView.builder(
                                  itemCount:
                                      c.searchResults.value.hashtags.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    SearchHashtagModel hashtag =
                                        c.searchResults.value.hashtags[index];
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          24, 4, 24, 4),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32)),
                                        child: ListTile(
                                          title: Text(hashtag.name),
                                          subtitle: Text(hashtag.subtitle),
                                          leading: const Text(
                                            '#',
                                            style: TextStyle(fontSize: 35),
                                          ),
                                          onTap: () {},
                                          contentPadding:
                                              const EdgeInsets.only(left: 24),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32)),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ]),
                            )
                          ],
                        )),
                  )
                ] else ...[
                  const Center(
                    child: Text('Instagram request limit reached'),
                  )
                ]
              ],
            ),
          );
        });
  }
}
