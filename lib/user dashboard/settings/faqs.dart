import 'package:flutter/material.dart';

import '../../utils/local_variables.dart';

class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}

List<FAQ> generalFAQsEnglish = [
  FAQ(
    question: "What is this app used for?",
    answer:
    "This app is designed to help you manage your daily expenses, income, and debts. It allows you to track your financial transactions and maintain a clear overview of your financial situation.",
  ),
  FAQ(
    question: "How do I add a new expense or income entry?",
    answer:
    "To add a new expense or income entry, navigate to the respective section in the app and click on the 'Add' button. Enter the details such as amount, category, and description, and then save the entry.",
  ),
  FAQ(
    question: "Can I categorize my expenses and income?",
    answer:
    "Yes, you can categorize your expenses and income entries. The app provides predefined categories, and you can also create custom categories to organize your financial data efficiently.",
  ),
  FAQ(
    question: "How can I manage my debts using this app?",
    answer:
    "The app allows you to keep track of your debts. You can add information about the debtor, the amount owed, and the due date. The app will help you stay on top of your debt repayments.",
  ),
  FAQ(
    question: "Is my financial data secure in this app?",
    answer:
    "Yes, your financial data is secured using industry-standard encryption and security measures. Additionally, any user authentication and data storage processes are handled using secure protocols.",
  ),
  FAQ(
    question: "Can I access my data from different devices?",
    answer:
    "Yes, the app supports multi-device access. Your data is synchronized across devices as long as you're logged in with the same account. This ensures you can access your financial information from your phone, tablet, or computer.",
  ),
  FAQ(
    question: "Is there a way to analyze my spending patterns?",
    answer:
    "Yes, the app offers features to analyze your spending and income patterns. You can view graphical representations of your expenses, income, and savings over time.",
  ),
  FAQ(
    question: "How do I get support if I encounter issues?",
    answer:
    "If you encounter any issues or have questions, you can reach out to our support team through the 'Help' or 'Support' section in the app. You can also refer to the app's documentation for troubleshooting tips.",
  ),
  FAQ(
    question: "Does this app require an internet connection?",
    answer:
    "Some features of the app may require an internet connection to sync your data across devices. However, basic functionalities like adding and viewing entries can be performed offline.",
  ),
];

List<FAQ> generalFAQsHindi = [
  FAQ(
    question: "इस ऐप का उपयोग किसके लिए है?",
    answer:
    "यह ऐप आपको आपके दैनिक व्यय, आय, और ऋण का प्रबंधन करने में मदद करने के लिए डिज़ाइन किया गया है। इसकी अनुमति देता है कि आप अपने वित्तीय लेन-देन का परिचय रख सकें और अपनी वित्तीय स्थिति का स्पष्ट अवलोकन बनाए रख सकें।",
  ),
  FAQ(
    question: "मैं नया व्यय या आय एंट्री कैसे जोड़ सकता हूँ?",
    answer:
    "नई व्यय या आय एंट्री जोड़ने के लिए, ऐप के संबंधित खंड में जाएं और 'जोड़ें' बटन पर क्लिक करें। राशि, श्रेणी, और विवरण जैसे विवरण दर्ज करें, और फिर एंट्री को सहेजें।",
  ),
  FAQ(
    question: "क्या मैं अपने व्यय और आय को श्रेणित कर सकता हूँ?",
    answer:
    "हां, आप अपने व्यय और आय एंट्री को श्रेणित कर सकते हैं। ऐप पूर्वनिर्धारित श्रेणियाँ प्रदान करता है, और आप अपने वित्तीय डेटा को प्रबंधित करने के लिए कस्टम श्रेणियाँ भी बना सकते हैं।",
  ),
  FAQ(
    question: "मैं इस ऐप का उपयोग करके अपने कर्ज का प्रबंधन कैसे कर सकता हूँ?",
    answer:
    "ऐप आपको आपके कर्ज का प्रबंधन करने की अनुमति देता है। आप ऋणी के बारे में जानकारी, उनके द्वारा धन उधारी गई राशि, और निर्धारित तिथि के बारे में जानकारी जोड़ सकते हैं। ऐप आपको अपने कर्ज के चुकता होने पर बने रहने में मदद करेगा।",
  ),
  FAQ(
    question: "क्या मेरे वित्तीय डेटा इस ऐप में सुरक्षित है?",
    answer:
    "हां, आपके वित्तीय डेटा को औद्योगिक मानक एन्क्रिप्शन और सुरक्षा उपायों का उपयोग करके सुरक्षित रूप से संरक्षित किया गया है। इसके अलावा, किसी भी उपयोगकर्ता प्रमाणीकरण और डेटा संग्रहण प्रक्रियाएँ सुरक्षित प्रोटोकॉल का उपयोग करके प्रबंधित होती हैं।",
  ),
  FAQ(
    question: "क्या मैं अलग-अलग डिवाइस से अपने डेटा का उपयोग कर सकता हूँ?",
    answer:
    "हां, ऐप मल्टी-डिवाइस उपयोग का समर्थन करता है। आपके डेटा को उन डिवाइसों पर सिंक्रनाइज़ किया जाता है जब तक आप एक ही खाते से लॉग इन हैं। इससे यह सुनिश्चित होता है कि आप अपनी वित्तीय जानकारी को अपने फ़ोन, टैबलेट, या कंप्यूटर से एक्सेस कर सकते हैं।",
  ),
  FAQ(
    question: "क्या मेरे व्यय पैटर्न का विश्लेषण करने का एक तरीका है?",
    answer:
    "हां, ऐप आपके व्यय और आय पैटर्न का विश्लेषण करने के लिए सुविधाएँ प्रदान करता है। आप अपने व्यय, आय, और बचत को समय के साथ ग्राफ़िकल प्रतिनिधित्वों को देख सकते हैं।",
  ),
  FAQ(
    question: "यदि मुझे समस्याओं का सामना करना पड़ता है तो मुझे समर्थन कैसे प्राप्त होगा?",
    answer:
    "यदि आपको कोई समस्या आती है या सवाल होते हैं, तो आप ऐप में 'मदद' या 'समर्थन' खंड के माध्यम से हमारी समर्थन टीम से संपर्क कर सकते हैं। आप ट्रबलशूटिंग सुझावों के लिए ऐप की डॉक्यूमेंटेशन का भी संदर्भ कर सकते हैं।",
  ),
  FAQ(
    question: "क्या इस ऐप को इंटरनेट कनेक्शन की आवश्यकता है?",
    answer:
    "इस ऐप के कुछ फ़ीचर डेटा को डिवाइसों के बीच सिंक्रनाइज़ करने के लिए इंटरनेट कनेक्शन की आवश्यकता हो सकती है। हालांकि, वित्तीय एंट्री जोड़ने और देखने जैसे मूल फ़ंक्शन को ऑफ़लाइन किया जा सकता है।",
  ),
];


class FAQPage extends StatelessWidget {
  final List<FAQ> faqs;

  FAQPage({super.key, required this.faqs});

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
        title:  Text(currentLanguage != "English" ? r"पूछे जाने वाले प्रश्न"
          :'Frequently Asked Questions',
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
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(faqs[index].question,
              style: const TextStyle(
                color: Color(0xFF212121),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                height: 1.50,
                letterSpacing: 0.15,
              ),),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(faqs[index].answer,
                  style: const TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                    letterSpacing: 0.15,
                  ),),
              ),
            ],
          );
        },
      ),
    );
  }
}