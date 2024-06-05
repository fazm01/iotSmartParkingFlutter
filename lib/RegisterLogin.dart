import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Dashboard.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController NameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController DOBController = TextEditingController();
  String Address = "-1";
  String Gender = "-1";
  bool _obscureText = true;
  final formKey = GlobalKey<FormState>();
  DatabaseReference dataBase = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 15),
            Image(
              image: AssetImage("images/logo5.png"),
              height: 230,
              width: 300,
              alignment: Alignment.center,
            ),
            Text(
              "Create a new account",
              style: GoogleFonts.robotoCondensed(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r"^\s*[A-Za-z]{3}[^\n\d]*$").hasMatch(value!)) {
                  return "Enter a valid name";
                } else {
                  return null;
                }
              },
              controller: NameController,
              decoration: InputDecoration(
                  hintText: 'Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 15),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!)) {
                  return "Enter a valid email";
                } else {
                  return null;
                }
              },
              controller: EmailController,
              decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 15),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter a password";
                } else if (!RegExp(r'^.{6,}').hasMatch(value!)) {
                  return "Password must at least be 6 characters in length";
                } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value!)) {
                  return "Password must contain at least one upper case letter";
                } else if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value!)) {
                  return "Password must contain at least one lower case letter";
                } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value!)) {
                  return "Password must contain at least one digit";
                } else if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value!)) {
                  return "Password must contain at least one special character";
                } else {
                  return null;
                }
              },
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              obscureText: _obscureText,
            ),
            SizedBox(height: 15),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter your birthdate";
                } else {
                  return null;
                }
              },
              controller: DOBController,
              decoration: InputDecoration(
                  labelText: "Date of birth",
                  hintText: "Insert your birthdate",
                  prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onTap: () async {
                DateTime date = DateTime(1900);
                FocusScope.of(context).requestFocus(new FocusNode());
                DateTime maxDate = DateTime(DateTime.now().year - 18,
                    DateTime.now().month, DateTime.now().day, 0, 0, 0);
                date = (await showDatePicker(
                    context: context,
                    initialDate: maxDate,
                    firstDate: DateTime(1900),
                    lastDate: maxDate))!;
                var format1 = "${date.day}-${date.month}-${date.year}";
                DOBController.text = format1;
              },
            ),
            SizedBox(height: 15),
            DropdownButtonFormField(
              validator: (value) {
                if (value == "-1") {
                  return "Enter your gender";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  hintText: 'Gender',
                  prefixIcon: Gender == '1'
                      ? Icon(Icons.male_rounded, color: Colors.blueAccent)
                      : Gender == '2'
                          ? Icon(Icons.female_rounded, color: Colors.pinkAccent)
                          : Icon(Icons.wc_rounded, color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              value: Gender,
              items: [
                DropdownMenuItem(child: Text("-Select Gender-"), value: "-1"),
                DropdownMenuItem(
                  child: Text("Male"),
                  value: "1",
                ),
                DropdownMenuItem(child: Text("Female"), value: "2"),
              ],
              onChanged: (value) {
                setState(() {
                  Gender = value!;
                });
              },
            ),
            SizedBox(height: 15),
            DropdownButtonFormField(
              validator: (value) {
                if (value == "-1") {
                  return "Select a valid address";
                }
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              value: Address,
              items: [
                DropdownMenuItem(child: Text("-Select Address-"), value: "-1"),
                DropdownMenuItem(child: Text("New Cairo"), value: "1"),
                DropdownMenuItem(child: Text("Heliopolis"), value: "2"),
              ],
              onChanged: (value) {
                setState(() {
                  Address = value!;
                });
              },
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  print("hello?");
                  String key = dataBase.child("Users").push().key!;
                  String GenderMap = " ";
                  String AddressMap = " ";
                  if (Gender == "1") {
                    GenderMap = "Male";
                  } else {
                    GenderMap = "Female";
                  }
                  if (Address == "1") {
                    AddressMap = "New Cairo";
                  }
                  else if (Address == "2") {
                    AddressMap = "Heliopolis";
                    }

                    print("hello?2");
                    Map newUser = {
                      "name": NameController.text.trim(),
                      "email": EmailController.text.trim(),
                      "password": passwordController.text.trim(),
                      "DOB": DOBController.text.trim(),
                      "Gender": GenderMap,
                      "id": key,
                      "Address": AddressMap,
                      "DueFees": 0,
                      "ParkingSpot": 0,
                    };

                    dataBase.child("Users").child(key).set(newUser);

                    NameController.clear();
                    EmailController.clear();
                    passwordController.clear();
                    DOBController.clear();
                    Gender = "-1";
                    Address = "-1";

                    Fluttertoast.showToast(
                        msg: "Account created successfully!");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }
                  setState(() {});
                },
                child: Container(
                height: 30,
                width: 180,
                child: Center(child: Text('SignUp')),
                ),
                ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text("Login here."))
              ],
            )
          ]),
        ),
      )),
    ));
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  bool _obscureText = true;
  final formKey = GlobalKey<FormState>();
  DatabaseReference dataBase = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Image(
                      image: AssetImage("images/logo5.png"),
                      height: 230,
                      width: 300,
                      alignment: Alignment.center,
                    ),
                    Text(
                      "Login to an existing account",
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!)) {
                          return "Enter a valid email";
                        } else {
                          return null;
                        }
                      },
                      controller: EmailController,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: PasswordController,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      obscureText: _obscureText,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter a password";
                        } else if (!RegExp(r'^.{6,}$').hasMatch(value!)) {
                          return "Password must be at least 6 characters in length";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          int ok = 0;
                          String uid = "";
                          dataBase
                              .child('Users/')
                              .get()
                              .then((DataSnapshot snapshot) {
                            var arr = snapshot.value;
                            Map? values = snapshot.value as Map?;
                            values?.forEach((k, v) {
                              if (v!["email"] == EmailController.text.trim() &&
                                  v!["password"] ==
                                      PasswordController.text.trim()) {
                                uid = v!["id"];
                                ok = 1;
                                print(EmailController.text.trim());
                                print(PasswordController.text.trim());
                                print(ok);
                              }
                            });
                            if (ok == 1) {
                              Fluttertoast.showToast(
                                  msg: "Logged in Successfully");
                              EmailController.clear();
                              PasswordController.clear();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard(arg1: uid)),
                              );
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Invalid email or password");
                            }
                          });
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 180,
                        child: Center(child: Text('Login')),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()),
                              );
                            },
                            child: Text("Register here."))
                      ],
                    )
                  ]),
            ),
          )),
        ));
  }
}
