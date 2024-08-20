import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:mt_of_wac/sources/custom_source_widgets.dart';
import 'package:mt_of_wac/viewmodels/navigation_provider_view_model.dart';
import 'package:mt_of_wac/views/account_views/accounts_views.dart';
import 'package:mt_of_wac/views/cart_views/cart_views.dart';
import 'package:mt_of_wac/views/categories_views/categories_views.dart';
import 'package:mt_of_wac/views/home_views/home_views.dart';
import 'package:mt_of_wac/views/offers_views/offers_views.dart';
import 'package:provider/provider.dart';

class MainViews extends StatefulWidget {
  const MainViews({super.key});

  @override
  MainViewsState createState() => MainViewsState();
}

class MainViewsState extends State<MainViews> {
  late CircularBottomNavigationController _navigationController;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeViews(),
    CategoriesViews(),
    CartViews(),
    OffersViews(),
    AccountsViews(),
  ];

  final List<TabItem> tabItems = List.of([
    TabItem(
      Mdi.homeVariant,
      "Home",
      kGreen,
    ),
    TabItem(
      Mdi.shapePlusOutline,
      "Category",
      kGreen,
    ),
    TabItem(
      Mdi.cart,
      "Cart",
      kGreen,
    ),
    TabItem(
      Mdi.sale,
      "Offers",
      kGreen,
    ),
    TabItem(
      Mdi.account,
      "Account",
      kGreen,
    ),
  ]);

  @override
  void initState() {
    super.initState();
    final navigationProvider =
        Provider.of<NavigationProviderViewModel>(context, listen: false);
    _navigationController =
        CircularBottomNavigationController(navigationProvider.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider =
        Provider.of<NavigationProviderViewModel>(context);

    return Scaffold(
      extendBody: true,
      body: Center(
        child: _widgetOptions.elementAt(navigationProvider.currentIndex),
      ),
      bottomNavigationBar: circularBottomNavigationWidget(navigationProvider),
    );
  }

  @override
  void dispose() {
    _navigationController.dispose();
    super.dispose();
  }

  CircularBottomNavigation circularBottomNavigationWidget(
      NavigationProviderViewModel navigationProvider) {
    return CircularBottomNavigation(
      normalIconColor: kGreyShade700,
      tabItems.map((tabItem) {
        return TabItem(tabItem.icon, tabItem.title, tabItem.circleColor,
            labelStyle: tabItem.labelStyle);
      }).toList(),
      controller: _navigationController,
      circleSize: 50,
      iconsSize: 22,
      barBackgroundColor: kGreyShade300,
      selectedCallback: (int? selectedPos) {
        setState(() {
          navigationProvider.currentIndex = selectedPos ?? 0;
        });
      },
    );
  }
}
