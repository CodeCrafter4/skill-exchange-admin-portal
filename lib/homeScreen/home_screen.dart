import 'dart:async';

import 'package:admin_web_portal/users/blocked_users_screen.dart';
import 'package:admin_web_portal/users/verified_users_screen.dart';
import 'package:admin_web_portal/widgets/nav_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class HomeScreen extends StatefulWidget
{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}




class _HomeScreenState extends State<HomeScreen>
{
  String liveTime = "";
  String liveDate = "";

  String formatCurrentLiveTime(DateTime time)
  {
    return DateFormat("hh:mm:ss a").format(time);
  }

  String formatCurrentLiveDate(DateTime time)
  {
    return DateFormat("dd MMMM, yyyy").format(time);
  }

  getCurrentLiveTimeDate()
  {
    liveTime = formatCurrentLiveTime(DateTime.now());
    liveDate = formatCurrentLiveDate(DateTime.now());

    setState(() {
      liveTime;
      liveDate;
    });
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer)
    {
      getCurrentLiveTimeDate();
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: NavAppBar(title: "SkillExchange",),
      body: SafeArea(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  liveTime + "\n" + liveDate,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              //users activate and block accounts button ui
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //active
                  Column(
                    children: [
                      GestureDetector(

                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (c)=> VerifiedUsersScreen()));
                        },
                        child: Image.asset(
                          "images/verified_users.png",
                          width: 200,
                        ),
                      ),
                      const SizedBox(height: 50,),

                      const Text("Verified Freelancer ",style: TextStyle(fontSize: 18,color: Colors.black),),
                    ],
                  ),

                  const SizedBox(width: 200,),

                  //block
                  Column(
                    children: [
                      GestureDetector(
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (c)=> BlockedUsersScreen()));
                        },
                        child: Image.asset(
                          "images/blocked_users.png",
                          width: 200,
                        ),
                      ),
                      const SizedBox(height: 50,),

                      const Text("Blocked Freelancer ",style: TextStyle(fontSize: 18,color: Colors.black),),
                    ],
                  ),


                ],
              ),


              const SizedBox(
                height: 20,
              ),

              //sellers activate and block accounts button ui
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //active
                  Column(
                    children: [
                      GestureDetector(
                        onTap: ()
                        {

                        },
                        child: Image.asset(
                          "images/verified_seller.png",
                          width: 200,
                        ),
                      ),
                      const SizedBox(height: 50,),

                      const Text("Verified Employer ",style: TextStyle(fontSize: 18,color: Colors.black),),
                    ],
                  ),

                  const SizedBox(width: 200,),

                  //block
                  Column(
                    children: [
                      GestureDetector(
                        onTap: ()
                        {

                        },
                        child: Image.asset(
                          "images/blocked_seller.png",
                          width: 200,
                        ),
                      ),
                      const SizedBox(height: 50,),

                      const Text("Blocked Employer ",style: TextStyle(fontSize: 18,color: Colors.black),),
                    ],
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
