import 'package:flutter/material.dart';
import 'package:school/services/api_services.dart';

class AdminNoticeBoard extends StatefulWidget {
  @override
  _AdminNoticeBoardState createState() => _AdminNoticeBoardState();
}

class _AdminNoticeBoardState extends State<AdminNoticeBoard> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> notices = [];
  final TextEditingController _noticeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchNotices();
  }

  Future<void> fetchNotices() async {
    final fetchedNotices = await apiService.getNotices();
    print('Fetched Notices: $fetchedNotices'); // Debugging step

    if (fetchedNotices.isEmpty) {
      print('No notices found.');
      return;
    }

    setState(() {
      notices = List<Map<String, dynamic>>.from(fetchedNotices);

      // ✅ Sort notices by date (latest first)
      notices.sort((a, b) =>
          DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));
    });
  }

  Future<void> addNotice() async {
    if (_noticeController.text.isEmpty) {
      return;
    }

    bool success = await apiService.addNotice(
      _noticeController.text,
      // DateTime.now().toString().split(' ')[0],
      DateTime.now().toString(),
    );

    if (success) {
      fetchNotices();
      _noticeController.clear();
    }
  }

  void _editNotice(int index) {
    // Ensure the index is valid
    if (index < 0 || index >= notices.length) {
      print('Invalid index');
      return;
    }

    // Create a TextEditingController with the current notice title
    TextEditingController editController =
        TextEditingController(text: notices[index]['title']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Notice'),
        content: TextField(
          controller: editController,
          decoration: InputDecoration(hintText: 'Edit your notice'),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              // Validate the input
              if (editController.text.isEmpty) {
                // Show an error message if the input is empty
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Notice cannot be empty')),
                );
                return;
              }

              // Call the API to update the notice
              bool success = await apiService.updateNotice(
                  notices[index]['id'], editController.text);
              if (success) {
                fetchNotices(); // Refresh UI after updating
              } else {
                // Handle the case where the update fails
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to update notice')),
                );
              }
              Navigator.pop(context);
            },
            child: Text('Update'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog without updating
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteNotice(int index) async {
    if (notices[index] == null || notices[index]['id'] == null) {
      print('Error: Notice ID is null');
      return;
    }

    String noticeId = notices[index]['id'] as String; // Ensure it's a string

    // Show confirmation dialog before deleting
    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this notice?'),
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

    bool success = await apiService.deleteNotice(noticeId);

    if (success) {
      setState(() {
        notices.removeAt(index); // ✅ Update UI after deleting
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notice deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete notice')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Text(
          'Admin Notice Board',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _noticeController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Enter Notice',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Spacer(),
                ElevatedButton(
                  onPressed: addNotice,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text(
                    'Submit Notice',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 16),
                itemCount: notices.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      title: Text(
                        notices[index]['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        notices[index]['date'],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editNotice(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteNotice(index),
                          ),
                        ],
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
