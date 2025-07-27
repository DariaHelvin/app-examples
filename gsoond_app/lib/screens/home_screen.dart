import 'package:flutter/material.dart';
import '../widgets/today/today_header.dart';
import '../widgets/today/glucose_value_box.dart';
import '../widgets/today/glucose_chart_container.dart';
import '../widgets/shared/navigation_bar.dart';
import '../widgets/shared/add_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/glucose_provider.dart';
import '../widgets/today/today_header.dart';
import '../widgets/today/glucose_value_box.dart';
import '../widgets/today/glucose_chart_container.dart';
import '../widgets/shared/navigation_bar.dart';
import '../widgets/shared/add_button.dart';
import 'package:gsoond_app/providers/glucose_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Daten nach dem ersten Build laden
    Future.microtask(() =>
        Provider.of<GlucoseProvider>(context, listen: false).fetchGlucose());
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.01),
            const TodayHeader(),
            SizedBox(height: screenHeight * 0.02),
            const GlucoseValueBox(),
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                child: const GlucoseChartContainer(),
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
          ],
        ),
      ),
      bottomNavigationBar: const NavigationBarWidget(currentPage: 'Today'),
      floatingActionButton: Transform.translate(
        offset: Offset(0, screenHeight * 0.040),
        child: const AddButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
