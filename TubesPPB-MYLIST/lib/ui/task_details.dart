import 'package:flutter/material.dart';


class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({Key? key}) : super(key: key);

  @override
  State<TaskDetailsPage> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetailsPage> {
  String _selectedStatus = 'To Do'; // Inisialisasi dengan nilai awal "To Do"

  // Fungsi untuk menentukan warna latar belakang berdasarkan status yang dipilih
  Color _getBackgroundColor(String status) {
    switch (status) {
      case 'Progress':
        return Colors.orange; // Warna untuk "Progress"
      case 'Done':
        return Colors.green; // Warna untuk "Done"
      case 'To Do':
      default:
        return Color.fromRGBO(23, 107, 135, 1.0); // Warna default untuk "To Do"
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color.fromRGBO(23, 107, 135, 1.0),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task Title In Here',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: _getBackgroundColor(_selectedStatus), // Warna latar belakang dropdown button berdasarkan status
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<String>(
                value: _selectedStatus,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedStatus = newValue!;
                  });
                },
                items: <String>['To Do', 'Progress', 'Done']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  );
                }).toList(),
                style: TextStyle(color: Colors.white), // Menyesuaikan warna teks
                dropdownColor: Color.fromRGBO(23, 107, 135, 1.0), // Menyesuaikan warna dropdown
                underline: Container(), // Menghilangkan garis bawah
                iconEnabledColor: Colors.transparent, // Menyesuaikan warna ikon dropdown
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vestibulum consectetur lorem, a pharetra tortor mattis a. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vestibulum consectetur lorem, a pharetra tortor mattis a.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Subject: Computer Vision',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Priority: HIGH',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Due: March 5, 2024',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    // Navigate to home
                  },
                ),
                IconButton(
                  icon: Icon(Icons.checklist),
                  onPressed: () {
                    // Navigate to checklist
                  },
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                    // Navigate to profile
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
