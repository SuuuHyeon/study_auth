import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class HomePage extends StatefulWidget {
  final String userID;
  String email = "이메일";

  HomePage({
    required this.userID,
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Home",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "ID : ",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  widget.userID,
                  style: const TextStyle(fontSize: 25),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
              },
              child: const Text("로그아웃"),
            ),

            ///ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
            /// 생성
            ElevatedButton(
              onPressed: () {
                write("firestore");
              },
              child: const Text("create Test"),
            ),

            /// 수정
            ElevatedButton(
              onPressed: () {
                update();
              },
              child: const Text("set Test"),
            ),

            /// 삭제
            ElevatedButton(
              onPressed: () {
                delete();
              },
              child: const Text("delete Test"),
            ),

            /// 읽기
            ElevatedButton(
              onPressed: () {
                read();
              },
              child: const Text("read Test"),
            ),
            Text("email 값 : ${widget.email}")
          ],
        ),
      ),
    );
  }

  /// 생성 메서드
  void write(String collectionName) async {
    try {
      await firestore.collection(collectionName).add({
        "email": widget.userID,
      });
    } catch (e) {
      print("생성 오류 발생 : $e");
    }
  }

  /// 수정 메서드
  void update() async {
    try {
      await firestore
          .collection("firestore")
          .doc("PPIJPEsw8x7Tysi2r2fe")
          .set({"email": "변경된 이메일입니다."});
    } catch (e) {
      print("set 오류 발생 : $e");
    }
  }

  /// 삭제 메서드
  void delete() async {
    try {
      await firestore
          .collection("firestore")
          .doc("PPIJPEsw8x7Tysi2r2fe")
          .delete();
    } catch (e) {
      print("delete 오류 발생 : $e");
    }
  }

  /// 조회 메서드
  void read() async {
    try {
      var documentSnapshot = await firestore
          .collection("firestore")
          .doc("PPIJPEsw8x7Tysi2r2fe")
          .get();

      var documentEmail = documentSnapshot.data()?["ㄹㄹ"];
      // print(documentEmail);
      setState(() {
        widget.email = documentEmail;
      });
    } catch (e) {
      print("delete 오류 발생 : $e");
    }
  }
}
