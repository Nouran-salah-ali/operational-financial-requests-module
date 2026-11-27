import 'package:flutter/material.dart';

class FinancialRequestsApp extends StatelessWidget {
  const FinancialRequestsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Operational & Financial Requests',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F4C81)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Step 2 Architecture Ready'),
        ),
      ),
    );
  }
}