import 'package:flutter/material.dart';
// import 'package:school/home.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:school/newpassword.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Stack(
        children: [
          // Background with custom top-right and bottom-left border radius
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(150), // Smooth and curved
                  bottomLeft: Radius.circular(150), // Matches top-right radius
                ),
              ),
            ),
          ),
          // Content Area
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Enter OTP"),
                        // SizedBox(height: 20),
                        // // Phone Number Input
                        // TextField(
                        //   keyboardType: TextInputType.phone,
                        //   decoration: InputDecoration(
                        //     prefixIcon: Icon(Icons.phone),
                        //     labelText: 'Phone Number',
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 20.0),
                        OtpTextField(
                          mainAxisAlignment: MainAxisAlignment.start,
                          numberOfFields: 6,
                          borderColor: Colors.deepPurple,
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          showFieldAsBox: true,
                          onCodeChanged: (String code) {
                            // Handle validation or checks here if necessary
                          },
                          onSubmit: (String verificationCode) {
                            // Handle the submitted OTP here
                            print('Entered OTP: $verificationCode');
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(onPressed: () {}, child: const Text("Send Again")),

                        const SizedBox(height: 30),
                        // Sign-In Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Newpassword(),
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text(
                              "Verify",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Forgot Password
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                            },
                            child: const Text(
                              "Cancle",
                              style: TextStyle(color: Colors.deepPurple),
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
        ],
      ),
    );
  }
}
