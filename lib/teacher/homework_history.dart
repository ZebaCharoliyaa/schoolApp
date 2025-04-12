import 'package:flutter/material.dart';
import 'package:school/services/api_services.dart';

class HomeworkHistoryScreen extends StatefulWidget {
  @override
  _HomeworkHistoryScreenState createState() => _HomeworkHistoryScreenState();
}

class _HomeworkHistoryScreenState extends State<HomeworkHistoryScreen> {
  String? _selectedStandard;
  bool _isLoading = false;
  List<Map<String, dynamic>> _homeworkList = [];
  final ApiService apiService = ApiService();

  final List<String> _standards = [
    '1-A',
    '1-B',
    '2-A',
    '2-B',
    '3-A',
    '3-B',
    '4-A',
    '4-B',
    '5-A',
    '5-B',
    '6-A',
    '6-B',
    '7-A',
    '7-B',
    '8-A',
    '8-B',
    '9-A',
    '9-B',
    '10-A',
    '10-B',
    '11',
    '12'
  ];

  Future<void> _fetchHistory() async {
    if (_selectedStandard == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a class first")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      List<Map<String, dynamic>> homework =
          await apiService.fetchHomework(_selectedStandard!);
      setState(() {
        _homeworkList = homework;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching homework: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteHomework(int? index) async {
    if (index == null || index < 0 || index >= _homeworkList.length) {
      print('Error: Invalid index or Homework ID is null');
      return;
    }

    String? homeworkId = _homeworkList[index]['id'] as String?;

    if (homeworkId == null) {
      print('Error: Homework ID is null');
      return;
    }

    // Show confirmation dialog
    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this homework?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Cancel delete
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true), // Confirm delete
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    // If user cancels, stop function execution
    if (!confirmDelete) return;

    bool success = await apiService.deleteHomework(homeworkId);

    if (success) {
      setState(() {
        _homeworkList
            .removeAt(index); // ✅ Ensure index is valid before removing
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Homework deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete homework')),
      );
    }
  }

  Future<bool> _showDeleteConfirmation() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Delete Homework?"),
            content: Text("Are you sure you want to delete this homework?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Delete", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Homework History")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedStandard,
              hint: Text("Select Class"),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStandard = newValue;
                });
              },
              items: _standards.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchHistory,
              child: Text("Show History"),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: _homeworkList.isEmpty
                        ? Center(child: Text("No homework found"))
                        : ListView.builder(
                            itemCount: _homeworkList.length,
                            itemBuilder: (context, index) {
                              final homework = _homeworkList[index];
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(homework['subject'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("📌 ${homework['title']}"),
                                      Text("📄 ${homework['description']}"),
                                      Text("📅 Due: ${homework['dueDate']}"),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _deleteHomework(index),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
