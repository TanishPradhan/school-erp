import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:school_erp/screens/ask_doubt_screen.dart';
import 'package:school_erp/screens/assignment_screen.dart';
import 'package:school_erp/screens/attendance/attendance_screen.dart';
import 'package:school_erp/screens/attendance/enter_attendance.dart';
import 'package:school_erp/screens/change_password_screen.dart';
import 'package:school_erp/screens/events/create_event_screen.dart';
import 'package:school_erp/screens/events/events_screen.dart';
import 'package:school_erp/screens/fees_due_screen.dart';
import 'package:school_erp/screens/login_screen.dart';
import 'package:school_erp/screens/profile_screen.dart';
import 'package:school_erp/screens/settings_screen.dart';

import '../model/user_model.dart';
import '../reusable_widgets/home_screen_cards/master_card.dart';
import '../reusable_widgets/home_screen_cards/small_card.dart';
import '../reusable_widgets/loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box<UserModel> userBox = Hive.box<UserModel>('users');
  CollectionReference firestore =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    double smallCardHeight = MediaQuery.of(context).size.width / 1.8;

    return Scaffold(
      backgroundColor: const Color(0xFF7292CF),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              "assets/Star_Background.png",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height / 1.8,
            //     decoration: const BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(20.0),
            //         topRight: Radius.circular(20.0),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi ${userBox.get("user")?.name?.split(" ")[0] ?? "Student"}",
                            style: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Enrollment: ${userBox.get("user")?.enrollmentNumber ?? "Null"}",
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 6.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              userBox.get("user")?.academicYear ?? "Null",
                              style: const TextStyle(
                                color: Color(0xFF6184C7),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SettingsScreen(),
                            ),
                          );
                        },
                        child: const CircleAvatar(
                          radius: 30.0,
                          child: Icon(
                            Icons.person,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const AttendanceScreen()));
                            },
                            child: const HomeScreenMasterCard(
                                attendance: true),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const FeesDueScreen(),
                                ),
                              );
                            },
                            child: const HomeScreenMasterCard(
                              attendance: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Wrap(
                        runAlignment: WrapAlignment.spaceBetween,
                        alignment: WrapAlignment.spaceBetween,
                        runSpacing: 20.0,
                        spacing: 20.0,
                        children: [
                          HomeScreenSmallCard(
                            icon: Icons.collections_bookmark_rounded,
                            buttonText: "Marks",
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    "Feature coming soon...",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0)),
                                  closeIconColor: Colors.white,
                                  showCloseIcon: true,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: const Color(0xFF2855AE)
                                      .withOpacity(0.9),
                                ),
                              );
                              // Navigator.push(context, MaterialPageRoute(builder: (_) => const EnterAttendance()));
                            },
                          ),
                          HomeScreenSmallCard(
                            icon: Icons.person,
                            buttonText: "Assignment",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AssignmentScreen(),
                              ),
                            ),
                          ),
                          // HomeScreenSmallCard(
                          //   icon: Icons.lock,
                          //   buttonText: "Change Password",
                          //   onTap: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (_) => const ChangePasswordScreen(),
                          //     ),
                          //   ),
                          // ),
                          HomeScreenSmallCard(
                            icon: Icons.chat,
                            buttonText: "Ask Doubts",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AskDoubtScreen(),
                              ),
                            ),
                          ),
                          HomeScreenSmallCard(
                            icon: Icons.edit_calendar_rounded,
                            buttonText: "Events",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EventsScreen(),
                              ),
                            ),
                          ),
                          // HomeScreenSmallCard(
                          //   icon: Icons.logout_rounded,
                          //   buttonText: "Logout",
                          //   onTap: () {
                          //     showDialog(
                          //         context: context,
                          //         builder: (BuildContext context) =>
                          //             const LoaderDialog());
                          //     userBox.clear().then(
                          //           (value) =>
                          //               Navigator.pushAndRemoveUntil(
                          //                   context,
                          //                   MaterialPageRoute(
                          //                     builder: (_) =>
                          //                         const LoginScreen(),
                          //                   ),
                          //                   (route) => false),
                          //         );
                          //   },
                          // ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
