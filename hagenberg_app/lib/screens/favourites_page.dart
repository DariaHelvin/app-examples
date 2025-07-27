import 'package:flutter/material.dart';
import 'package:hagenberg_app/widgets/holiday_temperature_widget.dart';
import 'package:hagenberg_app/utils/app_colors.dart';
import 'package:hagenberg_app/widgets/custom_padding.dart';
import 'package:hagenberg_app/widgets/bottom_nav_favourites_page.dart';
import 'package:hagenberg_app/services/firebase_service.dart';

class FavouritesPage extends StatefulWidget {
  final List<Map<String, String>> favoriteActivities;
  final Function(String) removeFromFavorites;

  const FavouritesPage({
    super.key,
    required this.favoriteActivities,
    required this.removeFromFavorites,
  });

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  bool _isGridView = true;
  late FirebaseService _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = FirebaseService();
    _loadFavoriteActivities();
  }

  Future<void> _loadFavoriteActivities() async {
    List<Map<String, String>> favorites =
        await _firebaseService.getFavoriteActivities();
    setState(() {
      widget.favoriteActivities.clear();
      widget.favoriteActivities.addAll(favorites);
    });
  }

  void _removeFromFavorites(String activityName) async {
    await widget.removeFromFavorites(activityName);
    setState(() {
      widget.favoriteActivities
          .removeWhere((activity) => activity['name'] == activityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HolidayTemperatureWidget(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      _isGridView ? Icons.list : Icons.grid_view,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isGridView = !_isGridView;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: CustomPadding(
                child: widget.favoriteActivities.isEmpty
                    ? Center(
                        child: Text(
                          'No favorite activities yet!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : _isGridView
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 25.0,
                              mainAxisSpacing: 25.0,
                              childAspectRatio: 0.9,
                            ),
                            itemCount: widget.favoriteActivities.length,
                            itemBuilder: (context, index) {
                              final activity = widget.favoriteActivities[index];
                              final imageUrl = activity['image'] ?? '';

                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            color: Colors.black54,
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              activity['name'] ?? 'No name',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        _removeFromFavorites(
                                            activity['name'] ?? '');
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: widget.favoriteActivities.length,
                            itemBuilder: (context, index) {
                              final activity = widget.favoriteActivities[index];
                              final imageUrl = activity['image'] ?? '';

                              return ListTile(
                                leading: Image.network(imageUrl),
                                title: Text(
                                  activity['name'] ?? 'No name',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    _removeFromFavorites(
                                        activity['name'] ?? '');
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 24,
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ),
            BottomNavFavouritesPage(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
