// import 'dart:html';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// in the view post page if the user clcked on the authors username then he/she will be greeted with this page 
//this page is very similar to the homepage but all the posts seen in this page came from one person
class ViewProfilePage extends StatefulWidget {
  String? token;
  String? username;
  ViewProfilePage(this.token, this.username);
  @override
  State<ViewProfilePage> createState(){
    return _ViewProfilePageState(this.token, this.username);
  }
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  //here is where the username, firstname, lastname of the post author is found 
  String? token_authorization;
  String? username;
  String? firstname;
  String? lastname;
  _ViewProfilePageState(this.token_authorization, this.username);
  final ScrollController _Viewpost = ScrollController();
  var posts = [];


  //similarly to the homepage the same function uses get requests to get the authors firstname and lastname
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

  //this will be the function to get the posts that are from the author
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
          print(responsedata["data"]);
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
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("View Account"),
      ), // Text(token_authorization ?? 'no key provided')
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
                SizedBox(height: 10,),
                Row(

                  //width: MediaQuery.of(context).size.width * 0.05,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  CircleAvatar(radius: 50,),
                  //SizedBox(width:100),
                  SizedBox(width:MediaQuery.of(context).size.width * 0.05,),
                  // Text("Date created: ", style: TextStyle(
                  //                                             fontWeight:FontWeight.bold, 
                  //                                             color: Colors.white, 
                  //                                             fontSize: 18,
                  //                                             fontStyle: FontStyle.italic,
                  //                                             ),),
                  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("${username}",
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                  ),
                  Text('${lastname}, ${firstname} ',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  ]),
                  SizedBox(width:MediaQuery.of(context).size.width * 0.20,),
                  
                  ],
                ),
                SizedBox(height: 10,),
                Text("Posts from $username",
                  style: TextStyle(color: Colors.white, fontSize: 35.0),
                  ),
                // this list view is responsible for displaying all the authors posts 
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
                                  child: ListTile(title: Text("${currentpost["username"]} posted at ${DateFormat('MM/dd/yyyy, hh:mm a').format(datetime)}",style: TextStyle(fontSize: 14, fontWeight:FontWeight.bold,),),
                                                  subtitle: Text(" -> ${currentpost["text"]}", style: TextStyle(fontSize: 20),),
                                                  
                                      onTap:(){
                                      
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
      ),
    );
  }
}