import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:subspace/main_screen/favpage.dart';
import 'package:subspace/main_screen/homepage.dart';
import 'package:provider/provider.dart';
import 'package:subspace/provider/fav_provider.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  var internet = true;
  int selectedIndex = 0;

  @override
  void initState() {
    getConnectivity();
    super.initState();
    context.read<Fav>().loadFavItemsProvider();
  }

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected) {
        setState(() {
          selectedIndex = 1;
          internet = false;
        });
      } else {
        setState(() {
          internet = true;
        });
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      HomePage(
        internet: internet,
      ),
      FavPage(
        internet: internet,
      )
    ];
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        selectedItemColor: Colors.black,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
        ],
        onTap: (value) => {
          setState(() {
            if (!isDeviceConnected) {
              selectedIndex = 1;
              setState(() {
                internet = false;
              });
            } else {
              selectedIndex = value;
              internet = true;
            }
          })
        },
      ),
    );
  }
}
