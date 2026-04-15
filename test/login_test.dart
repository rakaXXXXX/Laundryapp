import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_app/features/auth/presentation/screens/login_screen.dart';

void main() {
  testWidgets('Login screen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.text('Sign in to continue'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('or continue with'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Don\'t have an account?'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });
}