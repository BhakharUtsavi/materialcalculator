import 'package:flutter/material.dart';
import 'package:materialcalculator/controller/home_provider.dart';
import 'package:materialcalculator/view/calculator_screen.dart';
import 'package:materialcalculator/view/inventory_screen.dart';
import 'package:materialcalculator/view/past_calculations_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar:
            Consumer<NavigationProvider>(builder: (context, value, child) {
          return BottomNavigationBar(
              currentIndex: value.menuIndex,
              onTap: (val) {
                value.pageController?.animateToPage(val,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.bounceIn);
                value.setMenuIndex(val);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.calculate), label: "Calculator"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.inventory), label: "Inventory"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history), label: "History"),
              ]);
        }),
        body: PageView(
          controller: Provider.of<NavigationProvider>(context, listen: false)
              .pageController,
          onPageChanged: (val) {
            Provider.of<NavigationProvider>(context, listen: false)
                .setMenuIndex(val);
          },
          children: [
            CalculatorScreen(),
            InventoryScreen(),
            PastCalculationsScreen()
          ],
        ));
  }
}
