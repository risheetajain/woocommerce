import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:safira_woocommerce_app/constant.dart';

import 'package:safira_woocommerce_app/ui/LoginPage.dart';

import 'package:safira_woocommerce_app/ui/SignUp.dart';

import 'package:safira_woocommerce_app/ui/widgets/mytextbutton.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Image(
                              image: AssetImage('assets/team_illustration.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Enterprise team\ncollaboration.",
                          style: kHeadline,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            "Bring together your files, your tools, project and people.Including a new mobile and desktop application.",
                            style: kBodyText,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: MyTextButton(
                            bgColor: Colors.white,
                            buttonName: 'Register',
                            onTap: () {
                              // Customers customer = Customers();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()));
                            },
                            textColor: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: MyTextButton(
                            bgColor: Colors.transparent,
                            buttonName: 'Sign In',
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => LoginPage(),
                                  ));
                            },
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
