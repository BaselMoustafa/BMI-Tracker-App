import 'dart:async';
import 'package:bmi_tracker_app/core/network/hive_helper/hive_helper.dart';
import 'package:bmi_tracker_app/features/auth/screens/sign_in_screen.dart';
import 'package:bmi_tracker_app/features/home/view/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../../../core/managers/navigator_manager.dart';
import '../../../core/constants/constants.dart';
import '../../../core/managers/assets_manager.dart';
import '../../../firebase_options.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initializeAppServices();
    _timer=Timer(
      const Duration(seconds: 3), 
      _onTimerFinished,
    );
  }

  Future<void> _initializeAppServices()async{
    await HiveHelper.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:SizedBox(
          height: 100,
          width: 100,
          child: Image.asset(AssetsManager.logo),
        ),
      ),
    );
  }

  void _onTimerFinished(){
    NavigatorManager.pushAndRemoveUntil(
      context: context, 
      widget: HiveHelper.get(boxName: KConst.dataBoxName, key: KConst.userId)==null?
        const SignInScreen():const HomeScreen(),
    );
  }

  
}