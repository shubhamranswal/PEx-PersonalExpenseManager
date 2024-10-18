import 'package:currency_picker/currency_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pex/auth/auth.dart';
import 'package:pex/user%20dashboard/settings/faqs.dart';
import 'package:pex/user%20dashboard/settings/request_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../assets/images.dart';
import '../../utils/local_variables.dart';
import '../../utils/user_details.dart';
import 'category/manage.dart';

Widget settings(BuildContext context){
  return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: const Color(0xC268B0E3),
        foregroundColor: const Color(0xC268B0E3),
        title: Text(
          currentLanguage != "English" ? r"PEx - सेटिंग्स" : 'PEx - Settings',
          style: const TextStyle(
            color: Color(0xFF424242),
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 1.20,
            letterSpacing: 0.18,
          ),
        ),
        titleSpacing: 0,
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: logoWithoutPadding,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xC29AE7F3),
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              height: 150,
              child: Row(
                children: [
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(40), // Image radius
                      child: profileImageURL == null
                          ? Container(
                        color: const Color(0xC20E919F),
                        child: const FittedBox(
                            fit: BoxFit.cover,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            )),
                      )
                          : Image.network(
                        profileImageURL.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name.toString().trim(),
                          style: const TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                            letterSpacing: 0.15,
                          ),
                        ),
                        Text(
                          email.toString().trim(),
                          style: const TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                            letterSpacing: 0.40,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.category_outlined),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ManageCategory()));
                  },
                  title: Text(
                    currentLanguage != "English" ? r"श्रेणी व्यवस्थित करें" : 'Manage categories',
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      letterSpacing: 0.25,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.currency_rupee),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showCurrencyPicker(
                      favorite: ['INR', 'USD', 'EUR', 'GBP', 'JPY'],
                      context: context,
                      showFlag: true,
                      showCurrencyName: true,
                      showCurrencyCode: true,
                      onSelect: (Currency currency) {
                        SharedPreferences.getInstance().then((prefs) {
                          prefs.setString("currentCurrencySymbol",
                              currency.symbol.toString());
                        });
                      },
                    );
                  },
                  title: Text(
                    currentLanguage != "English" ? r"मुद्रा परिवर्तन ""($currentCurrency)"  : 'Change currency ($currentCurrency)',
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      letterSpacing: 0.25,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.translate_outlined),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showModalBottomSheet(
                        showDragHandle: true,
                        context: context,
                        backgroundColor: Colors.white,
                        builder: (BuildContext context) {
                          return FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    currentLanguage != "English" ? r"भाषा बदलें ""($currentLanguage)"  : 'Change Language ($currentLanguage)',
                                    style: const TextStyle(
                                      color: Color(0xFF212121),
                                      fontSize: 20,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 1.43,
                                      letterSpacing: 0.25,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      SharedPreferences.getInstance().then((prefs) {
                                        prefs.setString("currentAppLanguage",
                                            "English");
                                      });
                                      const snackBar = SnackBar(
                                        content:
                                        Text("Language set to English!"),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'English',
                                      style: TextStyle(
                                        color: Color(0xFF212121),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 1.43,
                                        letterSpacing: 0.25,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7.5,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      SharedPreferences.getInstance().then((prefs) {
                                        prefs.setString("currentAppLanguage",
                                            r"हिन्दी");
                                      });
                                      const snackBar = SnackBar(
                                        content:
                                        Text(r"भाषा हिन्दी पर सेट!"),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      r"हिन्दी",
                                      style: TextStyle(
                                        color: Color(0xFF212121),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 1.43,
                                        letterSpacing: 0.25,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  title: Text(
                    currentLanguage != "English" ? r"भाषा बदलें ""($currentLanguage)"  : 'Change Language ($currentLanguage)',
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      letterSpacing: 0.25,
                    ),
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.question_answer_outlined),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    if (currentLanguage != "English") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FAQPage(faqs: generalFAQsHindi),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FAQPage(faqs: generalFAQsEnglish),
                        ),
                      );
                    }
                  },
                  title: Text(
                    currentLanguage != "English" ? r"पूछे जाने वाले प्रश्न" : 'FAQs',
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      letterSpacing: 0.25,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    const url =
                        'https://adamyainnovations.com/pex/privacy-policy/';
                    launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView);
                  },
                  title: Text(
                    currentLanguage != "English" ? r"गोपनीयता नीति" : 'Privacy Policy',
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      letterSpacing: 0.25,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.help_center_outlined),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RequestSupport()));
                  },
                  title: Text(
                    currentLanguage != "English" ? r"समर्थन की मदद का अनुरोध करें" : 'Request help of support',
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      letterSpacing: 0.25,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showModalBottomSheet(
                        showDragHandle: true,
                        context: context,
                        backgroundColor: Colors.white,
                        builder: (BuildContext context) {
                          return FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    currentLanguage != "English" ? r"यह आपको लॉग आउट कर देगा! जारी रखें?" : 'This will log you out! Are you sure?',
                                    style: const TextStyle(
                                      color: Color(0xFF212121),
                                      fontSize: 20,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 1.43,
                                      letterSpacing: 0.25,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      auth.signOut();
                                      var snackBar = SnackBar(
                                        content:
                                        Text(
                                            currentLanguage != "English" ? r"सफलतापूर्वक लॉग आउट हो गया!" : 'Logged out successfully!'
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const AuthPage()));
                                    },
                                    child: Text(
                                      currentLanguage != "English" ? r"हाँ, मुझे लॉग आउट करें!" : 'Yes, Log me out!',
                                      style: const TextStyle(
                                        color: Color(0xFF212121),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 1.43,
                                        letterSpacing: 0.25,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7.5,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      currentLanguage != "English" ? r"नहीं, रद्द करें" : 'No, Cancel',
                                      style: const TextStyle(
                                        color: Color(0xFF212121),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 1.43,
                                        letterSpacing: 0.25,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  title: Text(
                    currentLanguage != "English" ? r"लॉग आउट" : 'Logout',
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      letterSpacing: 0.25,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
}
