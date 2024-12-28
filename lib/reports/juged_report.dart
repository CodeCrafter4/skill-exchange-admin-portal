import 'package:admin_web_portal/functions/functions.dart';
import 'package:admin_web_portal/widgets/nav_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../homeScreen/home_screen.dart';


class judged_reports extends StatefulWidget
{

  @override
  State<judged_reports> createState() => _judged_reportsState();
}



class _judged_reportsState extends State<judged_reports>
{
  QuerySnapshot? allApprovedUsers;




  getBorrow() async
  {
    FirebaseFirestore.instance
        .collection("reports")
        .where("reportStatus", isEqualTo: "judged")
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

    getBorrow();
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
                const url = "tg://t.me/https:/Whatever_you_are_be_a_good_one";
                await launch(url);
              },
              child: Card(
                elevation: 10,
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
                      "${"Agreement unit: "+ allApprovedUsers!.docs[index].get("unit")} unit",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20,),

                    const SizedBox(height: 20,)
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
      appBar: NavAppBar(title: "judged reports",),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: verifiedUsersDesign(),
        ),
      ),
    );
  }
}
