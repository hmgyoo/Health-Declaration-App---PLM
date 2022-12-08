import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihdplm_new/src/dashboard/widgets/cardStatus.dart';
import 'package:ihdplm_new/src/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ihdplm_new/src/authentication/auth/auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';

class RemindersScreen extends StatelessWidget {
  RemindersScreen({super.key});

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                '.ihd-plm/',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
              ),
            ],
          ),
          SizedBox(height: 40),
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 20,
                  child: Container(
                    height: 140,
                    child: Image.asset(
                      'assets/images/coughing-removebg-preview.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  left: 170,
                  top: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Answer the Health Declaration Form',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20.0,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Contains several questions to check your current health condition.',
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Current Updates',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Latest Update: Nov 2022',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // pulling api refresh here
                },
                child: Icon(LineIcons.syncIcon),
              ),
            ],
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CardStatus(
                iconName: LineIcons.lightbulb,
                colorCard: Colors.orange,
                newCases: '+25',
                totalCases: '7,987',
                status: 'Active',
              ),
              SizedBox(width: 20),
              CardStatus(
                iconName: LineIcons.medicalClinic,
                colorCard: Colors.green,
                newCases: '+5',
                totalCases: '11,090',
                status: 'Recovered',
              ),
              SizedBox(width: 20),
              CardStatus(
                iconName: LineIcons.skullCrossbones,
                colorCard: Colors.red,
                newCases: '+25',
                totalCases: '355',
                status: 'Deceased',
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Current Updates',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 15.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Active Cases',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '7,978',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '[+25]',
                                style: TextStyle(
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Weekly',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Monthly',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 45,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
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
  }

  // Future<void> signOut() async {
  //   await Auth().signOut();
  // }

  // Widget _title() {
  //   return const Text('Firebase Auth');
  // }

  // Widget _userId() {
  //   return Text(user?.email ?? 'User email');
  // }

  // Widget _signOutButton() {
  //   return ElevatedButton.icon(
  //     onPressed: () => FirebaseAuth.instance.signOut(),
  //     label: const Text('Sign Out', style: TextStyle(fontSize: 24)),
  //     icon: Icon(Icons.arrow_back, size: 32),
  //   );
  // }

}
