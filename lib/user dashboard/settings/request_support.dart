import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/local_variables.dart';

class RequestSupport extends StatefulWidget {
  @override
  _RequestSupportState createState() => _RequestSupportState();
}

class _RequestSupportState extends State<RequestSupport> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: const Color(0xC268B0E3),
          foregroundColor: const Color(0xC2153144),
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            currentLanguage != "English"
                ? r"सहायता के लिए संपर्क करें"
                : 'Contact Support',
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
        body: SizedBox(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: subjectController,
                      decoration: InputDecoration(
                          labelText: currentLanguage != "English"
                              ? r"विषय"
                              : 'Subject',
                          alignLabelWithHint: true,
                          border: const OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return currentLanguage != "English"
                              ? r"कृपया एक विषय दर्ज करें!"
                              : 'Please enter a subject!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        labelText:
                            currentLanguage != "English" ? r"संदेश" : 'Message',
                        alignLabelWithHint: true,
                        border: const OutlineInputBorder(),
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return currentLanguage != "English"
                              ? r"कृपया अपना संदेश लिखें"
                              : 'Please enter your message';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          var subject =
                              subjectController.text.toString().trim();
                          var message =
                              messageController.text.toString().trim();

                          final url =
                              'mailto:developer@adamyainnovations.com?cc=adilsidd32@gmail.com&subject=$subject&body=$message';
                          launchUrl(Uri.parse(url));
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        currentLanguage != "English"
                            ? r"मेसेज भेजें"
                            : 'Send Message',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
