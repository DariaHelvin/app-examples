import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../today/add_entry_menu.dart';

class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (_isMenuOpen) AddEntryMenu(onClose: _toggleMenu),
        GestureDetector(
          onTap: _toggleMenu,
          child: SvgPicture.asset(
            'assets/icons/entry_icon.svg',
            width: 56,
            height: 56,
          ),
        ),
      ],
    );
  }
}
