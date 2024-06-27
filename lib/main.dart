import 'package:flutter/material.dart';
import 'package:coba/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';




  Future<void> main() async {
  await Supabase.initialize(
    url: 'https://nlgczwedhtkrkinbgasu.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5sZ2N6d2VkaHRrcmtpbmJnYXN1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg5MzEyNjcsImV4cCI6MjAzNDUwNzI2N30.aEHIv7lf-dmMjwIF9CqtWHbmnwfMfHzY1ogC4DsZrhc',
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginApp()
    );
  }
}
