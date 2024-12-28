import 'package:admin_web_portal/homeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../authentication/login_screen.dart';
import '../borrow/borrow.dart';
import '../borrow/borrowed.dart';
import '../employers/employers_chart_screen.dart';
import '../reports/juged_report.dart';
import '../reports/reports.dart';
import '../users/users_chart_screen.dart';
import '../witdraw/withdrawhome.dart';




class NavAppBar extends StatefulWidget implements PreferredSizeWidget
{
  String? title;
  PreferredSizeWidget? preferredSizeWidget;

  NavAppBar({this.preferredSizeWidget, this.title,});

  @override
  State<NavAppBar> createState() => _NavAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => preferredSizeWidget == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}



class _NavAppBarState extends State<NavAppBar>
{
  @override
  Widget build(BuildContext context)
  {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors:
              [
                Colors.indigo,
                Colors.purpleAccent,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )
        ),
      ),
      title: GestureDetector(
        onTap: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));
        },
        child: Text(
          widget.title.toString(),
          style: const TextStyle(
            fontSize: 20,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      centerTitle: false,
      actions: [
        Row(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));
                },
                child: const Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const Text(
              "|",
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EmployersChartScreen()));

                },
                child: const Text(
                  "Employers Chart",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const Text(
              "|",
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UsersPieChartScreen()));

                },
                child: const Text(
                  "Freelancers Chart",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const Text(
              "|",
              style: TextStyle(
                color: Colors.white,
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => reports_user()));

                },
                child: const Text(
                  "Reports",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const Text(
              "|",
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => judged_reports()));

                },
                child: const Text(
                  "judged report",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const Text(
              "|",
              style: TextStyle(
                color: Colors.white,
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => borrow()));

                },
                child: const Text(
                  "Borrow",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const Text(
              "|",
              style: TextStyle(
                color: Colors.white,
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: ()
                {
                  FirebaseAuth.instance.signOut();

                  Navigator.push(context, MaterialPageRoute(builder: (c)=> withdrawHome()));
                },
                child: const Text(
                  "WithDraw",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Text(
              "|",
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: ()
                {
                  FirebaseAuth.instance.signOut();

                  Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          ],
        ),
      ],
    );
  }
}

