import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../assets/images.dart';
import '../utils/local_variables.dart';
import '../utils/monthpicker.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  String monthAndYear =
      DateTime.now().month.toString() + DateTime.now().year.toString();

  Map<String, double> mapDebit = {};
  Map<String, double> mapDebt = {};

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 5,
            backgroundColor: const Color(0xC268B0E3),
            foregroundColor: const Color(0xC268B0E3),
            title: Text(
              currentLanguage != 'English' ? r'PEx - रिपोर्ट': 'PEx - Reports',
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HorizontalDatePicker(
                onSelected: (DateTime time) {
                  var year = time.year;
                  var month = time.month;
                  setState(() {
                    monthAndYear = month.toString() + year.toString();
                  });
                },
                onSubmitted: (DateTime time) {
                  if (kDebugMode) {
                    print(time);
                  }
                },
              ),
              SizedBox(
                height: 50,
                child: AppBar(
                  leading: null,
                  title: null,
                  bottom: TabBar(
                    tabs: [
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Text(
                                currentLanguage != 'English' ? r'खर्चे':'Debit',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF616161),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 1.33,
                                  letterSpacing: 0.40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Text(
                                currentLanguage != 'English' ? r'ऋृण':'Debt',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF616161),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 1.33,
                                  letterSpacing: 0.40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: TabBarView(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: db
                        .collection(auth.currentUser!.uid.toString())
                        .doc("Debit")
                        .collection(monthAndYear)
                        .where("userDeleted", isEqualTo: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          var docs = snapshot.data!.docs;
                          List categories = [];
                          List sum = [];
                          List icon = [];
                          for (var doc in docs) {
                            if (categories.contains(doc['Category'])) {
                              var index = categories.indexOf(doc['Category']);
                              sum[index] =
                                  sum[index] + double.parse(doc['Amount']);
                            } else {
                              categories.add(doc['Category']);
                              sum.add(double.parse(doc['Amount']));
                              icon.add(doc['Icon']);
                            }
                          }
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                var category = categories[index];
                                var categoryIcon = icon[index];
                                var sumOfCategory = sum[index];

                                mapDebit[category] = sumOfCategory;

                                return Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.7,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: const ShapeDecoration(
                                                color: Color(0xB1DEF1FF),
                                                shape: OvalBorder(),
                                              ),
                                              child: Center(
                                                  child: Text(categoryIcon)),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: Text(
                                                category,
                                                overflow: TextOverflow.ellipsis,
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
                                      ),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '- $currentCurrency$sumOfCategory',
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                              color: Color(0xFFE53935),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              height: 1.43,
                                              letterSpacing: 0.25,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              });
                        } else {
                          return  Center(
                            child: Text(currentLanguage != 'English' ? r"डाटा प्राप्त नहीं हुआ!":"No data found!"),
                          );
                        }
                      } else {
                        return  Center(
                          child: Text(currentLanguage != 'English' ? r"डाटा प्राप्त नहीं हुआ!":"No data found!"),
                        );
                      }
                    },
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: db
                        .collection(auth.currentUser!.uid.toString())
                        .doc("Debt")
                        .collection(monthAndYear)
                        .where("userDeleted", isEqualTo: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          var docs = snapshot.data!.docs;
                          List categories = [];
                          List sum = [];
                          List icon = [];
                          for (var doc in docs) {
                            if (categories.contains(doc['Category'])) {
                              var index = categories.indexOf(doc['Category']);
                              sum[index] =
                                  sum[index] + double.parse(doc['Amount']);
                            } else {
                              categories.add(doc['Category']);
                              sum.add(double.parse(doc['Amount']));
                              icon.add(doc['Icon']);
                            }
                          }
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                var category = categories[index];
                                var categoryIcon = icon[index];
                                var sumOfCategory = sum[index];

                                mapDebt[category] = sumOfCategory;
                                return Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.7,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: const ShapeDecoration(
                                                color: Color(0xB1DEF1FF),
                                                shape: OvalBorder(),
                                              ),
                                              child: Center(
                                                  child: Text(categoryIcon)),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: Text(
                                                category,
                                                overflow: TextOverflow.ellipsis,
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
                                      ),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '- $currentCurrency$sumOfCategory',
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                              color: Color(0xFFE53935),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              height: 1.43,
                                              letterSpacing: 0.25,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              });
                        } else {
                          return  Center(
                            child: Text(currentLanguage != 'English' ? r"डाटा प्राप्त नहीं हुआ!":"No data found!"),
                          );
                        }
                      } else {
                        return  Center(
                          child: Text(currentLanguage != 'English' ? r"डाटा प्राप्त नहीं हुआ!":"No data found!"),
                        );
                      }
                    },
                  )
                ],
              )),
            ],
          ),
        ));
  }
}
