import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class AddEntryMenu extends StatelessWidget {
  final VoidCallback onClose;

  const AddEntryMenu({super.key, required this.onClose});

  Future<void> _openCamera(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      print('Фото сделано: ${image.path}');
      // Здесь ты можешь добавить сохранение, отображение и т.д.
    } else {
      print('Камера закрыта без фото');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              onClose();
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _menuButton(
                      context,
                      'assets/icons/activity_add_icon.svg',
                      "Activity",
                          () {
                        Navigator.of(context).pop();
                        onClose();
                        print("Activity clicked");
                      },
                    ),
                    const SizedBox(width: 32),
                    _menuButton(
                      context,
                      'assets/icons/meal_add_icon.svg',
                      "Meal",
                          () async {
                        Navigator.of(context).pop();
                        onClose();
                        await _openCamera(context);
                      },
                    ),
                    const SizedBox(width: 32),
                    _menuButton(
                      context,
                      'assets/icons/other_add_icon.svg',
                      "Other",
                          () {
                        Navigator.of(context).pop();
                        onClose();
                        print("Other clicked");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuButton(BuildContext context, String svgPath, String label, VoidCallback onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Ink(
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: SizedBox(
                width: 56,
                height: 56,
                child: SvgPicture.asset(
                  svgPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
