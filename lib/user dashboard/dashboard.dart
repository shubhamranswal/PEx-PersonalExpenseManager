import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/local_variables.dart';
import 'settings/settings.dart';
import 'report.dart';
import 'home/home.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentPage = 1;
  Widget bodyFunction() {
    switch (currentPage) {
      case 0:
        return const Reports();
      case 1:
        return const Home();
      case 2:
        return settings(context);
      default:
        return const Home();
    }
  }

  @override
  Widget build(BuildContext context) {

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        currentLanguage = prefs.getString("currentAppLanguage") ?? 'English';
        currentCurrency = prefs.getString("currentCurrencySymbol") ?? '\u20B9';
      });
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFFFFFFF),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blueGrey,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        currentIndex: currentPage,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: currentLanguage != 'English' ? r'रिपोर्ट': 'Report',
            icon: const Icon(Icons.summarize_outlined),
          ),
          BottomNavigationBarItem(
            label: currentLanguage != 'English' ? r'होम': 'Home',
            icon: const Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: currentLanguage != 'English' ? r'सेटिंग्स':'Settings',
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: bodyFunction(),
    );
  }
}