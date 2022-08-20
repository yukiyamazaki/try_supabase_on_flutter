import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'supabase.dart';

class DatabaseWidget extends StatefulWidget {
  const DatabaseWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DatabaseWidget> createState() => _DatabaseWidgetState();
}

class _DatabaseWidgetState extends State<DatabaseWidget> {
  late final Stream<List<Map<String, dynamic>>> _chatStream;

  final supabase = SupabaseService();

  @override
  void initState() {
    // なぜinistState内で定義しないと動かいない？
    _chatStream = supabase.streamChatroom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: context.pop,
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: supabase.insertCompany,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueAccent),
              ),
              child: const Text('Insert data.'),
            ),
            ElevatedButton(
              onPressed: supabase.getCompany,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              child: const Text('Get data.'),
            ),
            ElevatedButton(
              onPressed: supabase.getByQueryCompany,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
              ),
              child: const Text('Get data by query.'),
            ),
            ElevatedButton(
              onPressed: supabase.getByQueryCompany,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.amberAccent),
              ),
              child: const Text('Get data by another method.'),
            ),
            ElevatedButton(
              onPressed: supabase.updateCompany,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.deepOrange),
              ),
              child: const Text('Update data.'),
            ),
            ElevatedButton(
              onPressed: supabase.deleteCompany,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text('Delete data.'),
            ),
            ElevatedButton(
              onPressed: supabase.upsertChats,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              child: const Text('Upsert chats'),
            ),
            ElevatedButton(
              onPressed: supabase.signOut,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text('Sign out'),
            ),
            Column(
              children: [
                const Text(
                  'Chats roomのListener結果',
                  style: TextStyle(color: Colors.black),
                ),
                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: _chatStream,
                  builder: ((context, snapshot) {
                    final data = snapshot.data;
                    if (data == null) {
                      return const Text('データなし');
                    }
                    return Text('データ数：${data.length}');
                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Chat {
  Chat({
    required this.id,
    required this.createdAt,
    required this.talk,
  });

  final int id;
  // ignore: non_constant_identifier_names
  final DateTime createdAt;
  final String talk;
}
