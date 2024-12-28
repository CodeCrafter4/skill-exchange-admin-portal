import 'package:admin_web_portal/functions/functions.dart';
import 'package:admin_web_portal/widgets/imageDialog.dart';
import 'package:admin_web_portal/widgets/nav_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../homeScreen/home_screen.dart';
import '../borrow/transferunit.dart';


class withdrawHome extends StatefulWidget
{

  @override
  State<withdrawHome> createState() => _withdrawHomeState();
}



class _withdrawHomeState extends State<withdrawHome>
{
  QuerySnapshot? allwithdraw;




  getAllVerifiedUsers() async
  {
    FirebaseFirestore.instance
        .collection("withdraw")
    //.where("reportStatus", isEqualTo: "normal")
        .get()
        .then((allVerifiedUsers)
    {
      setState(() {
        allwithdraw = allVerifiedUsers;
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
      if(allwithdraw == null)
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
          itemCount: allwithdraw!.docs.length,
          itemBuilder: (context, index)
          {
            String employerID= allwithdraw!.docs[index].get("employerUID");
            return GestureDetector(

              onTap: ()async{

              },
              child: Card(
                elevation: 10,
                child: Column(
                  children: [



                    Text(
                      "Employer Name: "+ allwithdraw!.docs[index].get("employerName"),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "withdraw Amount "+ allwithdraw!.docs[index].get("withdrawAmount"),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "withdraw ID "+ allwithdraw!.docs[index].get("withdrawID"),


                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
      appBar: NavAppBar(title: "withdraw",),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: verifiedUsersDesign(),
        ),
      ),
    );
  }
}
