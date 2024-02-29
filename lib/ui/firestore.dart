import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreTest extends StatefulWidget {
  FirestoreTest({super.key});

  @override
  State<FirestoreTest> createState() => _FirestoreTestState();
}

class _FirestoreTestState extends State<FirestoreTest> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String email = "???";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 생성
            ElevatedButton(
              onPressed: () {
                write("firestore");
              },
              child: const Text("생성"),
            ),

            // 수정
            ElevatedButton(
              onPressed: () {
                update();
              },
              child: const Text("수정"),
            ),

            // 삭제
            ElevatedButton(
              onPressed: () {
                delete();
              },
              child: const Text("삭재"),
            ),

            // 읽기
            ElevatedButton(
              onPressed: () {
                read();
              },
              child: const Text("조회"),
            ),
            Text("email : $email")
          ],
        ),
      ),
    );
  }

  /// doc("") 안에 들어갈 문자열은 생성메서드로 생성된 도큐먼트의 문자열을 넣으면 테스트 가능(자신의 파이어스토어 참조)

  // 생성 메서드
  void write(String collectionName) async {
    try {
      await firestore.collection(collectionName).add({
        "ID": "inha",
      });
    } catch (e) {
      print("생성 오류 발생 : $e");
    }
  }

  // 수정 메서드
  void update() async {
    try {
      await firestore
          .collection("firestore")
          .doc("6igxTaoclHe0btBuUTtU")
          .set({"ID": "변경된 이메일입니다."});
    } catch (e) {
      print("수정 오류 발생 : $e");
    }
  }

  // 삭제 메서드
  void delete() async {
    try {
      await firestore
          .collection("firestore")
          .doc("6igxTaoclHe0btBuUTtU")
          .delete();
    } catch (e) {
      print("삭제 오류 발생 : $e");
    }
  }

  // 조회 메서드
  void read() async {
    try {
      var documentSnapshot = await firestore
          .collection("firestore")
          .doc("unx8ZWFANq46SjP9OrvF")
          .get();

      var documentEmail = documentSnapshot.data()?["ID"];
      print(documentEmail);
      setState(() {
        email = documentEmail;
      });
    } catch (e) {
      print("조회 오류 발생 : $e");
    }
  }
}
