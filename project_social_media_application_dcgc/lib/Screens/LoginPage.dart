import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_social_media_application_dcgc/Screens/HomePage.dart';
import 'package:project_social_media_application_dcgc/Screens/SignupPage.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _Username = TextEditingController();
  final TextEditingController _Password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final url = "https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/login";
  void login() async{
    try{
          final response = await post(Uri.parse("$url"), 
          headers: <String, String>{
            "accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
            // "Authorization": "Bearer $url",
          },
          body: jsonEncode({
                "username": _Username.text,
                "password": _Password.text,
                }),
          );
          
          final responsedata = jsonDecode(response.body);
          if (response.statusCode == 200) {
            print(responsedata);
            //   ScaffoldMessenger.of(this.context).showSnackBar(
            // const SnackBar(content: Text("Welcome")),
            // );
            String? username = _Username.text;
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(responsedata["data"]["token"], username)));
            _Username.clear();
            _Password.clear();
          }
          } catch(err){

          }
    // print("${_Email.text}");
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
      appBar: AppBar(title: Text('Login Page'),
      automaticallyImplyLeading: false,
      ),
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
                  'Login Page',
                  style: TextStyle(
                    fontWeight:FontWeight.bold, 
                      color: Colors.black, 
                        fontSize: 40),
                ),
                SizedBox(height: 10,),
                Text(
                  'Day 1',
                  style: TextStyle(
                    fontWeight:FontWeight.bold, 
                      color: Colors.black, 
                        fontSize: 25),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20) ,
                  margin: EdgeInsets.only(top:20, ),
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
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Username',
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
                  margin: EdgeInsets.only(top:10, ),
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
                      hintText: 'Password',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _Password,
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
                    child: Text('Login', 
                    style:TextStyle(color: Colors.white),
                    ),
                    onPressed: (){
                      
                      if (_formKey.currentState!.validate()) {
                        login();
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
                      Text('do you want to create an account?'),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>SignupPage())); 
                        },
                        child: const Text('Signup here'),
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
    ),);
  }
}