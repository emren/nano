import 'package:flutter/material.dart';
import 'package:nano/ui/pages/login_screen.dart';
import 'package:nano/ui/pages/store_page.dart';
import 'package:provider/provider.dart';

import 'core/providers/store_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<StoreProvider>(create: (_) => StoreProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //home: const LoginScreen(),
        home: const StorePage(),
      ),
    );
  }
}


