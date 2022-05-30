import 'dart:html';

import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_social_media_application_dcgc/Screens/LoginPage.dart';
import 'package:project_social_media_application_dcgc/Screens/UpdateProfilePage.dart';

class HomePage extends StatefulWidget {
  String? token;
  String? username;
  HomePage(this.token, this.username);


  @override
  State<HomePage> createState() {
    return _HomePageState(this.token, this.username);
  }
}

class _HomePageState extends State<HomePage> {
  String? token_authorization;
  String? username;
  String? firstname;
  String? lastname;
  _HomePageState(this.token_authorization, this.username);
  List<String> dropdownitems = ['Friends Only', 'Public'];
  String? selecteditem = 'Friends Only';
  final TextEditingController _Createpost = TextEditingController();
  final ScrollController _Viewpost = ScrollController();
  var posts = [];
  

  
  
  void getAccountDetails() async{
    
    final url = "https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/user";
    try{
          final response = await get(Uri.parse("$url/$username"), 
          headers: <String, String>{
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token_authorization",
          },
          );
          
          final responsedata = jsonDecode(response.body);
          // print(responsedata);
          setState(() {
            firstname = responsedata["data"]["firstName"];
            lastname = responsedata["data"]["lastName"];
          });
          } catch(err){

          }
    // print("${_Email.text}");
  }

  void createPost() async{
    
    final url = "https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/post";
    try{
          final response = await post(Uri.parse("$url"), 
          headers: <String, String>{
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token_authorization",
          },
          body: jsonEncode({
                "text": _Createpost.text,
                "public": selecteditem == 'Public'? true:false,
                }),
          );
          
          final responsedata = jsonDecode(response.body);
          // print(responsedata);
          ScaffoldMessenger.of(this.context).showSnackBar(
            const SnackBar(content: Text("Post has been created")),
          );
          _Createpost.clear();
          } catch(err){

          }
    // print("${_Email.text}");
  }

  Future getPosts(int numOfPosts, String? lastId) async{
    final url = "https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/post";

    try{
          final response = await get(Uri.parse("$url?limit=$numOfPosts&next=$lastId&username=$username"), 
          headers: <String, String>{
            "accept": "application/json",
            // "Content-Type": "application/json",
            "Authorization": "Bearer $token_authorization",
          },
          );
          
          final responsedata = jsonDecode(response.body);
          final jsonData = responsedata["data"] as List;
          // print(jsonData);
          // print(responsedata);
          // print(responsedata["data"]);
          setState(() {
            posts.addAll(jsonData);
            
          });
          
          } catch(err){
              print(err);
          }
  }
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAccountDetails();
    getPosts(8, "");
    _Viewpost.addListener(() {
      if(_Viewpost.position.maxScrollExtent == _Viewpost.offset){

        if(posts.isNotEmpty){

          getPosts(8, posts[posts.length-1]["id"]);
        }
        
      }
    });
    
  }


  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      drawer: NavigationDrawer(username, firstname, lastname, token_authorization),
      appBar: AppBar(
        title: Text("Home Page"),
      ), // Text(token_authorization ?? 'no key provided')
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: _Viewpost,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                      hintText: 'How Is Your Day? :-)',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _Createpost,
                    
                    
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                
                  //width: MediaQuery.of(context).size.width * 0.05,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    ElevatedButton(
                    
                    child: Text('Post', 
                    style:TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    onPressed: (){
                      createPost();
                       
                     
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
                        child: Text(item, style: TextStyle(fontSize: 20),),
                      )).toList(),
                      onChanged: (item) => setState(() { 
                        selecteditem = item;}),
                    ),
                  ),
                    
                  ],
                ),
                
                ListView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: posts.length+1,
                  itemBuilder: (context, i){
                    if(i < posts.length){
                      final currentpost = posts[i];
                      return ListTile(title: Text("${currentpost["text"]}"));
                    }else {
                      return const Padding(padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(child: CircularProgressIndicator()));
                    }
                    
                  },
                ),
        ],
        ),
      ) ,
    );
  }
}


  

class NavigationDrawer extends StatelessWidget {
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? token_authorization;
  const NavigationDrawer(this.username, this.firstname, this.lastname, this.token_authorization);

  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MenuHeader(context, username, firstname, lastname),
          MenuItems(context, token_authorization, username, firstname, lastname),
        ],
      ),
    ),
  );
}
Widget MenuHeader(BuildContext context, String? username, String? firstname, String? lastname) =>Container(
    color: Colors.lightBlue,
    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    child: Column(
      children: [
        SizedBox(height: 10,),
        CircleAvatar(
          radius: 52,
        ),
        SizedBox(height: 10,),
        Text(
          "$firstname $lastname",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        Text(
          "$username",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        SizedBox(height: 10,),
      ],
    ),
  );


  Widget MenuItems(BuildContext context, String? token_authorization ,String? username, String? firstname, String? lastname) =>Container(
    padding: EdgeInsets.all(24),
    child:  Wrap(
        runSpacing: 15,
        children: [
          ListTile(
            leading: const Icon(Icons.arrow_back_ios),
            title: Text("Return"),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          // const Divider(color: Colors.lightBlue,),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text("Update Profile"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfilePage(token_authorization, username, firstname, lastname )));

            },
          ),
          ListTile(
            leading: const Icon(Icons.account_box_outlined),
            title: Text("View Other People"),
            onTap: (){
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text("Logout"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage())); 
            },
          ),
        ],


      ),
  );