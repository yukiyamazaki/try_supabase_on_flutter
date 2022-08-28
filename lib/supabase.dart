import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ISupabaseService {
  Future<GotrueSessionResponse> signUp({
    required String email,
    required String password,
  });
  Future<GotrueSessionResponse> signIn({
    required String email,
    required String password,
  });
  Future<GotrueResponse> signOut();
  Future<void> insertCompany();
  Future<void> getCompany();
  Future<void> getByQueryCompany();
  Future<void> getByAnotherCompany();
  Future<void> getByQueryForeignTablesProducts();
  Future<void> deleteCompany();
  Future<void> updateCompany();
  Future<void> upsertChats();
  Stream<List<Map<String, dynamic>>> streamChatroom();
}

class SupabaseService implements ISupabaseService {
  static final client = Supabase.instance.client;

  @override
  Future<GotrueSessionResponse> signUp({
    required String email,
    required String password,
  }) {
    return client.auth.signUp(email, password);
  }

  @override
  Future<GotrueSessionResponse> signIn({
    required String email,
    required String password,
  }) {
    return client.auth.signIn(email: email, password: password);
  }

  @override
  Future<GotrueResponse> signOut() {
    return client.auth.signOut();
  }

// INSERT
  @override
  Future<void> insertCompany() async {
    final session = client.auth.session();
    debugPrint(session.toString());
    try {
      final res = await client.from("tenants").upsert({
        "name": "株式会社テストA",
        "created_at": DateTime.now().toIso8601String(),
        "updated_at": DateTime.now().toIso8601String(),
      }).execute();
      debugPrint('レスポンス:${res.error}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

// GET
  @override
  Future<void> getCompany() async {
    try {
      final res = await client.from('companies').select('*').execute();
      debugPrint('レスポンス:${res.data}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

// GET BY QUERY
  @override
  Future<void> getByQueryCompany() async {
    try {
      final res = await client
          .from('companies')
          .select('*')
          .like('name', '%岡%')
          .execute();
      debugPrint('レスポンス:${res.data}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

// GET BY ANOTHER
  @override
  Future<void> getByAnotherCompany() async {
    try {
      final res = await client
          .from('companies')
          .select('*')
          .like('name', '%te%')
          .execute();
      debugPrint('レスポンス:${res.status}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

// GET BY Query foreign tables
  @override
  Future<void> getByQueryForeignTablesProducts() async {
    try {
      final res = await client
          .from('products')
          .select('company_id,companies(name,age)')
          .execute();
      debugPrint('レスポンス:${res.data}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

// DELETE
  @override
  Future<void> deleteCompany() async {
    try {
      final res = await client.from('chats').delete().eq('id', 2).execute();
      debugPrint('レスポンス:${res.status}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

// UPDATE
  @override
  Future<void> updateCompany() async {
    try {
      final res = await client
          .from('companies')
          .update({'name': '株式会社updating'})
          .eq('id', '1')
          .execute();
      debugPrint('レスポンス:${res.status}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // INSERT IN CHATS
  @override
  Future<void> upsertChats() async {
    try {
      final res = await client.from("chats").upsert({
        "talk": "テスト文面",
      }).execute();
      debugPrint('レスポンス:${res.status}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

// REALTIME
  @override
  Stream<List<Map<String, dynamic>>> streamChatroom() {
    return client.from('chats').stream(['id']).execute();
  }
}
