import 'package:flutter/material.dart';

import '../models/models.dart';
import 'restaurant_landscape_card.dart';

class RestaurantSection extends StatelessWidget {
  const RestaurantSection({super.key, required this.resturants});
  final List<Restaurant> resturants;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              bottom: 8.0,
            ),
            child: Text(
              'Food near me',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 230,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: resturants.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 300,
                  child: RestaurantLandscapeCard(restaurant: resturants[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
