import 'package:admin_web_portal/functions/functions.dart';
import 'package:admin_web_portal/widgets/nav_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';
import '../homeScreen/home_screen.dart';


class withdraw extends StatefulWidget
{
  String employerID;
  withdraw(this. employerID);


  @override
  State<withdraw> createState() => _withdrawState();
}



class _withdrawState extends State<withdraw>
{
  TextEditingController withdrawTextEditingController = TextEditingController();

  QuerySnapshot? allApprovedEmployers;

  String employerID="";
  showDialogBox(employerDocumentId)
  {
    return showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: const Text(
              "withdraw Unit",
              style: TextStyle(
                fontSize: 25,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              "Do you want to withdraw for this account ?",
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
                  String totalAmount=withdrawTextEditingController.value.text;
                  Map<String, dynamic> employerDataMap =
                  {

                  };

                  FirebaseFirestore.instance
                      .collection("employers")
                      .doc(employerDocumentId)
                      .update(employerDataMap)
                      .whenComplete(()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));

                    showReusableSnackBar(context, "Borrowed Successfully.");
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

  getAllVerifiedEmployer() async
  {
    employerID=widget.employerID;

    FirebaseFirestore.instance
        .collection("employers")
        .where("uid", isEqualTo: employerID)
        .get()
        .then((allVerifiedSellers)
    {
      setState(() {
        allApprovedEmployers = allVerifiedSellers;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    getAllVerifiedEmployer();
  }

  @override
  Widget build(BuildContext context)
  {
    Widget verifiedEmployersDesign()
    {
      if(allApprovedEmployers == null)
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
          itemCount: 1,
          itemBuilder: (context, index)
          {
            return Card(
              elevation: 1,
              child: Column(
                children: [



                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          controller: withdrawTextEditingController,
                          minLines: 2,
                          maxLines: 10,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'Borrow unit',
                              hintStyle: TextStyle(
                                  color: Colors.grey
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              )
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: ()
                        {
                          if(withdrawTextEditingController.text.isNotEmpty)
                          {
                            showDialogBox(allApprovedEmployers!.docs[index].id);
                          }
                          else
                          {

                            showReusableSnackBar(context, "please fill th form.");                        }
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 18.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Borrow",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.indigo,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),



                    ],
                  ),

                ],
              ),
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: NavAppBar(title: "Verified Employers",),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: verifiedEmployersDesign(),
        ),
      ),
    );
  }
}
