// import 'dart:html';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_social_media_application_dcgc/Screens/ViewProfilePage.dart';

// when the user clicks on a particular page this will be the page that greets them 
// it will shows the post itself along with when it was created, updated and who the author is 
class ViewPostPage extends StatefulWidget {
  String? posttext;
  String? token;
  String? id;
  String? authorusername;
  int date;
  int updated;
  ViewPostPage(this.posttext, this.token,this.id, this.authorusername, this.date, this.updated);
  @override
  State<ViewPostPage> createState(){
    return _ViewPostPageState(this.posttext, this.token,this.id, this.authorusername, this.date, this.updated);
  }
}

class _ViewPostPageState extends State<ViewPostPage> {
  String? posttext;
  String? token_authorization;
  String? id;
  String? authorusername;
  int date;
  int updated;
  _ViewPostPageState(this.posttext, this.token_authorization,this.id, this.authorusername, this.date, this.updated);
  final TextEditingController _Post = TextEditingController();
  // String? datetimestring = DateFormat('MM/dd/yyyy, hh:mm a').format(datetime); 
  @override
  Widget build(BuildContext context) {
    // since the time the post was created was in epoch time this is where the epoch time of when the post was created is converted
    //into the mm/dd/yyyy format 
    var createddatetime = DateTime.fromMillisecondsSinceEpoch(date);
    String? datetimestring = DateFormat('MM/dd/yyyy, hh:mm a').format(createddatetime);
    // since the time the post was updated was in epoch time this is where the epoch time of when the post was updated is converted
    //into the mm/dd/yyyy format 
    var updateddatetime = DateTime.fromMillisecondsSinceEpoch(updated);
    String? updateddatetimestring = DateFormat('MM/dd/yyyy, hh:mm a').format(updateddatetime);
    _Post.text = posttext!;
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Home Page"),
      ), // Text(token_authorization ?? 'no key provided')
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50,),
                Text(
                  'Post Content',
                  style: TextStyle(
                    fontWeight:FontWeight.bold, 
                      color: Colors.white, 
                        fontSize: 30),
                ),
          SizedBox(height: 50,),
          Container(
                  padding: EdgeInsets.symmetric(horizontal: 20) ,
                  margin: EdgeInsets.only(top:10, ),
                  // the post content will be displayed within this disabled textfield 
                  child: TextFormField(
                    enabled: false,
                    maxLines: null,
                    minLines: 4,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      prefixIcon: Icon(Icons.edit),
                      hintText: 'You can write anything :-)',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    controller: _Post,
                    
                    
                  ),
                ),
                SizedBox(height: 10,),
                Text("Date created: $datetimestring", style: TextStyle(
                                                              fontWeight:FontWeight.bold, 
                                                              color: Colors.white, 
                                                              fontSize: 18,
                                                              fontStyle: FontStyle.italic,
                                                              ),),
                  Text("Date updated: $updateddatetimestring",style: TextStyle(
                                                              fontWeight:FontWeight.bold, 
                                                              color: Colors.white, 
                                                              fontSize: 18,
                                                              fontStyle: FontStyle.italic,
                                                              ),),
                // Row(
                
                //   //width: MediaQuery.of(context).size.width * 0.05,
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //   //the times when the post is created and edited is displayed in this row 
                //   Text("Date created: $datetimestring", style: TextStyle(
                //                                               fontWeight:FontWeight.bold, 
                //                                               color: Colors.white, 
                //                                               fontSize: 18,
                //                                               fontStyle: FontStyle.italic,
                //                                               ),),
                //   Text("Date updated: $updateddatetimestring",style: TextStyle(
                //                                               fontWeight:FontWeight.bold, 
                //                                               color: Colors.white, 
                //                                               fontSize: 18,
                //                                               fontStyle: FontStyle.italic,
                //                                               ),),
                   
                    
                //   ],
                // ),
                 SizedBox(height: 25,),
                // username of the author of the post is displayed here 
                
                Text(
                  'Author',
                  style: TextStyle(
                    fontWeight:FontWeight.bold, 
                      color: Colors.white, 
                        fontSize: 30),
                ),
                SizedBox(height: 10,),
                CircleAvatar(
                  radius: 50,
                  ),
                SizedBox(height: 10,),
                //the user can click the authors name to view his/her profile
                TextButton(child: Text("$authorusername", style: TextStyle(
                                                              fontWeight:FontWeight.bold, 
                                                              color: Colors.white, 
                                                              fontSize: 18,
                                                              fontStyle: FontStyle.italic,
                                                              ),),
                          
                          onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfilePage(token_authorization, authorusername)));
                          },
                                            ),
                
        ],
        ),
      ),
    );
  }
}