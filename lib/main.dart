import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mt_of_wac/services/imagesecurity.dart';
import 'package:mt_of_wac/viewmodels/data_view_model.dart';
import 'package:mt_of_wac/viewmodels/navigation_provider_view_model.dart';
import 'package:mt_of_wac/viewmodels/slider_banners_view_model.dart';
import 'package:mt_of_wac/views/main_views/main_views.dart';

import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DataViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NavigationProviderViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SliderBannersViewModel(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Weba And Crafts's Mechine Task",
        home: MainViews(),
      ),
    );
  }
}
