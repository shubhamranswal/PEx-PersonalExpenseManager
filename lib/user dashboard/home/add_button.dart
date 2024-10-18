import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pex/user%20dashboard/dashboard.dart';
import 'package:pex/utils/local_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({super.key});

  @override
  _AddRecordPageState createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  String selectedListingType = '';
  String selectedCategory = '';
  String selectedCategoryIcon = '';

  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        categories = prefs.getStringList('categories') ?? [];
      });
    });
  }

  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              elevation: 5,
              backgroundColor: const Color(0xC268B0E3),
              foregroundColor: const Color(0xC2153144),
              leading: IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Dashboard())),
              ),
              title: Text(
                currentLanguage != 'English'
                    ? r'रिकार्ड जोड़ें'
                    : 'Add Records',
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
            ),
            body: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                height: MediaQuery.of(context).size.height - kToolbarHeight,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          showDragHandle: true,
                          context: context,
                          builder: (BuildContext context) {
                            return FittedBox(
                                fit: BoxFit.fitHeight,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      ListTile(
                                        title: Text(
                                          currentLanguage != 'English'
                                              ? r'खर्चे'
                                              : 'Debit',
                                          textAlign: TextAlign.center,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            selectedListingType = 'Debit';
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      const Divider(),
                                      ListTile(
                                        title: Text(
                                          currentLanguage != 'English'
                                              ? r'श्रेय'
                                              : 'Credit',
                                          textAlign: TextAlign.center,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            selectedListingType = 'Credit';
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      const Divider(),
                                      ListTile(
                                        title: Text(
                                          currentLanguage != 'English'
                                              ? r'ऋृण'
                                              : 'Debt',
                                          textAlign: TextAlign.center,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            selectedListingType = 'Debt';
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedListingType.isEmpty
                                  ? (currentLanguage != "English"
                                  ? r"प्रकार चुनें"
                                  : 'Select Type')
                                  : selectedListingType,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff464444),
                                height: 19 / 16,
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Visibility(
                        visible: selectedListingType == 'Debit' ||
                            selectedListingType == 'Debt',
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  showDragHandle: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    if (categories.isEmpty) {
                                      return Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.4,
                                          padding: const EdgeInsets.all(30),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          child: Text(
                                            currentLanguage != "English"
                                                ? r"शून्य श्रेणियां मिलीं!"
                                            "\n"
                                                "कृपया पहले श्रेणियां जोड़ें!"
                                                : "Zero categories found!\nPlease add categories first!",
                                            textAlign: TextAlign.center,
                                            textScaleFactor: 1.45,
                                          ));
                                    } else {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: categories.length,
                                        itemBuilder: (context, index) {
                                          var value = categories[index]
                                              .toString()
                                              .split("----");
                                          var icon = value[0];
                                          icon = icon.substring(
                                              1, icon.length - 1);

                                          var finalIconCode = int.parse(icon);
                                          var finalIcon = String.fromCharCode(
                                              finalIconCode);

                                          var name = value[1];

                                          return ListTile(
                                              onTap: () {
                                                setState(() {
                                                  selectedCategory = name;
                                                  selectedCategoryIcon =
                                                      finalIcon;
                                                });
                                                Navigator.pop(context);
                                              },
                                              title: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(finalIcon),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(child: Text(name, overflow: TextOverflow.ellipsis, maxLines: 1,)),
                                                ],
                                              ));
                                        },
                                      );
                                    }
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(child: Text(selectedCategory.isEmpty
                                        ? (currentLanguage != "English"
                                        ? r"श्रेणी चुनें"
                                        : 'Select Category')
                                        : selectedCategory,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff464444),
                                          height: 19 / 16,
                                        ), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                                    const Icon(Icons.keyboard_arrow_down),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        )),
                    Visibility(
                      visible: selectedListingType != '',
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]')),
                          ],
                          decoration: InputDecoration(
                            labelText: currentLanguage != "English"
                                ? r"राशि दर्ज करें"
                                : 'Enter Amount',
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
                        ),
                      ),
                    ),
                    Visibility(
                      visible: selectedListingType != '',
                      child: const SizedBox(height: 16),
                    ),
                    Visibility(
                      visible: selectedListingType != '',
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            labelText: currentLanguage != "English"
                                ? r"विवरण दर्ज करें"
                                : 'Enter Description',
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
                        ),
                      ),
                    ),
                    Visibility(
                      visible: selectedListingType != '',
                      child: Spacer(),
                    ),
                    Visibility(
                      visible: selectedListingType != '',
                      child: SizedBox(
                        height: 50,
                        child: FilledButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            validateInputs(
                                selectedListingType.toString().trim(),
                                selectedCategory.toString().trim(),
                                amountController.text.toString().trim(),
                                descriptionController.text.toString().trim());
                          },
                          child: Text(
                            currentLanguage != "English"
                                ? r"रिकॉर्ड जोड़ें"
                                : 'Add Record',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),)),
        onWillPop: () async {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Dashboard()));
          return false;
        });
  }

  Widget buildBottomSheetMenu(List<String> options, Function(String) onSelect) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: options.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: buildOptionTile(options[index], onSelect),
          );
        },
      ),
    );
  }

  Widget buildOptionTile(String title, Function(String) onSelect) {
    return GestureDetector(
      onTap: () {
        onSelect(title);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(25),
        ),
        child: ListTile(
          title: Text(title),
        ),
      ),
    );
  }

  void validateInputs(
      String type, String category, String amount, String description) {
    if (type.isEmpty) {
      EasyLoading.showToast(currentLanguage != "English"
          ? r"कृपया प्रकार चुनें!"
          : "Please select Type!");
    } else if ((type == 'Debt' || type == 'Debit') &&
        selectedCategory.isEmpty) {
      EasyLoading.showToast(currentLanguage != "English"
          ? r"कृपया एक कैटेगरी चयनित करें!"
          : "Please select a category!");
    } else if (amount.isEmpty) {
      EasyLoading.showToast(currentLanguage != "English"
          ? r"कृपया राशि दर्ज करें!"
          : "Please enter the amount!");
    } else if (description.isEmpty) {
      EasyLoading.showToast(currentLanguage != "English"
          ? r"कृपया विवरण दर्ज करें!"
          : "Please enter the description!");
    } else {
      EasyLoading.show();

      var typeName = type == 'Debt'
          ? "Debt"
          : type == 'Credit'
              ? "Credit"
              : "Debit";

      FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc(typeName)
          .set({
        'active': true,
      });

      FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc(typeName)
          .collection(
              DateTime.now().month.toString() + DateTime.now().year.toString())
          .doc(DateTime.now().toString())
          .set({
        'Type': type,
        'Category': category,
        'Amount': amount,
        'Description': description,
        'Icon': selectedCategoryIcon,
        'userDeleted': false,
        'id': DateTime.now().toString(),
        'creditReceived': false,
      }).then((value) {
        EasyLoading.dismiss();

        setState(() {
          selectedCategoryIcon = '';
          selectedCategory = '';
          selectedListingType = '';
        });
        amountController.clear();
        descriptionController.clear();

        final snackBar = SnackBar(
          content: Text(currentLanguage != "English"
              ? r"डेटा सफलतापूर्वक सहेजा गया!"
              : "Data saved successfully!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Dashboard()));
      }).catchError((error) {
        EasyLoading.dismiss();
        var snackBar = SnackBar(
          content: Text("Problem - ${error.message.toString()}"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }
}
