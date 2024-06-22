import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _subjekController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
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

  Future<void> _addTask() async {
    // Dapatkan instance dari Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Data yang akan ditambahkan ke Firestore
    Map<String, dynamic> taskData = {
      'judul': _judulController.text,
      'subjek': _subjekController.text,
      'deskripsi': _deskripsiController.text,
      'tanggal_jatuh_tempo': _dueDateController.text,
      'waktu_jatuh_tempo': _dueTimeController.text,
      'tanggal_pengingat': _reminderDateController.text,
      'waktu_pengingat': _reminderTimeController.text,
    };

    // Tambahkan data ke Firestore dalam koleksi 'task'
    await firestore.collection('task').add(taskData);

    // Kosongkan form setelah menambahkan tugas
    _judulController.clear();
    _subjekController.clear();
    _deskripsiController.clear();
    _dueDateController.clear();
    _dueTimeController.clear();
    _reminderDateController.clear();
    _reminderTimeController.clear();

    // Tampilkan pesan bahwa tugas telah ditambahkan
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tugas berhasil ditambahkan!')),
    );
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
                controller: _judulController,
                decoration: InputDecoration(
                  labelText: 'Judul',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _subjekController,
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
                controller: _deskripsiController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Tambah'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
