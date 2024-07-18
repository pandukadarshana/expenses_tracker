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
        apiKey: "AIzaSyB1jRTV-j-J935U9bZaKkL9H9449JcUZE0",
        appId: "1:724450669177:android:5d442ab41bbeb349aadaa8",
        messagingSenderId: "724450669177",
        projectId: "expens-tracker-7bcc5",
        storageBucket: "expens-tracker-7bcc5.appspot.com",
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
