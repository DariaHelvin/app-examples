import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/shared/navigation_bar.dart';
import '../widgets/shared/add_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: Stack(
        children: [
          // ✅ HEADLINE OBEN LINKS: Profile & Settings
          const Positioned(
            top: 60,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // ✅ ZAHNRAD BILD OBEN RECHTS IM WEISSEN KREIS
          Positioned(
            top: 50,
            right: 30,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                'assets/images/settings_icon.png',
                width: 80,
                height: 80,
              ),
            ),
          ),

          // ✅ WEISSES PANEL UNTEN
          Positioned.fill(
            top: 250,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ ACCOUNT BLOCK — schön ausgerichtet mit Abstand
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Account",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: user.isConnected ? Colors.green : Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  user.isConnected ? "connected" : "not connected",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: 200,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F3F3),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                user.sensor != null && user.sensor!.isNotEmpty ? user.sensor! : "-",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

// ✅ EMAIL BLOCK — gleiche Logik
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          width: 200,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F3F3),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Text(
                            user.email.isNotEmpty ? user.email : "-",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

// ✅ PASSWORD BLOCK — same same
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          width: 200,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F3F3),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Text(
                            user.isConnected && user.password.isNotEmpty
                                ? '*' * user.password.length
                                : "-",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                        ),


                      ],
                    ),



                    const SizedBox(height: 30),

                    // ✅ BUTTON
                    Align(
                      alignment: Alignment.centerRight, // 👉 Rechtsbündig!
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20), // 👉 Abstand vom rechten Rand
                        child: ElevatedButton(
                          onPressed: () {
                            if (user.isConnected) {
                              user.logout();
                            } else {
                              // Wieder verbinden
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF4B00),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            user.isConnected ? "Disconnect" : "Connect",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),


                    const SizedBox(height: 95),

                    // ✅ LANGUAGE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Language",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20, // 👈 GRÖSSER!
                          ),
                        ),
                        Container(
                          width: 200,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 9),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F3F3),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: "English",
                              icon: const Icon(Icons.keyboard_arrow_down),
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 20, // 👈 GRÖSSER!
                              ),
                              isDense: true,
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                  value: "English",
                                  child: Text(
                                    "English",
                                    style: TextStyle(fontWeight: FontWeight.normal),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Deutsch",
                                  child: Text(
                                    "Deutsch",
                                    style: TextStyle(fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                              onChanged: (_) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // ✅ NAVIGATION & BUTTON
      bottomNavigationBar:
      const NavigationBarWidget(currentPage: 'Profile'),
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 30),
        child: const AddButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
