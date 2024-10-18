import 'package:firebase_auth/firebase_auth.dart';

import 'local_variables.dart';

var name = auth.currentUser!.displayName;
var email = auth.currentUser!.phoneNumber ?? auth.currentUser!.email;
var profileImageURL = auth.currentUser!.photoURL;