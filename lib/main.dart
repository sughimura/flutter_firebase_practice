import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/service/provider.dart';
import 'package:flutter_firebase_practice/service/router.dart';
import 'package:flutter_firebase_practice/ui/auth/sign_in_page.dart';
import 'package:flutter_firebase_practice/ui/page/my_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

// go_routerで最初に呼び出されるページ。何も表示されることはない.
// ログインしていなければ認証のページに移動し、ログインして入れば、
// ログイン後のページへ移動する.
class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // StreamProvider を監視し、AsyncValue<User?> を取得する。
    final authStateAsync = ref.watch(authStateChangesProvider);
    // パターンマッチングを使用して、状態をUIにマッピングする
    return authStateAsync.when(
      data: (user) => user != null ? const MyPage() : const SignInPage(),
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
