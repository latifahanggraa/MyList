import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/icon.png'),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Welcome...',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Selamat Datang di MyList, Aplikasi penjadwalan tugas terbaik...',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 100),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(23, 107, 135, 1)),
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('Sign Up', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'or',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(23, 107, 135, 1)),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Login', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
