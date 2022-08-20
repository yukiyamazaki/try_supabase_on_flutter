import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'supabase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'],
    anonKey: dotenv.env['SUPABASE_ANON_KEY'],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Supabase × Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Text(widget.title),
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
