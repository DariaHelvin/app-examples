import 'package:flutter/material.dart';
import 'package:hagenberg_app/utils/app_colors.dart';
import 'package:hagenberg_app/widgets/custom_padding.dart';
import 'package:hagenberg_app/widgets/holiday_temperature_widget.dart';
import 'package:hagenberg_app/widgets/bottom_nav_today_activities_page.dart';
import 'package:hagenberg_app/widgets/image_slider.dart';
import 'package:hagenberg_app/widgets/text_block_today_activities.dart';
import 'package:hagenberg_app/services/firebase_service.dart';

class TodayActivitiesPage extends StatefulWidget {
  const TodayActivitiesPage({super.key});

  @override
  State<TodayActivitiesPage> createState() => _TodayActivitiesPageState();
}

class _TodayActivitiesPageState extends State<TodayActivitiesPage> {
  final PageController _pageController = PageController();
  List<Map<String, String>> _favoriteActivities = [];
  int _currentPage = 0;
  late Future<List<Map<String, String>>> loadingFuture;
  late FirebaseService _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = FirebaseService();
    loadingFuture = _loadActivities();
    _loadFavoriteActivities();
  }

  Future<List<Map<String, String>>> _loadActivities() async {
    List<Map<String, String>> activities = await _firebaseService.getEvents();
    return activities;
  }

  Future<void> _loadFavoriteActivities() async {
    List<Map<String, String>> favorites =
        await _firebaseService.getFavoriteActivities();
    setState(() {
      _favoriteActivities = favorites;
    });
  }

  void _addToFavorites(Map<String, String> activity) async {
    setState(() {
      _favoriteActivities.add(activity);
    });
    await _firebaseService.addToFavorites(activity);
    _loadFavoriteActivities();
  }

  void _removeFromFavorites(String activityName) async {
    final favorite = _favoriteActivities
        .firstWhere((activity) => activity['name'] == activityName);
    if (favorite.isNotEmpty) {
      setState(() {
        _favoriteActivities
            .removeWhere((activity) => activity['name'] == activityName);
      });
      await _firebaseService.removeFromFavorites(activityName);
      _loadFavoriteActivities();
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.backgroundColor,
        child: FutureBuilder<List<Map<String, String>>>(
          future: loadingFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No activities available'));
            } else {
              List<Map<String, String>> activities = snapshot.data!;
              final currentActivity = activities[_currentPage];
              final title = currentActivity['title'] ?? 'No Title';
              final description =
                  currentActivity['description'] ?? 'No Description';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HolidayTemperatureWidget(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Expanded(
                    child: CustomPadding(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.001),
                            Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.13,
                              child: Center(
                                child: Text(
                                  'What do you want to do today?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.09,
                                    fontFamily: 'AbrilFatface',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            ImageSlider(
                              activities: activities,
                              pageController: _pageController,
                              onPageChanged: _onPageChanged,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            TextBlockTodayActivities(
                              title: title,
                              description: description,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            BottomNavTodayActivitiesPage(
                              favoriteActivities: _favoriteActivities,
                              addToFavorites: _addToFavorites,
                              removeFromFavorites: _removeFromFavorites,
                              currentActivity: currentActivity,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
