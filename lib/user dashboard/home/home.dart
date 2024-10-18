import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pex/utils/local_variables.dart';
import 'add_button.dart';
import '../../assets/images.dart';
import '../../utils/monthpicker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String monthAndYear =
      DateTime.now().month.toString() + DateTime.now().year.toString();

  late int sumDebit;
  late int sumCredit;
  late int sumDebt;

  var editForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    sumDebit = getData('Debit', monthAndYear);
    sumCredit = getData('Credit', monthAndYear);
    sumDebt = getData('Debt', monthAndYear);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              elevation: 5,
              backgroundColor: const Color(0xC268B0E3),
              foregroundColor: const Color(0xC268B0E3),
              title: Text(
                currentLanguage != 'English' ? r"PEx - होम" : 'PEx - Home',
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              elevation: 5,
              backgroundColor: const Color(0xC268B0E3),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddRecordPage()));
              },
              child: const Icon(
                Icons.add_circle,
                color: Colors.white,
              ),
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  kBottomNavigationBarHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HorizontalDatePicker(
                    onSelected: (DateTime time) {
                      var year = time.year;
                      var month = time.month;
                      setState(() {
                        monthAndYear = month.toString() + year.toString();
                      });
                      sumDebit = getData('Debit', monthAndYear);
                      sumCredit = getData('Credit', monthAndYear);
                      sumDebt = getData('Debt', monthAndYear);
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
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Text(
                                    '$currentCurrency$sumDebit',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFFE53935),
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 1.14,
                                      letterSpacing: 0.75,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    currentLanguage != 'English'
                                        ? r'खर्चे'
                                        : 'Debit',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF616161),
                                      fontSize: 12,
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
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Text(
                                    '$currentCurrency$sumCredit',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF00897B),
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 1.14,
                                      letterSpacing: 0.75,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    currentLanguage != 'English'
                                        ? r'श्रेय'
                                        : 'Credit',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF616161),
                                      fontSize: 12,
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
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Text(
                                    '$currentCurrency$sumDebt',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF616161),
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 1.14,
                                      letterSpacing: 0.75,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    currentLanguage != 'English'
                                        ? r'ऋृण'
                                        : 'Debt',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF616161),
                                      fontSize: 12,
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
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot doc =
                                      snapshot.data!.docs[index];
                                  var year = doc.id.substring(0, 4);
                                  var month = doc.id.substring(5, 7);
                                  var day = doc.id.substring(8, 10);
                                  var date = "$day-$month-$year";

                                  return ExpansionTile(
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xB1DEF1FF),
                                        shape: BoxShape.circle,
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(doc['Icon']),
                                      ),
                                    ),
                                    title: Text(doc['Description']),
                                    subtitle: Text(
                                      doc['Category'],
                                      style: const TextStyle(
                                        color: Color(0xFF616161),
                                      ),
                                    ),
                                    trailing: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          date,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 1.43,
                                            letterSpacing: 0.25,
                                          ),
                                        ),
                                        Text(
                                          '- $currentCurrency${doc['Amount']}',
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
                                    ),
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2) -
                                                25,
                                            height: 40,
                                            margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF64B461),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                showEditBottomSheet(
                                                    context,
                                                    doc,
                                                    db
                                                        .collection(auth
                                                            .currentUser!.uid
                                                            .toString())
                                                        .doc("Debit")
                                                        .collection(
                                                            monthAndYear));
                                              },
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2) -
                                                25,
                                            height: 40,
                                            margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFAD1A18),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () async {
                                                EasyLoading.show();
                                                await db
                                                    .collection(auth
                                                        .currentUser!.uid
                                                        .toString())
                                                    .doc("Debit")
                                                    .collection(monthAndYear)
                                                    .doc(doc.id)
                                                    .update(
                                                        {"userDeleted": true});
                                                sumDebit = getData(
                                                    'Debit', monthAndYear);
                                                EasyLoading.dismiss();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Deleted Successfully.")));
                                              },
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: Text(currentLanguage != 'English'
                                    ? r"कोई रिकॉर्ड नहीं मिला"
                                    : "No records found!"),
                              );
                            }
                          } else {
                            return Center(
                              child: Text(currentLanguage != 'English'
                                  ? r"कोई रिकॉर्ड नहीं मिला"
                                  : "No records found!"),
                            );
                          }
                        },
                      ),
                      DefaultTabController(
                        length: 2,
                        child: Scaffold(
                            body: Column(
                          children: [
                            SizedBox(
                              height: 50,
                              child: AppBar(
                                leading: null,
                                title: null,
                                bottom: TabBar(
                                  tabs: [
                                    Container(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          currentLanguage != 'English'
                                              ? r"प्राप्त किया जाना है"
                                              : 'To be Received',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color(0xFF616161),
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 1.33,
                                            letterSpacing: 0.40,
                                          ),
                                        )),
                                    Container(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          currentLanguage != 'English'
                                              ? r"प्राप्त"
                                              : 'Received',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Color(0xFF616161),
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 1.33,
                                            letterSpacing: 0.40,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                child: TabBarView(
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                  stream: db
                                      .collection(
                                          auth.currentUser!.uid.toString())
                                      .doc("Credit")
                                      .collection(monthAndYear)
                                      .where("userDeleted", isEqualTo: false)
                                      .where("creditReceived", isEqualTo: false)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data!.docs.isNotEmpty) {
                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              DocumentSnapshot doc =
                                                  snapshot.data!.docs[index];
                                              var year = doc.id.substring(0, 4);
                                              var month =
                                                  doc.id.substring(5, 7);
                                              var day = doc.id.substring(8, 10);
                                              var date = "$day-$month-$year";
                                              return ExpansionTile(
                                                leading: Container(
                                                  width: 40,
                                                  height: 40,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xB1DEF1FF),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: Icon(
                                                        Icons.arrow_drop_down),
                                                  ),
                                                ),
                                                title: Text(doc['Description']),
                                                trailing: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      date,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.43,
                                                        letterSpacing: 0.25,
                                                      ),
                                                    ),
                                                    Text(
                                                      '- $currentCurrency${doc['Amount']}',
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF398C08),
                                                        fontSize: 14,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.43,
                                                        letterSpacing: 0.25,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3) -
                                                            25,
                                                        height: 40,
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xFF64B461),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: IconButton(
                                                          icon: const Icon(
                                                              Icons.edit),
                                                          onPressed: () {
                                                            showEditBottomSheet(
                                                                context,
                                                                doc,
                                                                db
                                                                    .collection(auth
                                                                        .currentUser!
                                                                        .uid
                                                                        .toString())
                                                                    .doc(
                                                                        "Credit")
                                                                    .collection(
                                                                        monthAndYear));
                                                          },
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3) -
                                                            25,
                                                        height: 40,
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xC2E5E5E5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: IconButton(
                                                          icon: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const Icon(Icons
                                                                  .payment_outlined),
                                                              const SizedBox(
                                                                width: 2,
                                                              ),
                                                              Text(currentLanguage !=
                                                                      'English'
                                                                  ? r"प्राप्त"
                                                                  : "Received"),
                                                            ],
                                                          ),
                                                          onPressed: () {
                                                            EasyLoading.show();
                                                            db
                                                                .collection(auth
                                                                    .currentUser!
                                                                    .uid
                                                                    .toString())
                                                                .doc("Credit")
                                                                .collection(
                                                                    monthAndYear)
                                                                .doc(doc.id)
                                                                .update({
                                                              'creditReceived':
                                                                  true,
                                                            }).then((value) {
                                                              EasyLoading
                                                                  .dismiss();
                                                              sumCredit = getData(
                                                                  'Credit',
                                                                  monthAndYear);
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(SnackBar(
                                                                      content: Text(currentLanguage !=
                                                                              'English'
                                                                          ? r"प्राप्त के रूप में चिह्नित"
                                                                          : "Marked as received.")));
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3) -
                                                            25,
                                                        height: 40,
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xFFAD1A18),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: IconButton(
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          onPressed: () async {
                                                            EasyLoading.show();
                                                            await db
                                                                .collection(auth
                                                                    .currentUser!
                                                                    .uid
                                                                    .toString())
                                                                .doc("Credit")
                                                                .collection(
                                                                    monthAndYear)
                                                                .doc(doc.id)
                                                                .update({
                                                              "userDeleted":
                                                                  true
                                                            });
                                                            EasyLoading
                                                                .dismiss();
                                                            sumCredit = getData(
                                                                'Credit',
                                                                monthAndYear);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                                        content:
                                                                            Text("Deleted successfully.")));
                                                          },
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              );
                                            });
                                      } else {
                                        return Center(
                                          child: Text(
                                              currentLanguage != 'English'
                                                  ? r"कोई रिकॉर्ड नहीं मिला"
                                                  : "No records found!"),
                                        );
                                      }
                                    } else {
                                      return Center(
                                        child: Text(currentLanguage != 'English'
                                            ? r"कोई रिकॉर्ड नहीं मिला"
                                            : "No records found!"),
                                      );
                                    }
                                  },
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: db
                                      .collection(
                                          auth.currentUser!.uid.toString())
                                      .doc("Credit")
                                      .collection(monthAndYear)
                                      .where("userDeleted", isEqualTo: false)
                                      .where("creditReceived", isEqualTo: true)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data!.docs.isNotEmpty) {
                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              DocumentSnapshot doc =
                                                  snapshot.data!.docs[index];
                                              var year = doc.id.substring(0, 4);
                                              var month =
                                                  doc.id.substring(5, 7);
                                              var day = doc.id.substring(8, 10);
                                              var date = "$day-$month-$year";
                                              return ExpansionTile(
                                                leading: Container(
                                                  width: 40,
                                                  height: 40,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xB1DEF1FF),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: Icon(
                                                        Icons.arrow_drop_down),
                                                  ),
                                                ),
                                                title: Text(doc['Description']),
                                                trailing: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      date,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.43,
                                                        letterSpacing: 0.25,
                                                      ),
                                                    ),
                                                    Text(
                                                      '- $currentCurrency${doc['Amount']}',
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF398C08),
                                                        fontSize: 14,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.43,
                                                        letterSpacing: 0.25,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3) -
                                                            25,
                                                        height: 40,
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xFF64B461),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: IconButton(
                                                          icon: const Icon(
                                                              Icons.edit),
                                                          onPressed: () {
                                                            showEditBottomSheet(
                                                                context,
                                                                doc,
                                                                db
                                                                    .collection(auth
                                                                        .currentUser!
                                                                        .uid
                                                                        .toString())
                                                                    .doc(
                                                                        "Credit")
                                                                    .collection(
                                                                        monthAndYear));
                                                          },
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3) -
                                                            25,
                                                        height: 40,
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xC2E5E5E5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: IconButton(
                                                          icon: const Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(Icons
                                                                  .payment_outlined),
                                                              SizedBox(
                                                                width: 2,
                                                              ),
                                                              Text("Pending"),
                                                            ],
                                                          ),
                                                          onPressed: () {
                                                            EasyLoading.show();
                                                            db
                                                                .collection(auth
                                                                    .currentUser!
                                                                    .uid
                                                                    .toString())
                                                                .doc("Credit")
                                                                .collection(
                                                                    monthAndYear)
                                                                .doc(doc.id)
                                                                .update({
                                                              'creditReceived':
                                                                  false,
                                                            }).then((value) {
                                                              EasyLoading
                                                                  .dismiss();
                                                              sumCredit = getData(
                                                                  'Credit',
                                                                  monthAndYear);
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(SnackBar(
                                                                      content: Text((currentLanguage !=
                                                                              'English'
                                                                          ? r"प्राप्त के रूप में चिह्नित"
                                                                          : "Marked as received."))));
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3) -
                                                            25,
                                                        height: 40,
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xFFAD1A18),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: IconButton(
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          onPressed: () async {
                                                            EasyLoading.show();
                                                            await db
                                                                .collection(auth
                                                                    .currentUser!
                                                                    .uid
                                                                    .toString())
                                                                .doc("Credit")
                                                                .collection(
                                                                    monthAndYear)
                                                                .doc(doc.id)
                                                                .update({
                                                              "userDeleted":
                                                                  true
                                                            });
                                                            EasyLoading
                                                                .dismiss();
                                                            sumCredit = getData(
                                                                'Credit',
                                                                monthAndYear);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                                        content:
                                                                            Text("Deleted successfully.")));
                                                          },
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              );
                                            });
                                      } else {
                                        return Center(
                                          child: Text(
                                              currentLanguage != 'English'
                                                  ? r"कोई रिकॉर्ड नहीं मिला"
                                                  : "No records found!"),
                                        );
                                      }
                                    } else {
                                      return Center(
                                        child: Text(currentLanguage != 'English'
                                            ? r"कोई रिकॉर्ड नहीं मिला"
                                            : "No records found!"),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ))
                          ],
                        )),
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
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot doc =
                                        snapshot.data!.docs[index];
                                    var year = doc.id.substring(0, 4);
                                    var month = doc.id.substring(5, 7);
                                    var day = doc.id.substring(8, 10);
                                    var date = "$day-$month-$year";

                                    return ExpansionTile(
                                      leading: Container(
                                        width: 40,
                                        height: 40,
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: Color(0xB1DEF1FF),
                                          shape: BoxShape.circle,
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Text(doc['Icon']),
                                        ),
                                      ),
                                      title: Text(doc['Description']),
                                      subtitle: Text(
                                        doc['Category'],
                                        style: const TextStyle(
                                          color: Color(0xFF616161),
                                        ),
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            date,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              height: 1.43,
                                              letterSpacing: 0.25,
                                            ),
                                          ),
                                          Text(
                                            '- $currentCurrency${doc['Amount']}',
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
                                      ),
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3) -
                                                  25,
                                              height: 40,
                                              margin: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF64B461),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: IconButton(
                                                icon: const Icon(Icons.edit),
                                                onPressed: () {
                                                  showEditBottomSheet(
                                                      context,
                                                      doc,
                                                      db
                                                          .collection(auth
                                                              .currentUser!.uid
                                                              .toString())
                                                          .doc("Debt")
                                                          .collection(
                                                              monthAndYear));
                                                },
                                                color: Colors.white,
                                              ),
                                            ),
                                            Container(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3) -
                                                  25,
                                              height: 40,
                                              margin: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: const Color(0xC2E5E5E5),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: IconButton(
                                                icon: const Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                        Icons.payment_outlined),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text("Paid"),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  EasyLoading.show();
                                                  db
                                                      .collection(auth
                                                          .currentUser!.uid
                                                          .toString())
                                                      .doc("Debit")
                                                      .collection(monthAndYear)
                                                      .doc(doc.id)
                                                      .set({
                                                    'Type': doc['Type'],
                                                    'Category': doc['Category'],
                                                    'Amount': doc['Amount'],
                                                    'Description':
                                                        doc['Description'],
                                                    'Icon': doc['Icon'],
                                                    'userDeleted':
                                                        doc['userDeleted'],
                                                    'id': doc['id'],
                                                  }).then((value) {
                                                    db
                                                        .collection(auth
                                                            .currentUser!.uid
                                                            .toString())
                                                        .doc("Debt")
                                                        .collection(
                                                            monthAndYear)
                                                        .doc(doc.id)
                                                        .delete()
                                                        .then((value) {
                                                      EasyLoading.dismiss();
                                                      sumDebit = getData(
                                                          'Debit',
                                                          monthAndYear);
                                                      sumDebt = getData(
                                                          'Debt', monthAndYear);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      "Marked as paid.")));
                                                    });
                                                  });
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3) -
                                                  25,
                                              height: 40,
                                              margin: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFAD1A18),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () async {
                                                  EasyLoading.show();
                                                  await db
                                                      .collection(auth
                                                          .currentUser!.uid
                                                          .toString())
                                                      .doc("Debt")
                                                      .collection(monthAndYear)
                                                      .doc(doc.id)
                                                      .update({
                                                    "userDeleted": true
                                                  });
                                                  sumDebt = getData(
                                                      'Debt', monthAndYear);
                                                  EasyLoading.dismiss();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "Deleted Successfully.")));
                                                },
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              return Center(
                                child: Text(currentLanguage != 'English'
                                    ? r"कोई रिकॉर्ड नहीं मिला"
                                    : "No records found!"),
                              );
                            }
                          } else {
                            return Center(
                              child: Text(currentLanguage != 'English'
                                  ? r"कोई रिकॉर्ड नहीं मिला"
                                  : "No records found!"),
                            );
                          }
                        },
                      ),
                    ],
                  )),
                ],
              ),
            )));
  }

  int getData(String type, String monthAndYear) {
    int sum = 0;
    db
        .collection(auth.currentUser!.uid.toString())
        .doc(type)
        .collection(monthAndYear)
        .where("userDeleted", isEqualTo: false)
        .get()
        .then(
      (value) {
        if(value.size == 0){
          setState(() {
            if (type == 'Debit') {
              sumDebit = sum;
            } else if (type == 'Debt') {
              sumDebt = sum;
            } else {
              sumCredit = sum;
            }
          });
          return sum;
        }
        for (var element in value.docs) {
          if (type != 'Credit') {
            sum = sum + int.parse(element.data()['Amount']);
          } else {
            if (element.data()['creditReceived'] == false) {
              sum = sum + int.parse(element.data()['Amount']);
            }
          }
          setState(() {
            if (type == 'Debit') {
              sumDebit = sum;
            } else if (type == 'Debt') {
              sumDebt = sum;
            } else {
              sumCredit = sum;
            }
          });
        }
      },
    );
    return sum;
  }

  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  void showEditBottomSheet(BuildContext context, DocumentSnapshot<Object?> doc,
      CollectionReference<Map<String, dynamic>> collection) {
    descriptionController.text = doc['Description'].toString();
    amountController.text = doc['Amount'].toString();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding:
              const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Form(
                    key: editForm,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                labelStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff464444),
                                  height: 19 / 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter some description!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: amountController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter an amount!";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Amount',
                                labelStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff464444),
                                  height: 19 / 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: OutlinedButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (editForm.currentState!.validate()) {
                        EasyLoading.show();
                        collection.doc(doc.id).update({
                          'Amount': amountController.text.toString().trim(),
                          'Description':
                              descriptionController.text.toString().trim(),
                        }).then((value) => EasyLoading.dismiss());
                        Navigator.of(context).pop();
                        sumDebit = getData('Debit', monthAndYear);
                        sumCredit = getData('Credit', monthAndYear);
                        sumDebt = getData('Debt', monthAndYear);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Updated Successfully.")));
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
