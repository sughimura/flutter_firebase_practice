import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../service/provider.dart';

/// 認証のページ.
/// 今回は新規登録とログインは同じページにしました.
class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = ref.watch(emailProvider);
    final passwordController = ref.watch(passwordProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // AndroidのAppBarの文字を中央寄せ.
        automaticallyImplyLeading: false, //戻るボタンを消す.
        title: const Text('新規登録'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'メールアドレス'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
              ),
              ElevatedButton(
                child: const Text('ユーザ登録'),
                onPressed: () async {
                  try {
                    final User? user = (await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text))
                        .user;
                    if (user != null) {}
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              ElevatedButton(
                child: const Text('ログイン'),
                onPressed: () async {
                  try {
                    // メール/パスワードでログイン
                    final User? user = (await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text))
                        .user;
                    if (user != null) context.go('/mypage');
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}