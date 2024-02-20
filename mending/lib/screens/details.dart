// screen to accept user data successfully passing otp.screen
// data to be accepted:
// firstname: one word string: The user's first name
// lastname: one word string: The user's last name
// email: email string: The user's email
// age: integer : The user's age
// weight: double/float: The user's weight in kgs
// height: double/float: the user's height in cms
// gender: string: The user's gender (M/F)
// medical history: The user's medical history, surgery information, why rehab required
// profession: The user's profession to estimate previous usual activity level
// for each data input, give a short description of the data to be entered, make sure data is the same type as specified above
// at the top specify "Just a few more information to get you started with your rehab."
// make the form scrollable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController medicalHistoryController =
      TextEditingController();
  final TextEditingController professionController = TextEditingController();

  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rehab Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Just a few more information to get you started with your rehab.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFA0A0A0),
                ),
              ),
              const SizedBox(height: 20),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: firstnameController,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          hintText: 'Enter your first name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          // one word only
                          if (value.split(' ').length > 1) {
                            return 'Please enter only one word';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: lastnameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          hintText: 'Enter your last name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          // one word only
                          if (value.split(' ').length > 1) {
                            return 'Please enter only one word';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: ageController,
                        decoration: const InputDecoration(
                          labelText: 'Age',
                          hintText: 'Enter your age',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your age';
                          }
                          // number only
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: weightController,
                        decoration: const InputDecoration(
                          labelText: 'Weight',
                          hintText: 'Enter your weight in kgs',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your weight';
                          }
                          // number only
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: heightController,
                        decoration: const InputDecoration(
                          labelText: 'Height',
                          hintText: 'Enter your height in cms',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your height';
                          }
                          // number only
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: genderController,
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          hintText:
                              'Enter your gender (Male/Female/Other/Prefer not to say)',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: medicalHistoryController,
                        decoration: const InputDecoration(
                          labelText: 'Medical History',
                          hintText: 'Enter your medical history',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: professionController,
                        decoration: const InputDecoration(
                          labelText: 'Profession',
                          hintText: 'Enter your profession',
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .set({
                      'firstname': firstnameController.text,
                      'lastname': lastnameController.text,
                      'email': emailController.text,
                      'age': int.tryParse(ageController.text),
                      'weight': double.tryParse(weightController.text),
                      'height': double.tryParse(heightController.text),
                      'gender': genderController.text,
                      'medical_history': medicalHistoryController.text,
                      'profession': professionController.text,
                    }).then((value) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    }).catchError((error) {
                      setState(() {
                        // display error as snack message
                        errorMessage = 'Unknown Error';

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(errorMessage),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      });
                      return null;
                    });
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
