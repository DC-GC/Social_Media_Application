import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_social_media_application_dcgc/Screens/HomePage.dart';
import 'package:project_social_media_application_dcgc/Screens/SignupPage.dart';
import 'package:http/http.dart';

// this is the first page the user will se once opening the application 
// this page tries to takes the users credentials uses a post request to check if the credentials are valid 
class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _Username = TextEditingController();
  final TextEditingController _Password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final url = "https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/login";

  //main method for logging in 
  void login() async{
    try{
          //here is the post request that will check is there is an account with the credentials the user provided
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
          // if the response was succesful 
          if (response.statusCode == 200) {

            print(responsedata);
            //   ScaffoldMessenger.of(this.context).showSnackBar(
            // const SnackBar(content: Text("Welcome")),
            // );
            String? username = _Username.text;

            //if the login was successful the application will move to the homepage 
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
      appBar: AppBar(title: Text('Login Page',),
      automaticallyImplyLeading: false,
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
                  'Login Page',
                  style: TextStyle(
                    fontWeight:FontWeight.bold, 
                      color: Colors.white, 
                        fontSize: 40),
                ),
                SizedBox(height: 10,),
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontWeight:FontWeight.bold, 
                      color: Colors.white, 
                        fontSize: 25),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20) ,
                  margin: EdgeInsets.only(top:20, ),
                  //here is the textfield where the user will input his/her username
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
                      // if the user did not input any username at all 
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
                  //here is the textfield where the user will input his/her password
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
                      //if the user did not input any password at all 
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
                  // here lies the login button 
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
                      Text('Do you want to create an account?',style: TextStyle(
                                                              color: Colors.white, 
                                                              fontSize: 14,
                                                              ),),
                      //if the user does not have an account then he/she can create an account by clicking the text button below
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