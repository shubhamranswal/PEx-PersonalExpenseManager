import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var currentCurrency = "";

var currentLanguage = "en";

FirebaseAuth auth = FirebaseAuth.instance;

FirebaseFirestore db = FirebaseFirestore.instance;