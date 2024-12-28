import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/nav_appbar.dart';




class Reviewers extends StatefulWidget
{
  String complain;
  Reviewers(this.complain);


  @override
  State<Reviewers> createState() => _ReviewersState();
}



class _ReviewersState extends State<Reviewers>
{
  String? comlain;
  QuerySnapshot? allReviewers;



  getAllVerifiedUsers() async
  {
   await FirebaseFirestore.instance
        .collection("reviewer")
        // .where("skill", isEqualTo: "Database")
         .get()
        .then((snap)
    {
      setState(() {
        allReviewers = snap;
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

      if(allReviewers == null)
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
          itemCount: allReviewers!.docs.length,
          itemBuilder: (context, index)
          {
            return GestureDetector(
              onTap: ()async{
                // const url = "tg://t.me/https:/Whatever_you_are_be_a_good_one";
                // await launch(url);
              },
              child: Card(
                elevation: 10,
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 160,
                        height: 50,
                        child: Text(
                          "Reviewer Email: "+ allReviewers!.docs[index].get("email"),
                        ),
                      ),
                    ),

                    Text(
                      "Reviewer Name: "+ allReviewers!.docs[index].get("name"),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "${"Reviewer Skill: "+ allReviewers!.docs[index].get("skill")} , skill",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                      String ReviewerEmail= allReviewers!.docs[index].get("email");
                       comlain= widget.complain;

                      String? encodeQueryParameters(Map<String, String> params) {
                        return params.entries
                            .map((MapEntry<String, String> e) =>
                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                            .join('&');
                      }
                      final Uri emailUri=Uri(
                        scheme: 'mailto',
                        path: ReviewerEmail,
                          query:encodeQueryParameters(<String,String>{
                            'subject': 'From Skill Exchange System Admin',
                            'body':
                                'our client reports this  '+'"'+comlain! +" '"+ '  please review it now.',

                          })

                      );
                      launchUrl(emailUri);
                       },
                        style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      fixedSize: const Size(150, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ), child: const Text("Contact Reviewer")),





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
      appBar: NavAppBar(title: "Reviewers",),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: verifiedUsersDesign(),
        ),
      ),
    );
  }
}
