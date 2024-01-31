import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seru_tech_test/provider/screen_one_provider.dart';
import 'package:seru_tech_test/shared/theme.dart';
import 'package:seru_tech_test/view/screen_one.dart';

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
        ChangeNotifierProvider(
          create: (_) => ScreenOneProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: numberBackgroundColor,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: numberBackgroundColor,
            iconTheme: IconThemeData(
              color: whiteColor,
            ),
            titleTextStyle: whiteTextStyle.copyWith(
              fontWeight: semibold,
              fontSize: 20,
            ),
          ),
        ),
        home: const ScreenOne(),
      ),
    );
  }
}
