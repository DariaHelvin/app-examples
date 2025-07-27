import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hagenberg_app/widgets/holiday_temperature_widget.dart';
import 'package:hagenberg_app/utils/app_colors.dart';
import 'package:hagenberg_app/widgets/custom_padding.dart';
import 'package:hagenberg_app/services/map_service.dart';
import 'package:hagenberg_app/widgets/map_icon_button.dart';
import 'package:hagenberg_app/widgets/bottom_nav_description_page.dart';
import 'package:hagenberg_app/widgets/text_block_description_page.dart';

class ActivitiesDescriptionPage extends StatefulWidget {
  final Map<String, String> activity;
  final List<Map<String, String>> favoriteActivities;
  final Function(Map<String, String>) addToFavorites;
  final Function(String) removeFromFavorites;

  const ActivitiesDescriptionPage({
    Key? key,
    required this.activity,
    required this.favoriteActivities,
    required this.addToFavorites,
    required this.removeFromFavorites,
  }) : super(key: key);

  @override
  State<ActivitiesDescriptionPage> createState() =>
      _ActivitiesDescriptionPageState();
}

class _ActivitiesDescriptionPageState extends State<ActivitiesDescriptionPage> {
  final MapService _mapService = MapService();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.backgroundColor,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  void _handleAddToFavorites(Map<String, String> activity) {
    widget.addToFavorites(activity);
    setState(() {});
  }

  void _handleRemoveFromFavorites(String activityName) {
    widget.removeFromFavorites(activityName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double latitude =
        double.tryParse(widget.activity['latitude'] ?? '0.0') ?? 0.0;
    final double longitude =
        double.tryParse(widget.activity['longitude'] ?? '0.0') ?? 0.0;
    final String imageUrl = widget.activity['image'] ?? '';

    return Scaffold(
      body: Container(
        color: AppColors.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HolidayTemperatureWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: CustomPadding(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      TextBlockDescriptionPage(
                        name: widget.activity['name'] ?? '',
                        schedule: widget.activity['schedule'] ?? '',
                        fullDescription:
                            widget.activity['full_description'] ?? '',
                        address: widget.activity['address'] ?? '',
                      ),
                      MapIconButton(
                        latitude: latitude,
                        longitude: longitude,
                        launchMapsUrl: _mapService.launchMapsUrl,
                      ),
                      BottomNavDescriptionPage(
                        favoriteActivities: widget.favoriteActivities,
                        addToFavorites: _handleAddToFavorites,
                        removeFromFavorites: _handleRemoveFromFavorites,
                        currentActivity: widget.activity,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
