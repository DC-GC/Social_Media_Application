import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_social_media_application_dcgc/Screens/HomePage.dart';
import 'package:project_social_media_application_dcgc/Screens/LoginPage.dart';
import 'package:http/http.dart';
import 'dart:convert';


class UpdateProfilePage extends StatefulWidget {
  String? token;
  String? username;
  String? firstname;
  String? lastname;
  UpdateProfilePage(this.token, this.username, this.firstname, this.lastname);
  @override
  State<UpdateProfilePage> createState(){
    return _UpdateProfilePageState(this.token, this.username, this.firstname, this.lastname);
  }
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  String? token_authorization;
  String? username;
  String? firstname;
  String? lastname;
  _UpdateProfilePageState(this.token_authorization, this.username, this.firstname, this.lastname);
  final TextEditingController _NewFirstName = TextEditingController();
  final TextEditingController _NewLastName = TextEditingController();
  final TextEditingController _OldPassword = TextEditingController();
  final TextEditingController _NewPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void updateProfile() async{
    final url = "https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/user";
    try{
          final response = await put(Uri.parse("$url/$username"), 
          headers: <String, String>{
            "accept": "application/json",
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer $token_authorization",
          },
          body: jsonEncode({
                "oldPassword": _OldPassword.text,
                "newPassword": _NewPassword.text,
                "firstName": _NewFirstName.text == ""?firstname:_NewFirstName.text,
                "lastName": _NewLastName.text == ""?lastname:_NewLastName.text,
                }),
          );
          
          final responsedata = jsonDecode(response.body);
          print(responsedata);
          
          if (response.statusCode == 200) {
            
            //   ScaffoldMessenger.of(this.context).showSnackBar(
            // const SnackBar(content: Text("Welcome")),
            // );
            ScaffoldMessenger.of(this.context).showSnackBar(
            SnackBar(content: Text("Update successful !")),
            );
            _NewFirstName.clear();
            _NewLastName.clear();
            _NewPassword.clear();
            _OldPassword.clear();
            Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage())); 
          }else{
            
            ScaffoldMessenger.of(this.context).showSnackBar(
            SnackBar(content: Text("Update failed: " + responsedata["message"])),
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
                      color: Colors.black, 
                        fontSize: 40),
                ),
                SizedBox(height: 10,),
                Text(
                  'It wont take long',
                  style: TextStyle(
                    fontWeight:FontWeight.bold, 
                      color: Colors.black, 
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
                    enabled: false,
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
                      hintText: 'Your Old First Name Is ' + firstname!,
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    
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
                      hintText: 'Enter New First Name',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _NewFirstName,
                    
                  ),
                ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20) ,
                  margin: EdgeInsets.only(top:20, ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                  child: TextFormField(
                    enabled: false,
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
                      hintText: 'Your Old Last Name Is ' + lastname!,
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    
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
                      hintText: 'Enter New Last Name',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _NewLastName,
                  ),
                ),
                    ],
                  ),
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
                      
                      hintText: 'Enter Old Password',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _OldPassword,
                    validator: (value){
                      if(value == _NewPassword.text && value != ""){
                        return "Old Password and New Password are the same :(";
                      }else if(value!.length != value.trim().length ){
                          return "text field should not be filled with only spaces:(";
                      }
                      return null;
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
                      hintText: 'Enter New Password',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _NewPassword,
                    validator: (value){
                      if(value == _OldPassword.text && value != ""){
                        return "Old Password and New Password are the same :(";
                      }else if(value!.length != value.trim().length ){
                          return "text field should not be filled with only spaces:(";
                      }
                      return null;
                    },
                    
                  ),
                ),
                    ],
                  ),
                ),
                
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(27),
                  
                  child: ElevatedButton(
                    child: Text('Update Account', 
                    style:TextStyle(color: Colors.white),
                    ),
                    onPressed: (){
                     if (_formKey.currentState!.validate()) {
                        print("ok");
                        updateProfile();
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
                
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}