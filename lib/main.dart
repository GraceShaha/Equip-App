import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'equip_home.dart';
import 'equip_cart.dart';
import 'cart.dart';
import 'equip_colors.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Cart(),
      child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
        debugShowCheckedModeBanner: false,
        title: 'Equip App',
        initialRoute: '/',
        routes: {
          '/': (context) => EquipHome(),
          '/cart': (context) => EquipCart()
        },
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: EquipColors.neutral
        )
      ),
    );
  }
}

