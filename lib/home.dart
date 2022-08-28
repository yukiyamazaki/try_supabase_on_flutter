import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'main.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.push(RoutePath.signUp);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: const Text('To sign up'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.push(RoutePath.signIn);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: const Text('To sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
