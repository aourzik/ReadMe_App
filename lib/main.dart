import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url:     'https://zxmintbadrdnnchguagu.supabase.co',   // ← ton Project URL
    anonKey: 'sb_publishable_HGX7tVmj97qR0edxy9Nv7A_ioQ6CZY8',                        // ← ton anon key
  );

  runApp(const ReadMeApp());
}