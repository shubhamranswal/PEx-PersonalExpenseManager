import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/local_variables.dart';
import 'manage.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  String selectedEmoji = '🎉';
  TextEditingController categoryNameController = TextEditingController();

  void _showEmojiPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return EmojiPicker(
          onEmojiSelected: (Category? category, Emoji emoji) {
            setState(() {
              selectedEmoji = emoji.emoji;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            elevation: 5,
            backgroundColor: const Color(0xC268B0E3),
            foregroundColor: const Color(0xC2153144),
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ManageCategory())),
            ),
            title: Text(
              currentLanguage != "English" ? r"नई श्रेणी जोड़ें" :
              'Add new category',
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
          body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showEmojiPicker(context),
                        child: Center(
                          child: Text(
                            selectedEmoji,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: categoryNameController,
                            decoration: InputDecoration(
                              labelText: currentLanguage != "English" ? r"श्रेणी का नाम" : 'Category Name',
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
                    ],
                  ),
                  const Spacer(),
                  Center(
                    child: SizedBox(
                      height: 50,
                      child: FilledButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (categoryNameController.text
                              .toString()
                              .trim()
                              .isEmpty) {
                            EasyLoading.showToast(currentLanguage != "English" ? r"कृपया श्रेणी का नाम भरें!" : "Please fill category name!");
                          } else {
                            EasyLoading.show();
                            SharedPreferences.getInstance().then((prefs) {
                              var categories =
                                  prefs.getStringList("categories") ?? [];
                              var category = "${selectedEmoji.runes.toList()}----${categoryNameController.text.toString().trim()}";
                              categories.add(category);
                              prefs.setStringList("categories", categories);
                            });
                            EasyLoading.dismiss();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ManageCategory()));
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text(currentLanguage != "English" ? r"श्रेणी सफलतापूर्वक जोड़ी गई!" : 'Category added successfully!')));
                          }
                        },
                        child: Text(
                          currentLanguage != "English" ? r"श्रेणी जोड़ें" : 'Add Category',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        onWillPop: () async {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ManageCategory()));
          return false;
        });
  }
}
