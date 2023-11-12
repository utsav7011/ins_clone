import 'dart:typed_data';
import 'package:ins_clone/screens/login_screen.dart';
import 'package:ins_clone/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ins_clone/resources/auth_method.dart';
import 'package:ins_clone/utils/colors.dart';
import 'package:ins_clone/utils/utils.dart';
import 'package:ins_clone/widgets/text_field_input.dart';

import '../responses/mobile_screen_layout.dart';
import '../responses/responses_layout_screen.dart';
import '../responses/web_screen_layout.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void navigateToSignin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void selectImage() async {
    // pick the img
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signupUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            WebScreenLayout(),
            MobileScreenLayout(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 0,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // svg image
              Flexible(
                child: Container(),
                flex: 1,
              ),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: Colors.white,
                height: 64,
              ),
              const SizedBox(
                height: 14,
              ),

              // circular widget to show selected file:
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671142.jpg?size=626&ext=jpg&ga=GA1.1.1247027543.1699471371&semt=sph',
                          ),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 24,
              ),

              // teext field for username:
              TextFieldInput(
                _usernameController,
                'Enter Your username',
                false,
                TextInputType.text,
              ),

              // password
              const SizedBox(
                height: 24,
              ),

              // text feild for email
              TextFieldInput(
                _emailController,
                'Enter Your Email',
                false,
                TextInputType.emailAddress,
              ),

              // password
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                _passwordController,
                'Enter the Password',
                true,
                TextInputType.text,
              ),

              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                _bioController,
                'Enter Your Bio',
                false,
                TextInputType.text,
              ),

              // button
              const SizedBox(
                height: 24,
              ),

              InkWell(
                onTap: signUpUser,
                child: Container(
                  child: _isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text(
                          'Sign Up',
                        ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // trasition to passsword;
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Already have an account ? "),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  GestureDetector(
                    onTap: navigateToSignin,
                    child: Container(
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
