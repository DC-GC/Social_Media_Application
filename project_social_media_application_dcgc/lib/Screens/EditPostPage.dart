import 'dart:html';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_social_media_application_dcgc/Screens/HomePage.dart';

class EditPostPage extends StatefulWidget {
  String? posttext;
  String? token;
  String? id;
  String? username;
  bool? public;
  EditPostPage(this.posttext, this.token, this.id,this.username, this.public);
  
  @override
  State<EditPostPage> createState(){
    return _EditPostPageState(this.posttext, this.token, this.id,this.username, this.public);
  }
}

class _EditPostPageState extends State<EditPostPage> {
  String? posttext;
  String? token_authorization;
  String? id;
  String? username;
  bool? public;
  _EditPostPageState(this.posttext, this.token_authorization, this.id, this.username, this.public);
  final TextEditingController _Editpost = TextEditingController();
  List<String> dropdownitems = ['Friends Only', 'Public'];
  String? selecteditem = 'Friends Only';

  void editPost() async{
    
    final url = "https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/post/";
    try{
          final response = await put(Uri.parse("$url$id"), 
          headers: <String, String>{
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token_authorization",
          },
          body: jsonEncode({
                "text": _Editpost.text,
                "public": selecteditem == 'Public'? true:false,
                }),
          );
          
          final responsedata = jsonDecode(response.body);
          print(responsedata);
          ScaffoldMessenger.of(this.context).showSnackBar(
            const SnackBar(content: Text("Post has been edited")),
          );
          } catch(err){

          }
    // print("${_Email.text}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Editpost.text = posttext!;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Edit Post"),
      ), // Text(token_authorization ?? 'no key provided')
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50,),
                Text(
                  'You can edit your post using the text field below',
                  style: TextStyle(
                    fontWeight:FontWeight.bold, 
                      color: Colors.white, 
                        fontSize: 40),
                ),
          SizedBox(height: 50,),
          Container(
                  padding: EdgeInsets.symmetric(horizontal: 20) ,
                  margin: EdgeInsets.only(top:10, ),
                  child: TextFormField(
                    maxLines: null,
                    minLines: 4,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      prefixIcon: Icon(Icons.edit),
                      hintText: 'You can write anything :-)',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _Editpost,
                    
                    
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                
                  //width: MediaQuery.of(context).size.width * 0.05,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    ElevatedButton(
                    
                    child: Text('Edit Post', 
                    style:TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    onPressed: (){
                       editPost();
                       Navigator.pop(context,MaterialPageRoute(builder: (context) => HomePage(token_authorization, username)));
                     
                      },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.1, MediaQuery.of(context).size.height * 0.075,),
                    ),

                    
                  ),
                   Container(
                      
                      child: DropdownButton<String>(
                      value: selecteditem,
                      items: dropdownitems.map((item) => DropdownMenuItem <String>(
                        value: item,
                        child: Text(item, style: TextStyle(fontSize: 20, color: Colors.white),),
                      )).toList(),
                      onChanged: (item) => setState(() { 
                        selecteditem = item;}),
                    ),
                  ),
                    
                  ],
                ),
                
                
        ],
        ),
      ) ,
    );
  }
}