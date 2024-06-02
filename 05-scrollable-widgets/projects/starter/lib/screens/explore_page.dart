import 'package:flutter/material.dart';

import '../api/mock_yummy_service.dart';
import '../components/categroy_section.dart';
import '../components/post_section.dart';
import '../components/resturant_section.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});

  final MockYummyService mockYummyService = MockYummyService();
  @override
  Widget build(BuildContext context) {
    // TODO: Add listview Future Builder
    return FutureBuilder(
        future: mockYummyService.getExploreData(),
        builder: (context, AsyncSnapshot<ExploreData> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final resturants = snapshot.data?.restaurants ?? [];
            final categories = snapshot.data?.categories ?? [];
            final posts = snapshot.data?.friendPosts ?? [];

            return ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                RestaurantSection(resturants: resturants),
                CategorySection(categories: categories),
                PostSection(posts: posts),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('An Error has occu\'ed'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            );
          }
        });
  }
}
