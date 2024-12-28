import 'package:admin_web_portal/functions/functions.dart';
import 'package:admin_web_portal/widgets/imageDialog.dart';
import 'package:admin_web_portal/widgets/nav_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../homeScreen/home_screen.dart';
import 'transferunit.dart';


class borrow extends StatefulWidget
{

  @override
  State<borrow> createState() => _borrowState();
}



class _borrowState extends State<borrow>
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
              "Do you want to borrow, for this Employer ?",
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
                    "borrowStatus": "borrowed",
                  };

                  FirebaseFirestore.instance
                      .collection("borrow")
                      .doc(userDocumentId)
                      .update(userDataMap).whenComplete(()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));

                    showReusableSnackBar(context, "borrowed Successfully.");
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
    FirebaseFirestore.instance
        .collection("borrow")
        .where("borrowStatus", isEqualTo: "borrow")
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
            String employerID= allApprovedUsers!.docs[index].get("employerUID");
            return GestureDetector(

              onTap: ()async{

              },
              child: Card(
                elevation: 10,
                child: Column(
                  children: [

                    Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          showDialog(context: context, builder: (_)=> ImageDialog(
                            allApprovedUsers!.docs[index].get("thumbnailUrl")

                          ));
                        },
                        child: Container(
                          width: 180,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: NetworkImage(
                                allApprovedUsers!.docs[index].get("thumbnailUrl"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Text(
                      "Employer Name: "+ allApprovedUsers!.docs[index].get("employerName"),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Borrow Id: "+ allApprovedUsers!.docs[index].get("borrowID"),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "${"Borrow Amount/unit: "+ allApprovedUsers!.docs[index].get("borrowAmount")} unit",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TransferUnit(employerID)));

                    }, child: const Text("Borrow")),
                    SizedBox(height: 20,),

                    //earnings


                  ],
                ),
              ),
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: NavAppBar(title: "Borrow",),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: verifiedUsersDesign(),
        ),
      ),
    );
  }
}
