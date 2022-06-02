import 'package:flutter/material.dart';
import 'package:project_social_media_application_dcgc/Screens/LoginPage.dart';
import 'package:http/http.dart';
import 'dart:convert';

class SignupPage extends StatefulWidget {
  
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _Username = TextEditingController();
  final TextEditingController _CreatePassword = TextEditingController();
  final TextEditingController _ConfirmPassword = TextEditingController();
  final TextEditingController _CreateFirstName = TextEditingController();
  final TextEditingController _CreateLastName = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void create_account() async{
    final url = "https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/user";
    final authorization = "Zxi!!YbZ4R9GmJJ!h5tJ9E5mghwo4mpBs@*!BLoT6MFLHdMfUA%";
    try{
          final response = await post(Uri.parse("$url"), 
          headers: <String, String>{
            "accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer $authorization",
          },
          body: jsonEncode({
                "username": _Username.text,
                "password": _CreatePassword.text,
                "firstName": _CreateFirstName.text,
                "lastName": _CreateLastName.text,
                }),
          );
          if (response.statusCode == 200) {
              print(response.body);
              ScaffoldMessenger.of(this.context).showSnackBar(
            const SnackBar(content: Text("Account Created")),
            );
          }
          } catch(err){

          }
    // print("${_Email.text}");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Signup Page'),
      ),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                Text(
                  'Signup Page',
                  style: TextStyle(
                    fontWeight:FontWeight.bold, 
                      color: Colors.white, 
                        fontSize: 40),
                ),
                SizedBox(height: 10,),
                Text(
                  'It wont take long',
                  style: TextStyle(
                    fontWeight:FontWeight.bold, 
                      color: Colors.white, 
                        fontSize: 25),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20) ,
                  margin: EdgeInsets.only(top:20, ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      prefixIcon: Icon(Icons.person_outline),
                      hintText: 'First Name',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _CreateFirstName,
                    validator: (value){
                      if (value != null && value.isNotEmpty ) {
                        return null;
                      }
                      return "Please enter something here :(";
                    },
                    
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      prefixIcon: Icon(Icons.person_outline),
                      hintText: 'Last Name',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _CreateLastName,
                    validator: (value){
                      if (value != null && value.isNotEmpty ) {
                        return null;
                      }
                      return "Please enter something here :(";
                    },
                  ),
                ),
                    ],
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20) ,
                //   margin: EdgeInsets.only(top:5, ),
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(30)),
                //         borderSide: BorderSide(color: Colors.transparent),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(30)),
                //         borderSide: BorderSide(color: Colors.blue),
                //       ),
                //       prefixIcon: Icon(Icons.person),
                //       hintText: 'Enter Username',
                //       fillColor: Colors.grey[200],
                //       filled: true,
                //     ),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20) ,
                  margin: EdgeInsets.only(top:5, ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Enter Username',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _Username,
                    validator: (value){
                      if (value != null && value.isNotEmpty ) {
                        return null;
                      }
                      return "Please enter something here :(";
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20) ,
                  margin: EdgeInsets.only(top:5, ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Enter Password',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _CreatePassword,
                    validator: (value){
                      if (value != null && value.isNotEmpty ) {
                        return null;
                      }
                      return "Please enter something here :(";
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20) ,
                  margin: EdgeInsets.only(top:5, ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Confirm Password',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _ConfirmPassword,
                    validator: (value){
                      if (value != null && value.isNotEmpty ) {
                        return null;
                      }
                      return "Please enter something here :(";
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(27),
                  
                  child: ElevatedButton(
                    child: Text('Create Account', 
                    style:TextStyle(color: Colors.white),
                    ),
                    onPressed: (){
                      if (_formKey.currentState!.validate() && _CreatePassword.text == _ConfirmPassword.text) {
                          print("ok");
                          create_account();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  // decoration: BoxDecoration(
                  //   color: Colors.blue,
                  //   borderRadius: BorderRadius.circular(30)
                  // ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account', style: TextStyle(
                                                              color: Colors.white, 
                                                              fontSize: 14,
                                                              ),),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage())); 
                        },
                        
                        child: const Text('Login here'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}