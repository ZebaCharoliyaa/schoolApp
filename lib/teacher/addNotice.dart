import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdminNoticeBoard extends StatefulWidget {
  @override
  _AdminNoticeBoardState createState() => _AdminNoticeBoardState();
}

class _AdminNoticeBoardState extends State<AdminNoticeBoard> {
  final TextEditingController _noticeController = TextEditingController();
  List<Map<String, String>> notices = [];
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _addNotice() {
    if (_noticeController.text.isNotEmpty) {
      setState(() {
        notices.add({
          'text': _noticeController.text,
          'date': DateTime.now().toString().split(' ')[0],
          'image': _selectedImage != null ? _selectedImage!.path : '',
        });
        _selectedImage = null;
      });
      _noticeController.clear();
    }
  }

  void _deleteNotice(int index) {
    setState(() {
      notices.removeAt(index);
    });
  }

  void _editNotice(int index) {
    TextEditingController editController =
        TextEditingController(text: notices[index]['text']);
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
            onPressed: () {
              setState(() {
                notices[index]['text'] = editController.text;
              });
              Navigator.pop(context);
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
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
            // Text input for notice
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
            // Image picker and submit button
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.image, color: Colors.deepPurple),
                  onPressed: _pickImage,
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: _addNotice,
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
            // Display notices
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(top: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: notices.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image display
                        if (notices[index]['image']!.isNotEmpty)
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                            child: Image.file(
                              File(notices[index]['image']!),
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        // Notice text
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notices[index]['text']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                notices[index]['date']!,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Edit and Delete buttons
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
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
                      ],
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
