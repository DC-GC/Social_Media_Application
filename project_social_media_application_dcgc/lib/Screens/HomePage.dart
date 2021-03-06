// import 'dart:html';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_social_media_application_dcgc/Screens/EditPostPage.dart';
import 'package:project_social_media_application_dcgc/Screens/LoginPage.dart';
import 'package:project_social_media_application_dcgc/Screens/UpdateProfilePage.dart';
import 'package:project_social_media_application_dcgc/Screens/ViewPostPage.dart';


// after logging in, the application will move to this page where he/she can write posts and view the posts of others
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
  //here is the controller for creating posts 
  final TextEditingController _Createpost = TextEditingController();
  //here is the controller which is used for pagination 
  final ScrollController _Viewpost = ScrollController();
  var posts = [];
  

  
  //here is the function that uses a get request 
  // to get the account firstname and lastname of the users account 
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

  //here is the function that will be in charge of creating posts through post requests 
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
      //here is the function that will be in charge of deleting posts through delete requests 
    void deletePost(String? postId) async{
    
    final url = "https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/post/";
    try{
          final response = await delete(Uri.parse("$url$postId"), 
          headers: <String, String>{
            "accept": "application/json",
            // "Content-Type": "application/json",
            "Authorization": "Bearer $token_authorization",
          },
          // body: jsonEncode({
          //       "text": _Createpost.text,
          //       "public": selecteditem == 'Public'? true:false,
          //       }),
          );
          
          final responsedata = jsonDecode(response.body);
          print(responsedata);
          ScaffoldMessenger.of(this.context).showSnackBar(
            const SnackBar(content: Text("Post has been deleted")),
          );
          _Createpost.clear();
          } catch(err){

          }
    // print("${_Email.text}");
  }
  //here is the function that will get posts from the server with respect to pagination 
  Future getPosts(int numOfPosts, String? lastId) async{
    final url = "https://cmsc-23-2022-bfv6gozoca-as.a.run.app/api/post";

    try{
          final response = await get(Uri.parse("$url?limit=$numOfPosts&next=$lastId"), 
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

    //on startup of the page the aapp will immediately get the accounts first name and last name 
    // as well as the first 8 posts of their news feed 
    super.initState();
    getAccountDetails();
    getPosts(8, "");

    //pagination works if the user scrolled to the botton then the application will get more posts from the server
    //is the user scrolls down to the bottom again the process will repeat 
    //until there are no more posts available in the server 
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
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
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

                  //this is the textfield used in creating posts 
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
                    //after the user wrote something in the proper textfiled 
                    //the user must click the post button to create the post 
                    ElevatedButton(
                    
                    child: Text('Post', 
                    style:TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    onPressed: (){
                      createPost();
                      Future.delayed(Duration(milliseconds: 750), (){
                        setState(() {
                          posts.clear();
                          getPosts(8, "");
                        });
                        
                      });
                      
                     
                      },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.1, MediaQuery.of(context).size.height * 0.075,),
                    ),
                  ),
                  Container(
                      // here is dropdown button that will indicate if the post the user will make is puclic or for friends only
                      child: DropdownButton<String>(
                      value: selecteditem,
                      dropdownColor: Color.fromRGBO(58, 66, 86, 1.0),
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
                // the list view below is the one responsible for displaying the posts for the users news feed
                // the pagination will happen per 8 posts 
                // is the user scrolls at the bottom of the posts then the application will get another 8 posts 
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 20) ,
          
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: posts.length+1,
                  itemBuilder: (context, i){
                    if(i < posts.length){
                      final currentpost = posts[i];
                      var datetime = DateTime.fromMillisecondsSinceEpoch(currentpost["date"]);
                      return Card(
                                  margin: EdgeInsets.only(top:10, ),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                                  elevation: 5,
                                  child: ListTile(title: currentpost["username"] == username? 
                                                          Text("YOU posted at ${DateFormat('MM/dd/yyyy, hh:mm a').format(datetime)}", style: TextStyle(fontSize: 14, fontWeight:FontWeight.bold, ),):
                                                          Text("${currentpost["username"]} posted at ${DateFormat('MM/dd/yyyy, hh:mm a').format(datetime)}",style: TextStyle(fontSize: 14, fontWeight:FontWeight.bold,),),
                                                  subtitle: Text(" -> ${currentpost["text"]}", style: TextStyle(fontSize: 20),),
                                                  //if the post displayed was from the user they will have the option to edit or delete the posts 
                                                  //by clicking the proper trailing icon 
                                                  trailing: currentpost["username"] == username? Row(children: [
                                                            IconButton(onPressed: () {setState(() {deletePost(currentpost["id"]);
                                                                                                  Future.delayed(Duration(milliseconds: 750), (){
                                                                                                    posts.clear();
                                                                                                    getPosts(8, "");
                                                                                                  });
                                                                                                  
                                                                                                  });}, icon: Icon(Icons.delete)),
                                                            IconButton(onPressed: () {setState(() {
                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditPostPage(currentpost["text"],token_authorization, currentpost["id"],username,currentpost["public"])));
                                                              posts.clear();
                                                              getPosts(8, "");
                                                            });}, icon: Icon(Icons.create_sharp)),],
                                                  mainAxisSize: MainAxisSize.min,
                                                  ):null,
                                      // the listtile itself can be clicked in order to view the posts details 
                                      onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPostPage(currentpost["text"],token_authorization, currentpost["id"],currentpost["username"],currentpost["date"], currentpost["updated"])));
                                      } ,
                                      ),
                              );
                      
                      
                      
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


  
//here lies the menu on the left of the user which allows the user to logout and update their account 
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
// the menu header will display all account details like username, firstname, lastname
//everything except the password 
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

  // here are the menu items of the drawer 
  Widget MenuItems(BuildContext context, String? token_authorization ,String? username, String? firstname, String? lastname) =>Container(
    padding: EdgeInsets.all(24),
    child:  Wrap(
        runSpacing: 15,
        children: [
          //here is the option to close the drawer
          ListTile(
            leading: const Icon(Icons.arrow_back_ios),
            title: Text("Return"),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          // const Divider(color: Colors.lightBlue,),
          //here is the option to update your profile 
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text("Update Profile"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfilePage(token_authorization, username, firstname, lastname )));

            },
          ),
          
          //and here is the option to logout 
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