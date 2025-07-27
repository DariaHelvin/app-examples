import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final List<Map<String, String>> activities;
  final PageController pageController;
  final Function(int) onPageChanged;

  const ImageSlider({
    Key? key,
    required this.activities,
    required this.pageController,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          iconSize: 40.0,
          onPressed: () {
            if (pageController.hasClients) {
              pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
        Expanded(
          flex: 10,
          child: AspectRatio(
            aspectRatio: 14 / 11,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: onPageChanged,
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                final imageUrl = activity['image'] ?? '';
                if (imageUrl.isEmpty) {
                  return Center(child: Text('No image available'));
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Text('Failed to load image'));
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
          iconSize: 40.0,
          onPressed: () {
            if (pageController.hasClients) {
              pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
      ],
    );
  }
}
