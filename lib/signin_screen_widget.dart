import 'package:flutter/material.dart';

class SigninScreenWidgets extends StatelessWidget {
  const SigninScreenWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to Memorisely',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Enter your details to sign in',
            style: TextStyle(
                color: Colors.white
                    .withOpacity(0.75),
                fontSize: 16),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white
                    .withOpacity(0.15),
                borderRadius:
                    BorderRadius.circular(8),
                border: Border.all(
                    color: Colors.white)),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white
                    .withOpacity(0.15),
                borderRadius:
                    BorderRadius.circular(8),
                border: Border.all(
                    color: Colors.white)),
          ),
          const SizedBox(height: 20),
          Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold),
                ),
              ))
        ]);
  }
}