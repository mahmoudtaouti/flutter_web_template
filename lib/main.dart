import 'package:flutter/material.dart';
import 'package:web_template/examples/blogs/blogs_page_example.dart';
import 'package:web_template/examples/dashboard/dashboard_example.dart';
import 'widgets/layout/centered_web_content.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CenteredWebContent(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.light(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.light(
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: const DashboardExample(),
      ),
    );
  }

}
