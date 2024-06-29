import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Login後のページ
class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // ログアウト処理
              // 内部で保持しているログイン情報等が初期化される
              await FirebaseAuth.instance.signOut();
              context.go('/auth');
            },
          ),
        ],
        title: const Text('HomePage'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                // ボタンを押した時のイベント
                onPressed: () {
                  /* ここにプログラムを記載 */
                  FirebaseFirestore.instance
                      .collection('flutterDataCollection')
                      .doc('flutterDataDocument')
                      .get()
                      .then((ref) {
                    print(ref.get('mydata'));
                  });
                },
                child: const Text(
                  '取得',
                  style: TextStyle(fontSize: 50),
                ),
              ),
              TextButton(onPressed: () {
                FirebaseFirestore.instance
                    .collection('flutterDataCollection')
                    .doc('flutterDataDocument')
                    .set({'autofield': "abc"}, SetOptions(merge: true));
                }, child: const Text('登録', style: TextStyle(fontSize: 30),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
