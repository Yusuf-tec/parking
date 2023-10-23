import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/help.dart';
import 'package:parking/pages/map.dart';
import 'package:parking/pages/setting.dart';
import 'package:parking/parking_location_slots.dart';
import 'package:parking/profile.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavDrawer(),
      backgroundColor: const Color.fromARGB(255, 45, 45, 42),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 56, 55, 51),

        //leading: IconButton(
        // icon: Icon(Icons.menu_rounded), onPressed: () {  },
        //  ),
        title: const Center(child: Text(' Ardhi University Parking System')),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            // Image.asset("asset/images/pizzle.jpg"),
            const UserAccountsDrawerHeader(
              accountName: Text('Yusuf Maftah'),
              accountEmail: Text('yusufmaftah00@gmail.com'),
              // currentAccountPicture: NetworkImage(''),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),
            ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfilePage(user: null,)));
                }),
            ListTile(
                leading: const Icon(Icons.map),
                title: const Text('Map'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MapPage(),
                  ));
                }),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HelpPage(),
                ));
              },
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(ParkingLocationList());
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>  ParkingLocationList(),
                //   ),
                  
                // );
              },
              child: const Text('Welcome to Parking management'),
            ),
               
          ],
        ),
      ),
        bottomNavigationBar: BottomNavigationBar(
         backgroundColor: const Color.fromARGB(255, 16, 15, 15),
        items: const[
          
       BottomNavigationBarItem(
        backgroundColor: Colors.black,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
          ]));
     
  }
}
