import 'package:flutter/material.dart';
import 'package:student_app/courses/course_view.dart';
import 'package:student_app/models/profile_model.dart';
import 'package:student_app/views/login_view.dart';
import 'package:student_app/profile/edit_profile.dart';

class Myprofile extends StatefulWidget {
  const Myprofile({super.key});

  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  UserProfile userProfile = UserProfile(
      name: 'VIVEK',
      email: 'vivek@gmail.com',
      mobile: '123432',
      dob: '10-03-1993');
  void _navigateToEditProfile(
      BuildContext context, UserProfile userProfile) async {
    final updateProfile = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfile(userProfile: userProfile),
        ));
    if (updateProfile != null) {
      setState(() {
        userProfile = updateProfile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CourseView(),
                ));
          },
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.arrow_back),
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFF6EEE2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.orange,
                    width: 2,
                  )),
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'VIVEK',
              style: TextStyle(
                  fontFamily: 'Alfa Slab One',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C1D45)),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.blueAccent, width: 2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(
                  'Name:${userProfile.name}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.blueAccent, width: 2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(
                  'Email:${userProfile.email}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.blueAccent, width: 2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(
                  'Mobile No:${userProfile.mobile}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.blueAccent, width: 2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(
                  'DOB:${userProfile.dob}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _navigateToEditProfile(context, userProfile),
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      backgroundColor: Colors.blue),
                  child: const Text("Edit Profile",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      backgroundColor: Colors.blue),
                  child: const Text(
                    "Delete Profile",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ));
              },
              icon: const Icon(Icons.logout),
              label: const Text(
                'Logout',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange[500],
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.grid_view, size: 24),
              onPressed: () {},
              color: Colors.black,
            ),
            IconButton(
              icon: const Icon(
                Icons.favorite_border,
                size: 24,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.settings_outlined,
                color: Colors.black,
                size: 24,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () {},
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
