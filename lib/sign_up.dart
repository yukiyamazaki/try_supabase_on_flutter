import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:try_supabase_on_flutter/main.dart';

import 'supabase.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final supabase = SupabaseService();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sign up!'),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // sign in
                    final email = emailController.text;
                    final password = passwordController.text;
                    try {
                      final res = await supabase.signUp(
                          email: email, password: password);
                      if (res.statusCode != 200) {
                        throw Exception();
                      }
                      debugPrint('サインアップ成功');
                      // ignore: use_build_context_synchronously
                      context.push(RoutePath.database);
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: const Text('SIGN UP'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
