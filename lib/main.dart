import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/menu.dart';
import 'services/api_client.dart';
import 'services/auth_state.dart';

void main() {
  runApp(MyApp(apiClient: ApiClient()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.apiClient});

  final ApiClient apiClient;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: apiClient),
        ChangeNotifierProvider<AuthState>(
          create: (_) => AuthState(apiClient),
        ),
      ],
      child: MaterialApp(
        title: 'MyPortfolio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
