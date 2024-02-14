import 'package:flutter/material.dart';

import '../firebase/auth.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

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
                "Register",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),

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
                  bool success = await auth.createUser(
                      _idController.text, _pwController.text);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("가입 성공"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("가입 실패"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text("가입하기"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                },
                child: const Text("로그인하기"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
