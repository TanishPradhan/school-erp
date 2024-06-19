import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:school_erp/bloc/login_bloc/login_bloc.dart';
import 'package:school_erp/components/plain_background.dart';
import 'package:school_erp/components/textfield.dart';
import 'package:school_erp/reusable_widgets/loader.dart';
import 'package:school_erp/screens/home_screen.dart';
import '../model/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Controllers for Email & Password textfields
  TextEditingController enrollmentController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Hive Box initialization
  Box<UserModel> userBox = Hive.box<UserModel>('users');

  //Firebase - Firestore initialization
  CollectionReference loginCollection =
      FirebaseFirestore.instance.collection('login_details');
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  //Bloc initialization
  late LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      // BlocProvider(
      // create: (context) => LoginBloc(),
      // child: BlocConsumer<LoginBloc, LoginState>(
      //   bloc: loginBloc,
      //   listener: (context, state) {
      //     debugPrint("Listener");
      //     if (state is LoginSuccessState) {
      //       debugPrint("Login Success State");
      //       Navigator.pop(context);
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (_) => const HomeScreen(),
      //         ),
      //       );
      //     }
      //     if (state is LoginErrorState) {
      //       Navigator.pop(context);
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: const Text(
      //             "Login Failed! Please check the details properly.",
      //             style: TextStyle(
      //               fontSize: 14.0,
      //               fontWeight: FontWeight.w500,
      //               color: Colors.white70,
      //             ),
      //           ),
      //           shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(8.0)),
      //           // closeIconColor: Colors.white,
      //           // showCloseIcon: true,
      //           behavior: SnackBarBehavior.floating,
      //           backgroundColor: Colors.red.withOpacity(0.9),
      //         ),
      //       );
      //     }
      //   },
      //   builder: (context, state) =>
            Scaffold(
          backgroundColor: const Color(0xFF5D83C6),
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  const PlainBackground(),
                  Column(
                    children: [
                      const SizedBox(height: 200),
                      Container(
                        height: MediaQuery.of(context).size.height / 1.37,
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40.0),
                            const Text(
                              "Hi Student",
                              style: TextStyle(
                                fontSize: 34.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const Text(
                              "Sign in to continue",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black45,
                              ),
                            ),
                            const SizedBox(height: 40.0),
                            const Text(
                              "Enrollment Number",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFA5A5A5),
                                height: 1.0,
                              ),
                            ),
                            CommonTextField(
                              controller: enrollmentController,
                              textCapitalization: TextCapitalization.none,
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 25.0),
                            const Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFA5A5A5),
                                height: 1.0,
                              ),
                            ),
                            CommonTextField(
                              controller: passwordController,
                              obscureText: true,
                              maxLines: 1,
                              textCapitalization: TextCapitalization.none,
                            ),
                            const SizedBox(height: 30.0),
                            GestureDetector(
                              onTap: () async {
                                if (enrollmentController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Enter email to continue")));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const LoaderDialog());
                                  // LoginBloc().add(LoginUserState(
                                  //     enrollmentController, passwordController));
                                  await loginCollection
                                      .where("enrollment",
                                          isEqualTo: enrollmentController.text
                                              .toString())
                                      .where("password",
                                          isEqualTo:
                                              passwordController.text.toString())
                                      .get()
                                      .then((value) async {
                                    debugPrint("Login Success: ${value.docs}");
                                    var userId = await usersCollection
                                        .where("enrollment",
                                            isEqualTo: enrollmentController.text
                                                .toString())
                                        .get();
                                    debugPrint("user: ${userId.size}");
                                    var user = await usersCollection
                                        .doc(userId.docs[0].id)
                                        .get();

                                    var userDetails = UserModel.fromJson(
                                        user.data() as Map<String, dynamic>);
                                    userBox
                                        .put('user', userDetails)
                                        .then((value) {
                                      Navigator.pop(context);
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const HomeScreen()));
                                    });
                                  }).catchError((e) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          "Login Failed! Please check the details properly.",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        // closeIconColor: Colors.white,
                                        // showCloseIcon: true,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor:
                                            Colors.red.withOpacity(0.9),
                                      ),
                                    );
                                  });
                                }
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF2855AE),
                                      Color(0xFF7292CF),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Center(
                                  child: Text(
                                    "SIGN IN",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Color(0xFF313131),
                                  fontSize: 14.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.width / 8,
                    right: 20.0,
                    left: 20.0,
                    child: Image.asset(
                      "assets/school_erp_vector.png",
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      // ),
    // );
  }
}
