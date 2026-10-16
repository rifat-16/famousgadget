import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const FamousGadgetApp());
}

class FamousGadgetApp extends StatelessWidget {
  const FamousGadgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Famous Gadget BD',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const Scaffold(
        body: Center(
          child: Text('App Setup Complete!'),
        ),
      ),
    );
  }
}