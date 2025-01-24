import 'package:dio/dio.dart';
import 'package:eventiss/api/models/authenticated_user.dart';
import 'package:eventiss/api/services/user_service.dart';
import 'package:eventiss/pages/auth/recuperation.dart';
import 'package:eventiss/pages/auth/register.dart';
import 'package:eventiss/pages/bottomnav.dart';
import 'package:eventiss/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/util/utils.dart';


class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool isNavigating = false;
  UserService userService = UserService();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 5), () async {
      if (!isNavigating) {
        isNavigating = true;
        await checkLoginStatus(context);
        isNavigating = false;
      }
    });
  }

  loginUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      Map<String, dynamic> data = {
        'email': emailController.text,
        'password': passwordController.text
      };

      AuthenticatedUser user = await userService.login(data);
      final sharedPref = await SharedPreferences.getInstance();

      sharedPref.setString("token", user.token!);

      Fluttertoast.showToast(
          msg: "Utilisateur connecté avec succès",
          gravity: ToastGravity.TOP_RIGHT,
      );

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const bottomnav())
      );

    } on DioException catch (e) {
      if (e.response != null) {
        if(e.response?.statusCode == 404) {
          Fluttertoast.showToast(msg: "Le nom d'utilisateur ou le mot de passe est incorrect");
        }
        print(e.response?.statusCode);
        print(e.response?.data);
        Fluttertoast.showToast(msg: "Une erreur est survenue");
      } else {
        print("Not dio error ${e.requestOptions}");
        print("Not dio error ${e.message}");
        Fluttertoast.showToast(msg: "Une erreur est survenue");
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Image de fond
          Positioned.fill(
            child: Image.asset(
              'images/fond.png', // Remplacez par votre image
              fit: BoxFit.cover,
            ),
          ),
          // Contenu
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                // Logo
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'images/logo.png', // Remplacez par votre logo
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 32),
                        const Text(
                          'Connexion',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Champs de formulaire
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            label: Text("Email *"),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre email';
                            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
                              return 'Veuillez entrer un email valide';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            label: Text("Mot de passe *"),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre mot de passe';
                            }
                            final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)');
                            if (!regex.hasMatch(value)) {
                              return "Le mot de passe doit contenir au moins une minuscule, une majuscule et un chiffre.";
                            } else if(value.length < 6) {
                              return "Le mot de passe doit contenir au moins 6 caractères";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),
                        // Bouton Valider
                        ElevatedButton(
                          onPressed: () async {
                            if(formKey.currentState!.validate()) {
                              await loginUser();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFDFD1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: isLoading ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                          ) :
                          const Text(
                            'Valider',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Lien pour se connecter
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Vous n'avez pas de compte? ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'inscrivez-vous',
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => recup(),
                                  ),
                                );
                              },
                              child: Text(
                                'Mots de passe oublié ',
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),)

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
