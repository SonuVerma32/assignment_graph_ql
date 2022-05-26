import 'package:assignment_graph_ql/view/countries_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const Home()
  );
}
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      title: 'Graph QL',
      home: CountriesHome(),
    );
  }
}
