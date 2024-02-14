import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpArguments {
  final String verificationId;
  final String phoneNumber;

  OtpArguments(this.verificationId, this.phoneNumber);
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as OtpArguments;
    final TextEditingController otpOneController = TextEditingController();
    final TextEditingController otpTwoController = TextEditingController();
    final TextEditingController otpThreeController = TextEditingController();
    final TextEditingController otpFourController = TextEditingController();
    final TextEditingController otpFiveController = TextEditingController();
    final TextEditingController otpSixController = TextEditingController();
    final FocusNode otpOneFocusNode = FocusNode();
    final FocusNode otpTwoFocusNode = FocusNode();
    final FocusNode otpThreeFocusNode = FocusNode();
    final FocusNode otpFourFocusNode = FocusNode();
    final FocusNode otpFiveFocusNode = FocusNode();
    final FocusNode otpSixFocusNode = FocusNode();

    // error message to display
    String errorMessage = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the 6-digit code sent to you at',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xFFA0A0A0),
              ),
            ),
            Text(
              args.phoneNumber,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 32,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: otpOneController,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    focusNode: otpOneFocusNode,
                    onChanged: (value) => {
                      if (value.length == 1)
                        {
                          otpTwoFocusNode.nextFocus(),
                        }
                    },
                    decoration: const InputDecoration(
                      counterText: '',
                    ),
                  ),
                ),
                SizedBox(
                  width: 32,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: otpTwoController,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    focusNode: otpTwoFocusNode,
                    onChanged: (value) => {
                      if (value.length == 1)
                        {
                          otpThreeFocusNode.nextFocus(),
                        }
                    },
                    decoration: const InputDecoration(
                      counterText: '',
                    ),
                  ),
                ),
                SizedBox(
                  width: 32,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: otpThreeController,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    focusNode: otpThreeFocusNode,
                    onChanged: (value) => {
                      if (value.length == 1)
                        {
                          otpFourFocusNode.nextFocus(),
                        }
                    },
                    decoration: const InputDecoration(
                      counterText: '',
                    ),
                  ),
                ),
                SizedBox(
                  width: 32,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: otpFourController,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    focusNode: otpFourFocusNode,
                    onChanged: (value) => {
                      if (value.length == 1)
                        {
                          otpFiveFocusNode.nextFocus(),
                        }
                    },
                    decoration: const InputDecoration(
                      counterText: '',
                    ),
                  ),
                ),
                SizedBox(
                  width: 32,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: otpFiveController,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    focusNode: otpFiveFocusNode,
                    onChanged: (value) => {
                      if (value.length == 1)
                        {
                          otpSixFocusNode.nextFocus(),
                        }
                    },
                    decoration: const InputDecoration(
                      counterText: '',
                    ),
                  ),
                ),
                SizedBox(
                  width: 32,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: otpSixController,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    focusNode: otpSixFocusNode,
                    onChanged: (value) => {
                      if (value.length == 1)
                        {
                          otpSixFocusNode.unfocus(),
                        }
                    },
                    decoration: const InputDecoration(
                      counterText: '',
                    ),
                  ),
                ),
              ],
            ),
            Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // combine all inputs into 4 digit number
                // send to firebase for verification
                String otp = otpOneController.text +
                    otpTwoController.text +
                    otpThreeController.text +
                    otpFourController.text +
                    otpFiveController.text +
                    otpSixController.text;
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: args.verificationId, smsCode: otp);
                FirebaseAuth.instance
                    .signInWithCredential(phoneAuthCredential)
                    .then((value) => Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false))
                    .catchError((error) {
                  setState(() {
                    errorMessage = 'Invalid OTP';
                  });
                  return null;
                });
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
