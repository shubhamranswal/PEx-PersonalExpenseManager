import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/local_variables.dart';
import 'add.dart';
import 'edit.dart';

class ManageCategory extends StatefulWidget {
  const ManageCategory({super.key});

  @override
  State<ManageCategory> createState() => _ManageCategoryState();
}

class _ManageCategoryState extends State<ManageCategory> {
  TextEditingController searchController = TextEditingController();
  List<String> categories = [];
  List<String> searchedValues = [];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        categories = prefs.getStringList('categories') ?? [];
        searchedValues = categories;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 50,
        child: FilledButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const AddCategory()));
          },
          child: Text(
            currentLanguage != "English" ? r"नई श्रेणी जोड़ें" : 'Add New Category',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: const Color(0xC268B0E3),
        foregroundColor: const Color(0xC2153144),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          currentLanguage != "English" ? r"श्रेणी व्यवस्थित करें" : 'Manage Categories',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: searchedValues.isEmpty,
              child: SizedBox(
                height: MediaQuery.of(context).size.width - kToolbarHeight,
                child: Center(
                    child:Text(
                          currentLanguage != "English" ? r"शून्य श्रेणियां मिलीं!""\n""कृपया पहले श्रेणियां जोड़ें!" :"Zero categories found!\nPlease add categories first!",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.45,
                )),
              )),
          Visibility(
            visible: searchedValues.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (searchedValue) {
                  setState(() {
                    searchedValues = categories
                        .where((item) => item
                            .toLowerCase()
                            .contains(searchedValue.toLowerCase()))
                        .toList();
                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                    labelText: currentLanguage != "English" ? r"खोज" : "Search",
                    hintText: currentLanguage != "English" ? r"खोज" : "Search",
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: searchedValues.length,
              itemBuilder: (context, index) {

                var value = searchedValues[index].toString().split("----");
                var icon = value[0];
                icon = icon.substring(1, icon.length - 1);

                var finalIconCode = int.parse(icon);
                var finalIcon = String.fromCharCode(finalIconCode);

                var name = value[1];

                return ListTile(
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => EditCategory(
                                icon: finalIcon,
                                name: name,
                                previousItem: searchedValues[index]
                            )));
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
            ),
          ),
          const SizedBox(height: kBottomNavigationBarHeight,)
        ],
      ),
    );
  }
}
