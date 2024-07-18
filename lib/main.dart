import 'package:bloc/bloc.dart';
import 'package:expenses_tracker/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase with your Firebase project configuration
    await Firebase.initializeApp(
      options: FirebaseOptions(
        
      ),
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
    // Handle the error gracefully, e.g., show an error dialog
    return; // Exit the app if Firebase initialization fails
  }

  // Set up BLoC observer
  Bloc.observer = SimpleBlocObserver();

  // Run the Flutter application
  runApp(MyApp(FirebaseUserRepo()));
}
