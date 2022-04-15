import 'package:flutter/material.dart';

import '../MonthsPage/April/april.dart';
import '../MonthsPage/August/august.dart';
import '../MonthsPage/December/december.dart';
import '../MonthsPage/February/february.dart';
import '../MonthsPage/January/january.dart';
import '../MonthsPage/July/july.dart';
import '../MonthsPage/June/june.dart';
import '../MonthsPage/March/march.dart';
import '../MonthsPage/May/may.dart';
import '../MonthsPage/November/november.dart';
import '../MonthsPage/October/october.dart';
import '../MonthsPage/September/september.dart';


class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Try to be grateful everyday'),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.count(
            primary: false,
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            shrinkWrap: true,
            childAspectRatio: 1,
            children: const [
              January(),
              February(),
              March(),
              April(),
              May(),
              June(),
              July(),
              August(),
              September(),
              October(),
              November(),
              December(),
            ],
          ),
        ),
      ),
    );
  }
}

