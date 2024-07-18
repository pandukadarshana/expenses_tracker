import 'dart:ui';

import 'package:expenses_tracker/screens/auth/sign_in_screen.dart';
import 'package:expenses_tracker/screens/auth/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/sign_up_bloc/sign_up_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
	late TabController tabController;
  late TextEditingController emailController; // Define email controller

	@override
  void initState() {
    tabController = TabController(
			initialIndex: 0,
			length: 2, 
			vsync: this
		);
    emailController = TextEditingController(); // Initialize email controller
    super.initState();
  }

   @override
  void dispose() {
    emailController.dispose(); // Dispose email controller
    super.dispose();
  }

   // Function to handle password reset
  void _handleForgotPassword(BuildContext context) async {
    // Show dialog or navigate to reset password screen
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Forgot Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Enter your email to reset your password:'),
                TextFormField(
                  controller: emailController, // Connect controller to TextFormField
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // Handle email input if needed
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Handle password reset logic
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                    email: emailController.text.trim(),
                  );
                  Navigator.of(context).pop('success'); // Close dialog with success
                } catch (e) {
                  print('Error sending reset email: $e');
                  Navigator.of(context).pop('error'); // Close dialog with error
                }
              },
              child: Text('Reset'),
            ),
          ],
        );
      },
    );

    // Handle result if needed (e.g., show a snackbar or navigate based on result)
    if (result == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent')),
      );
    } else if (result == 'error') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send reset email')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			backgroundColor: Theme.of(context).colorScheme.background,
			body: SingleChildScrollView(
				child: SizedBox(
					height: MediaQuery.of(context).size.height,
					child: Stack(
						children: [
							Align(
								alignment: const AlignmentDirectional(20, -1.2),
								child: Container(
									height: MediaQuery.of(context).size.width,
									width: MediaQuery.of(context).size.width,
									decoration: BoxDecoration(
										shape: BoxShape.circle,
										color: Theme.of(context).colorScheme.tertiary
									),
								),
							),
							Align(
								alignment: const AlignmentDirectional(-2.7, -1.2),
								child: Container(
									height: MediaQuery.of(context).size.width / 1.3,
									width: MediaQuery.of(context).size.width / 1.3,
									decoration: BoxDecoration(
										shape: BoxShape.circle,
										color: Theme.of(context).colorScheme.secondary
									),
								),
							),
							Align(
								alignment: const AlignmentDirectional(2.7, -1.2),
								child: Container(
									height: MediaQuery.of(context).size.width / 1.3,
									width: MediaQuery.of(context).size.width / 1.3,
									decoration: BoxDecoration(
										shape: BoxShape.circle,
										color: Theme.of(context).colorScheme.primary
									),
								),
							),
							BackdropFilter(
								filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
								child: Container(),
							),
							Align(
								alignment: Alignment.bottomCenter,
								child: SizedBox(
									height: MediaQuery.of(context).size.height / 1.8,
									child: Column(
										children: [
											Padding(
												padding: const EdgeInsets.symmetric(horizontal: 50.0),
												child: TabBar(
													controller: tabController,
													unselectedLabelColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
													labelColor: Theme.of(context).colorScheme.onBackground,
													tabs: const [
														Padding(
															padding: EdgeInsets.all(12.0),
															child: Text(
																'Sign In',
																style: TextStyle(
																	fontSize: 18,
																),
															),
														),
														Padding(
															padding: EdgeInsets.all(12.0),
															child: Text(
																'Sign Up',
																style: TextStyle(
																	fontSize: 18,
																),
															),
														),
													],
												),
											),
											Expanded(
												child: TabBarView(
													controller: tabController,
													children: [
														BlocProvider<SignInBloc>(
															create: (context) => SignInBloc(
																userRepository: context.read<AuthenticationBloc>().userRepository
															),
															child: const SignInScreen(),
														),
														BlocProvider<SignUpBloc>(
															create: (context) => SignUpBloc(
																userRepository: context.read<AuthenticationBloc>().userRepository
															),
															child: const SignUpScreen(),
														),
													],
												)
											),
                      TextButton(
                        onPressed: () {
                          _handleForgotPassword(context); // Handle forgot password
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                      ),
										],
									),
								),
							)
						],
					),
				),
			),
		);
  }
}