import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_app/app.dart';
import 'package:laundry_app/features/auth/presentation/screens/login_screen.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const LaundryApp());
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('Login form validation works', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    
    // Find form elements
    final emailField = find.widgetWithText(TextField, 'Enter your email');
    final passwordField = find.widgetWithText(TextField, 'Enter your password');
    final loginButton = find.widgetWithText(ElevatedButton, 'Sign In');
    
    // Tap login without entering credentials
    await tester.tap(loginButton);
    await tester.pump();
    
    // Should show validation errors
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
    
    // Enter invalid email
    await tester.enterText(emailField, 'invalid-email');
    await tester.tap(loginButton);
    await tester.pump();
    
    expect(find.text('Please enter a valid email'), findsOneWidget);
    
    // Enter valid email but short password
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, '123');
    await tester.tap(loginButton);
    await tester.pump();
    
    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
  });

  testWidgets('Theme toggle works', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    
    // Find theme toggle button
    final themeButton = find.byIcon(Icons.dark_mode);
    
    expect(themeButton, findsOneWidget);
    
    // Tap to toggle theme
    await tester.tap(themeButton);
    await tester.pump();
  });

  testWidgets('Password visibility toggle works', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    
    // Find password field and visibility toggle
    final passwordField = find.widgetWithText(TextField, 'Enter your password');
    final visibilityToggle = find.byIcon(Icons.visibility_off_outlined);
    
    // Initially password should be obscured
    await tester.enterText(passwordField, 'password123');
    final textField = tester.widget<TextField>(passwordField);
    expect(textField.obscureText, true);
    
    // Tap to show password
    await tester.tap(visibilityToggle);
    await tester.pump();
    
    // Password should now be visible
    final updatedTextField = tester.widget<TextField>(passwordField);
    expect(updatedTextField.obscureText, false);
  });
}