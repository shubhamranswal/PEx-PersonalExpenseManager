import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pex/user%20dashboard/dashboard.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../assets/images.dart';
import '../utils/local_variables.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String phoneNumber = "+91";
  bool isNumberValid = false;
  String otp = '';
  TextEditingController nameController = TextEditingController();

  TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    if (kDebugMode) {
      print("Unregistered Listener");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(color: Colors.white),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(50),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: logoWithoutPadding,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'PEx',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF424242),
                              fontSize: 30,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 1,
                              letterSpacing: 0.25,
                            ),
                          ),
                          const Text(
                            'Personal Expenses Manager',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: IntlPhoneField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9a-zA-Z]")),
                              ],
                              flagsButtonMargin:
                                  const EdgeInsets.only(left: 5, right: 5),
                              dropdownIconPosition: IconPosition.trailing,
                              decoration: const InputDecoration(
                                counterText: "",
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                              initialCountryCode: 'IN',
                              onChanged: (phone) {
                                setState(() {
                                  isNumberValid = false;
                                });
                                if (phone.isValidNumber()) {
                                  setState(() {
                                    isNumberValid = true;
                                    phoneNumber = phone.completeNumber;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 5),
                          IconButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              EasyLoading.show();
                              if (isNumberValid) {
                                await auth.verifyPhoneNumber(
                                  phoneNumber: phoneNumber,
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) {},
                                  verificationFailed:
                                      (FirebaseAuthException e) {
                                    EasyLoading.showToast(
                                        "Verification Failed! Try after some time.");
                                  },
                                  codeSent: (String verificationId,
                                      int? resendToken) {
                                    showModalBottomSheet(
                                        isDismissible: false,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          EasyLoading.dismiss();
                                          listenOTP();
                                          return WillPopScope(
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 25),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      const Text('Enter OTP',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF424242),
                                                            fontSize: 20,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            height: 1.20,
                                                            letterSpacing: 0.18,
                                                          )),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              'Sent to $phoneNumber',
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xFF424242),
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                height: 1.20,
                                                                letterSpacing:
                                                                    0.18,
                                                              )),
                                                          TextButton(
                                                              onPressed: () {
                                                                SmsAutoFill().unregisterListener();
                                                                Navigator.pop(
                                                                    context);
                                                                setState(() {
                                                                  isNumberValid = false;
                                                                });
                                                              },
                                                              child: const Text(
                                                                  "Change Number!"))
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 40.0),
                                                      PinFieldAutoFill(
                                                        controller: otpController,
                                                        inputFormatters: <TextInputFormatter>[
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  "[0-9a-zA-Z]")),
                                                        ],
                                                        currentCode: otp,
                                                        decoration: BoxLooseDecoration(
                                                            radius: const Radius
                                                                .circular(12),
                                                            strokeColorBuilder:
                                                                const FixedColorBuilder(
                                                                    Color(
                                                                        0xFF000000))),
                                                        codeLength: 6,
                                                        onCodeChanged: (code) {
                                                          setState(() {
                                                            otp =
                                                                code.toString();
                                                          });
                                                        },
                                                        onCodeSubmitted: (val) {
                                                          setState(() {
                                                            otp = val;
                                                          });
                                                        },
                                                      ),
                                                      const SizedBox(
                                                          height: 40.0),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2,
                                                        child: OutlinedButton(
                                                            onPressed:
                                                                () async {
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              if (otp.length ==
                                                                  6) {
                                                                try {
                                                                  EasyLoading
                                                                      .show();
                                                                  PhoneAuthCredential
                                                                      credential =
                                                                      PhoneAuthProvider.credential(
                                                                          verificationId:
                                                                              verificationId,
                                                                          smsCode:
                                                                              otp);
                                                                  auth
                                                                      .signInWithCredential(
                                                                          credential)
                                                                      .then(
                                                                          (value) {
                                                                    Navigator.pop(
                                                                        context);
                                                                    showModalBottomSheet(
                                                                        isDismissible:
                                                                            false,
                                                                        enableDrag:
                                                                            false,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return WillPopScope(
                                                                              child: SingleChildScrollView(
                                                                                  child: Container(
                                                                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                                                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                                  const SizedBox(
                                                                                    height: 20,
                                                                                  ),
                                                                                  const Text('Enter Name',
                                                                                      style: TextStyle(
                                                                                        color: Color(0xFF424242),
                                                                                        fontSize: 20,
                                                                                        fontFamily: 'Inter',
                                                                                        fontWeight: FontWeight.w700,
                                                                                        height: 1.20,
                                                                                        letterSpacing: 0.18,
                                                                                      )),
                                                                                  const SizedBox(height: 40.0),
                                                                                  TextField(
                                                                                    controller: nameController,
                                                                                    keyboardType: TextInputType.name,
                                                                                    decoration: InputDecoration(
                                                                                      labelText: 'Enter Your Name',
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
                                                                                  const SizedBox(height: 40.0),
                                                                                  SizedBox(
                                                                                    width: MediaQuery.of(context).size.width / 2,
                                                                                    child: OutlinedButton(
                                                                                      onPressed: () async {
                                                                                        FocusScope.of(context).unfocus();
                                                                                        EasyLoading.show();
                                                                                        if (nameController.text.toString().trim().isNotEmpty) {
                                                                                          auth.currentUser!.updateDisplayName(nameController.text.toString().trim()).then((value) {
                                                                                            EasyLoading.dismiss();
                                                                                            Navigator.pop(context);
                                                                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Dashboard()));
                                                                                          }).onError((error, stackTrace) {
                                                                                            EasyLoading.dismiss();
                                                                                            auth.signOut();
                                                                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Can't continue right now! Try again later.")));
                                                                                          });
                                                                                        }
                                                                                      },
                                                                                      child: const Text(
                                                                                        'Update Name',
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
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: MediaQuery.of(context).viewInsets.bottom,
                                                                                  )
                                                                                ]),
                                                                              )),
                                                                              onWillPop: () async {
                                                                                return false;
                                                                              });
                                                                        });
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    setState(() {
                                                                      otpController.clear();
                                                                    });
                                                                    EasyLoading
                                                                        .showToast(
                                                                            "Wrong OTP! Please try again");

                                                                  });
                                                                } on Exception catch (e) {
                                                                  EasyLoading
                                                                      .showToast(
                                                                          "Wrong OTP! Please try again");
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text("Wrong OTP! Please try again")));
                                                                  if (kDebugMode) {
                                                                    print(
                                                                        "Wrong OTP");
                                                                  }
                                                                }
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(const SnackBar(
                                                                        content:
                                                                            Text('Enter a valid OTP!')));
                                                              }
                                                            },
                                                            child: const Text(
                                                                'Submit')),
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              onWillPop: () async {
                                                return false;
                                              });
                                        });
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {},
                                );
                              } else {
                                EasyLoading.showToast(
                                    'Please enter a valid mobile number!');
                              }
                            },
                            icon: Container(
                              width: 40,
                              height: 40,
                              decoration: const ShapeDecoration(
                                color: Color(0xB1DEF1FF),
                                shape: OvalBorder(),
                              ),
                              child: const Icon(Icons.chevron_right),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Or you may',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF616161),
                        fontSize: 12,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 75),
                      child: const Divider(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 50),
                      child: OutlinedButton(
                        onPressed: () {
                          EasyLoading.show();
                          signInWithGoogle().then((value) {
                            EasyLoading.dismiss();
                            if (auth.currentUser == null) {
                              auth.signOut();
                              const snackBar = SnackBar(
                                content: Text(
                                    "Can't sign-in right now. Retry after some time."),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Dashboard()));
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Continue with',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: logoGoogle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }

  void listenOTP() async {
    await SmsAutoFill().listenForCode();
    if (kDebugMode) {
      print("OTP Listen is called");
    }
  }
}

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  return await auth.signInWithCredential(credential);
}
