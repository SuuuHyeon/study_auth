import 'package:firebase_auth/firebase_auth.dart';

/// firebase auth 관련 메서드

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

  /// 회원가입
  Future<bool> createUser(String id, String pw) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: id, password: pw);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('비밀번호가 취약합니다.');
      } else if (e.code == 'email-already-in-use') {
        print('이미 존재하는 이메일입니다.');
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// 로그인
  Future<bool> loginUser(String id, String pw) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: id, password: pw);
      return true; // 로그인 성공
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('존재하지 않는 유저입니다.');
      } else if (e.code == 'wrong-password') {
        print('잘모된 비밀번호입니다,');
      } else if (e.code == 'invalid-email') {
        print('이메일을 확인하세요.');
      }
      return false; // 로그인 실패
    } catch (e) {
      print(e);
      return false; // 로그인 실패
    }
  }
}
