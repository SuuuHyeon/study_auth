import 'package:flutter/material.dart';
import 'package:study_auth/ui/register.dart';

import '../firebase/auth.dart';
import 'home.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  late String userID = '';

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 로그인 화면 제목
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              /// ID, PW 입력부분 위젯
              inputInfo(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ));
                },
                child: const Text("회원가입"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ID, PW 입력부분 위젯화
  Widget inputInfo() {
    return Column(
      children: [
        // ID 입력부분
        TextField(
          controller: _idController,
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
              labelText: "ID",
              border: OutlineInputBorder()),
        ),
        const SizedBox(height: 10),

        // PW 입력부분
        TextField(
          controller: _pwController,
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: "PW",
              border: OutlineInputBorder()),
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: () async {
            Auth auth = Auth();
            bool success = await auth.loginUser(
                _idController.text, _pwController.text);
            if (success) {
              userID = _idController.text;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("로그인 성공"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomePage(userID: userID),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("로그인 실패"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const Text("로그인"),
        ),
      ],
    );
  }
}
