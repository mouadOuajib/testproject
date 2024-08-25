import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testproject/screens/bottom_navbar_screen.dart';
import 'package:testproject/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ValueNotifier<int>(0),
        ),
      ],
      child: const TestApplication(),
    ),
  );
}

class TestApplication extends StatelessWidget {
  const TestApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      title: 'test application',
      home: const BottomNavbarScreen(),
    );
  }
}
