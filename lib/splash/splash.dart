import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pex/assets/images.dart';
import 'package:pex/user%20dashboard/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/auth.dart';
import '../utils/local_variables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.mobile ||
          value == ConnectivityResult.wifi) {
        Future.delayed(const Duration(seconds: 3)).then((_) {
          if (auth.currentUser == null) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const AuthPage()));
          } else if (auth.currentUser!.displayName == null) {
            auth.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const AuthPage()));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Dashboard()));
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 10),
            content: Text("Please connect to mobile network or Wifi first!")));
        Future.delayed(const Duration(seconds: 10)).then((value) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        currentLanguage = prefs.getString("currentAppLanguage") ?? 'English';
        currentCurrency = prefs.getString("currentCurrencySymbol") ?? '\u20B9';
        prefs.setStringList('categories', [
          '[10084]----Gifts',
          '[128214]----Books',
          '[128391]----Stationary',
          '[9917]----Games & Sports',
          '[128054]----Pet',
          '[127822]----Fruits & Vegetables',
          '[127973]----Medicinal Expenses',
          '[128241]----Electronics',
          '[128661]----Travel'
        ]);
      });
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(50),
          decoration: const BoxDecoration(color: Colors.white),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: logoWithoutPadding,
                ),
                const SizedBox(height: 20),
                const Text(
                  'PEx',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF424242),
                    fontSize: 30,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1,
                    letterSpacing: 0.25,
                  ),
                ),
                const Text(
                  'Personal Expenses Manager',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF616161),
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.25,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
