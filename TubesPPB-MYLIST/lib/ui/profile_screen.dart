import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:punya_orang/ui/add_task.dart';
import 'package:punya_orang/utils/routes.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationEnabled = true;
  String _username = 'Default Username';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();

      setState(() {
        _username = userDoc['username'] ?? 'Default Username';

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            color: Color.fromRGBO(23, 107, 135, 1.0),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/Profile.png'),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/Profile.png',
                  fit: BoxFit.cover, // Adjust the fit property as needed
                  width: 100, // Adjust the width as needed
                  height: 100, // Adjust the height as needed
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              _username,
              style: TextStyle(
                fontSize: 18,
                color: Colors.teal[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Reminder',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(255, 133, 179, 1.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Notification',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Switch(
                  value: _notificationEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationEnabled = value;
                    });
                  },
                  activeColor: Colors.pinkAccent,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Daily reminder for nearest active task',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.pushNamed(context, '/homepage');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.checklist),
                  onPressed: () {
                    Navigator.pushNamed(context, '/tasklist');
                    
                  },
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile_screen');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}