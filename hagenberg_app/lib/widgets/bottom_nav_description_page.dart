import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hagenberg_app/screens/favourites_page.dart';
import 'package:hagenberg_app/screens/activities_description_page.dart';

class BottomNavDescriptionPage extends StatelessWidget {
  final List<Map<String, String>> favoriteActivities;
  final Function(Map<String, String>) addToFavorites;
  final Function(String) removeFromFavorites;
  final Map<String, String> currentActivity;

  const BottomNavDescriptionPage({
    Key? key,
    required this.favoriteActivities,
    required this.addToFavorites,
    required this.removeFromFavorites,
    required this.currentActivity,
  }) : super(key: key);

  bool _isFavorite(String activityName) {
    return favoriteActivities
        .any((activity) => activity['name'] == activityName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Horizontal line
        Container(
          height: 1.0,
          color: Colors.grey,
        ),
        // Icons and Texts
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 46,
                      height: 46,
                      child: IconButton(
                        icon: _isFavorite(currentActivity['name'] ?? '')
                            ? Image.asset(
                                'assets/icons/heart_favourites_icon.png')
                            : Image.asset(
                                'assets/icons/heart_empty_borders_icon.png'),
                        onPressed: () {
                          if (_isFavorite(currentActivity['name'] ?? '')) {
                            removeFromFavorites(currentActivity['name'] ?? '');
                          } else {
                            addToFavorites(currentActivity);
                          }
                        },
                      ),
                    ),
                  ),
                  Text(
                    'Keep for the future',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 45,
                      height: 45,
                      child: IconButton(
                        icon: SvgPicture.asset('assets/icons/castle_icon.svg'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Text(
                    'Back to selection',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 45,
                      height: 45,
                      child: IconButton(
                        icon: Image.asset('assets/icons/list_icon.png'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavouritesPage(
                                favoriteActivities: favoriteActivities,
                                removeFromFavorites: removeFromFavorites,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Text(
                    'My favourites',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
