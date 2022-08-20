import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'supabase.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({Key? key}) : super(key: key);

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
                const Text('Try Supabase!'),
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
                      await supabase.signIn(email: email, password: password);
                      debugPrint('サインイン成功');
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: const Text('SIGN IN'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
