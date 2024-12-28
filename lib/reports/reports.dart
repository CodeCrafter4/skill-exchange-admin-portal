import 'package:admin_web_portal/functions/functions.dart';
import 'package:admin_web_portal/widgets/nav_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../homeScreen/home_screen.dart';
import '../reviewer/reviewer.dart';
import '../borrow/transferunit.dart';


class reports_user extends StatefulWidget
{

  @override
  State<reports_user> createState() => _reports_userState();
}



class _reports_userState extends State<reports_user>
{
  QuerySnapshot? allApprovedUsers;

  showDialogBox(userDocumentId)
  {
    return showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: const Text(
              "judge Account",
              style: TextStyle(
                fontSize: 25,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              "Do you want to judge this report ?",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 2,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: ()
                {
                  Navigator.pop(context);
                },
                child: const Text(
                    "No"
                ),
              ),
              ElevatedButton(
                onPressed: ()
                {
                  Map<String, dynamic> userDataMap =
                  {
                    "reportStatus": "judged",
                  };

                  FirebaseFirestore.instance
                      .collection("reports")
                      .doc(userDocumentId)
                      .update(userDataMap).whenComplete(()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));

                    showReusableSnackBar(context, "judged Successfully.");
                  });
                },
                child: const Text(
                    "Yes"
                ),
              )
            ],
          );
        }
    );
  }


  getAllVerifiedUsers() async
  {
   await FirebaseFirestore.instance
        .collection("reports")
        .where("reportStatus", isEqualTo: "normal")
        .get()
        .then((allVerifiedUsers)
    {
      setState(() {
        allApprovedUsers = allVerifiedUsers;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    getAllVerifiedUsers();
  }

  @override
  Widget build(BuildContext context)
  {
    Widget verifiedUsersDesign()
    {
      if(allApprovedUsers == null)
      {
        return const Center(
          child: Text(
            "No Record Found.",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        );
      }
      else
      {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: allApprovedUsers!.docs.length,
          itemBuilder: (context, index)
          {
            return GestureDetector(
              onTap: ()async{

              },
              child: SingleChildScrollView(

                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 180,
                          height: 60,
                          child: Text(
                            "complain: "+ allApprovedUsers!.docs[index].get("complain"),
                          ),
                        ),
                      ),

                      Text(
                       "complained By: "+ allApprovedUsers!.docs[index].get("userName"),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "complainer Email: "+ allApprovedUsers!.docs[index].get("email"),
                      ),
                      SizedBox(height: 10,),
                      Text(
                       "${"Agreement unit: "+ allApprovedUsers!.docs[index].get("unit")} unit",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20,),

                         Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
          ElevatedButton(onPressed: (){
            String UserEmail= allApprovedUsers!.docs[index].get("email");


            String? encodeQueryParameters(Map<String, String> params) {
              return params.entries
                  .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                  .join('&');
            }
            final Uri emailUri=Uri(
                scheme: 'mailto',
                path: UserEmail,
                query:encodeQueryParameters(<String,String>{
                  'subject': 'From Skill Exchange System Admin',
                  'body':
                  'hello our user',

                })

            );
            launchUrl(emailUri);


          }, style: ElevatedButton.styleFrom(
            primary: Colors.indigo,
            fixedSize: const Size(130, 45),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
            ),
          ), child: const Text("contact Reporter")),

      ElevatedButton(onPressed: (){

        showDialogBox(allApprovedUsers!.docs[index].id);



      }, style: ElevatedButton.styleFrom(
        primary: Colors.indigo,
        fixedSize: const Size(130, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
          child: const Text("judge Report")),

      ElevatedButton(onPressed: (){
        String complain= allApprovedUsers!.docs[index].get("complain");
        Navigator.push(context, MaterialPageRoute(builder: (c)=> Reviewers(complain)));

      }, style: ElevatedButton.styleFrom(
        primary: Colors.indigo,
        fixedSize: const Size(130, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
          child: const Text("forward Report")),



  ],
),
    ),
                      const SizedBox(height: 20,)
                      //earnings


                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: NavAppBar(title: "Reports",),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: verifiedUsersDesign(),
        ),
      ),
    );
  }
}
