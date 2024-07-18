import 'package:expense_repository/expense_repository.dart';
import 'package:expenses_tracker/screens/home/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/home/views/home_screen.dart';
import 'package:expenses_tracker/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:expenses_tracker/screens/auth/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/sign_in_bloc/sign_in_bloc.dart';
// import 'screens/home/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(colorScheme: ColorScheme.light(background: Colors.grey.shade100, onBackground: Colors.black, primary: const Color(0xFF00B2E7), secondary: const Color(0xFFE064F7), tertiary: const Color(0xFFFF8D6C), outline: Colors.grey)),
      // home: BlocProvider(
      //   create: (context) => GetExpensesBloc(
      //     FirebaseExpenseRepo()
      //   )..add(GetExpenses()),
      //   child: const HomeScreen(),
      // ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
				builder: (context, state) {
					if(state.status == AuthenticationStatus.authenticated) {
            String userName ='admin';
             if (state.user != null) {
              if (state.user!.displayName != null) {
                userName = state.user!.displayName!;
              } else {
                // If displayName is null, use email as a fallback
                userName = state.user!.email ?? 'User';
              }
            }
            // userName=state.user!.displayName.toString(); 
						return BlocProvider(
							create: (context) => GetExpensesBloc(
                FirebaseExpenseRepo()
              )..add(GetExpenses()),
              child:  HomeScreen(userName: userName),
						);
					} else {
						return const WelcomeScreen();
					}
				}
			)
    );
  }
}
