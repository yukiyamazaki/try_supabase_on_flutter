import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ISupabaseService {
  Future<void> insertCompany();
  Future<void> getCompany();
  Future<void> getByQueryCompany();
  Future<void> deleteCompany();
  Future<void> updateompany();
}

class SupabaseService implements ISupabaseService {
  static final client = Supabase.instance.client;

// INSERT
  @override
  Future<void> insertCompany() async {
    try {
      final res = await client.from("companies").insert({
        "id": "00003",
        "name": "株式会社test3",
        "age": 200,
        "is_active": true,
      }).execute();
      debugPrint('レスポンス:${res.status}');
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
      final res = await client.from('companies').select('*').execute();
      debugPrint('レスポンス:${res.data}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

// DELETE
  @override
  Future<void> deleteCompany() async {
    try {
      final res = await client.from('companies').delete().execute();
      debugPrint('レスポンス:${res.data}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

// UPDATE
  @override
  Future<void> updateompany() async {
    try {
      final res = await client
          .from('companies')
          .update({'name': '株式会社updating'})
          .eq('id', '1')
          .execute();
      debugPrint('レスポンス:${res.data}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
// REALTIME

}
