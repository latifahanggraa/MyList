import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:punya_orang/ui/profile_screen.dart';

class TaskListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengelola Tugas',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: TaskHomePage(),
      routes: {
        '/homepage': (context) => TaskHomePage(),
        '/tasklist': (context) => TaskHomePage(), // Change this to your task list page if different
        '/profile_screen': (context) => ProfileScreen(),
      },
    );
  }
}

class TaskHomePage extends StatefulWidget {
  @override
  _TaskHomePageState createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  String _selectedFilter = 'Recently';
  final List<String> _filters = ['Recently', 'Today', 'Upcoming', 'Later'];
  List<Map<String, String>> _tasks = []; // List untuk menyimpan tugas

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/homepage');
        break;
      case 1:
        Navigator.pushNamed(context, '/tasklist');
        break;
      case 2:
        Navigator.pushNamed(context, '/profile_screen');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Task'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _filters.map((filter) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                  child: Text(
                    filter,
                    style: TextStyle(
                      color: _selectedFilter == filter
                          ? Colors.pink
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: _tasks.isEmpty
                ? Center(
                    child: Text(
                      'Belum ada tugas yang ditambahkan.',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(_tasks[index]['title'] ?? 'Title'),
                          subtitle: Text(_tasks[index]['date'] ?? 'Date'),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _tasks[index]['status'] ?? 'To Do',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TaskDetailPage(taskIndex: index + 1),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );
          if (newTask != null) {
            setState(() {
              _tasks.add(newTask);
            });
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Tugas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class TaskDetailPage extends StatelessWidget {
  final int taskIndex;

  TaskDetailPage({required this.taskIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Tugas $taskIndex'),
      ),
      body: Center(
        child: Text('Detail dari Tugas $taskIndex'),
      ),
    );
  }
}

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _dueTimeController = TextEditingController();
  final TextEditingController _reminderDateController = TextEditingController();
  final TextEditingController _reminderTimeController = TextEditingController();

  Future<void> _selectDueDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        _dueDateController.text = DateFormat('dd.MM.yyyy').format(selectedDate);
      });
    }
  }

  Future<void> _selectDueTime() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        _dueTimeController.text = selectedTime.format(context);
      });
    }
  }

  Future<void> _selectReminderDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        _reminderDateController.text =
            DateFormat('dd.MM.yyyy').format(selectedDate);
      });
    }
  }

  Future<void> _selectReminderTime() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        _reminderTimeController.text = selectedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tambah Tugas'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Subjek',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _dueDateController,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Jatuh Tempo',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: _selectDueDate,
                          ),
                        ),
                        readOnly: true,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _dueTimeController,
                        decoration: InputDecoration(
                          labelText: 'Waktu Jatuh Tempo',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.access_time),
                            onPressed: _selectDueTime,
                          ),
                        ),
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _reminderDateController,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Pengingat',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: _selectReminderDate,
                          ),
                        ),
                        readOnly: true,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _reminderTimeController,
                        decoration: InputDecoration(
                          labelText: 'Waktu Pengingat',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.access_time),
                            onPressed: _selectReminderTime,
                          ),
                        ),
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_titleController.text.isNotEmpty) {
                        Navigator.pop(context, {
                          'title': _titleController.text,
                          'date': _dueDateController.text,
                          'status': 'To Do'
                        });
                      }
                    },
                    child: Text('Tambah'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}


