import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:safira_woocommerce_app/ui/Welcome.dart';
import 'package:safira_woocommerce_app/utils/sharedServices.dart';

class AnimatedSplash extends StatefulWidget {
  @override
  _AnimatedSplashState createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash> {
  Customers loginDetails;
  SharedServices sharedServices = SharedServices();

  @override
  void initState() {
    getValidation().then((value) => setState(() {
          loginDetails = value;
        }));

    super.initState();
  }

  Future<Customers> getValidation() async {
    final login1 = await sharedServices.loginDetails();
    return login1;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Clean Code',
        home: AnimatedSplashScreen(
            duration: 4000,
            splash: Center(
              child: Text(
                "Safira App",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            nextScreen: loginDetails == null
                ? WelcomePage()
                : BasePage(
                    customer: loginDetails,
                    title: "Safira App",
                  ),
            splashTransition: SplashTransition.fadeTransition,
            // pageTransitionType: PageTransitionType.scale,
            backgroundColor: Colors.white));
  }
}
