
import 'package:admin_web_portal/widgets/nav_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';



class EmployersChartScreen extends StatefulWidget
{

  @override
  State<EmployersChartScreen> createState() => _EmployersChartScreenState();
}



class _EmployersChartScreenState extends State<EmployersChartScreen>
{
  int totalNumberOfVerifiedEmployers = 0;
  int totalNumberOfBlockedE = 0;


  getTotalNumberOfVerifiedEmployers() async
  {
    FirebaseFirestore.instance
        .collection("employers")
        .where("status", isEqualTo: "approved")
        .get()
        .then((allVerifiedEmployers)
    {
      setState(() {
        totalNumberOfVerifiedEmployers = allVerifiedEmployers.docs.length;
      });
    });
  }

  getTotalNumberOfBlockedEmployers() async
  {
    FirebaseFirestore.instance
        .collection("employers")
        .where("status", isEqualTo: "not approved")
        .get()
        .then((allBlockedEmployers)
    {
      setState(() {
        totalNumberOfBlockedE = allBlockedEmployers.docs.length;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    getTotalNumberOfVerifiedEmployers();
    getTotalNumberOfBlockedEmployers();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: NavAppBar(title: "SExchange",),
      body: DChartPie(
        data: [
          {'domain': 'Blocked Employers', 'measure': totalNumberOfBlockedE},
          {'domain': 'Verified Employers', 'measure': totalNumberOfVerifiedEmployers},
        ],
        fillColor: (pieData, index)
        {
          switch (pieData['domain'])
          {
            case 'Blocked Employers':
              return Colors.pinkAccent;
            case 'Verified Employers':
              return Colors.deepPurpleAccent;
            default:
              return Colors.grey;
          }
        },
        labelFontSize: 20,
        animate: false,
        pieLabel: (pieData, index)
        {
          return "${pieData['domain']}";
        },
        labelColor: Colors.white,
        strokeWidth: 6,
      ),
    );
  }
}
