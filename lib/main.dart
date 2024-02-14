import 'package:flutter/material.dart';
import 'package:study_auth/ui/login.dart';

/// TODO firebase 연결 후 주석 풀기
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() async {
  // flutter 애플리케이션 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // firebase 초기화
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginPage());
  }
}
