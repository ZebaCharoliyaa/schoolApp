// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class AdminNoticeBoard extends StatefulWidget {
//   @override
//   _AdminNoticeBoardState createState() => _AdminNoticeBoardState();
// }

// class _AdminNoticeBoardState extends State<AdminNoticeBoard> {
//   final TextEditingController _noticeController = TextEditingController();
//   List<Map<String, String>> notices = [];
//   File? _selectedImage;

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }

//   void _addNotice() {
//     if (_noticeController.text.isNotEmpty) {
//       setState(() {
//         notices.add({
//           'text': _noticeController.text,
//           'date': DateTime.now().toString().split(' ')[0],
//           'image': _selectedImage != null ? _selectedImage!.path : '',
//         });
//         _selectedImage = null;
//       });
//       _noticeController.clear();
//     }
//   }

//   void _deleteNotice(int index) {
//     setState(() {
//       notices.removeAt(index);
//     });
//   }

//   void _editNotice(int index) {
//     TextEditingController editController =
//         TextEditingController(text: notices[index]['text']);
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Edit Notice'),
//         content: TextField(
//           controller: editController,
//           decoration: InputDecoration(hintText: 'Edit your notice'),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 notices[index]['text'] = editController.text;
//               });
//               Navigator.pop(context);
//             },
//             child: Text('Update'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//             )),
//         centerTitle: true,
//         title: Text(
//           'Admin Notice Board',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Text input for notice
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16.0),
//               child: TextField(
//                 controller: _noticeController,
//                 maxLines: 3,
//                 decoration: InputDecoration(
//                   labelText: 'Enter Notice',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ),
//             // Image picker and submit button
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.image, color: Colors.deepPurple),
//                   onPressed: _pickImage,
//                 ),
//                 Spacer(),
//                 ElevatedButton(
//                   onPressed: _addNotice,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepPurple,
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                   ),
//                   child: Text(
//                     'Submit Notice',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             // Display notices
//             Expanded(
//               child: GridView.builder(
//                 padding: EdgeInsets.only(top: 16),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                   childAspectRatio: 1.2,
//                 ),
//                 itemCount: notices.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Image display
//                         if (notices[index]['image']!.isNotEmpty)
//                           ClipRRect(
//                             borderRadius:
//                                 BorderRadius.vertical(top: Radius.circular(16)),
//                             child: Image.file(
//                               File(notices[index]['image']!),
//                               width: double.infinity,
//                               height: 120,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         // Notice text
//                         Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 notices[index]['text']!,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 notices[index]['date']!,
//                                 style: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Edit and Delete buttons
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               IconButton(
//                                 icon: Icon(Icons.edit, color: Colors.blue),
//                                 onPressed: () => _editNotice(index),
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.delete, color: Colors.red),
//                                 onPressed: () => _deleteNotice(index),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

const String baseUrl = 'https://your-firebase-database-url.com';

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

  Future<void> addNotice(String title, String content, String? imageUrl) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notice_board.json'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'content': content,
        'date': DateTime.now().toIso8601String(),
        'image': imageUrl ?? '',
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // fetchNotices();
    } else {
      throw Exception('Failed to add notice');
    }
  }

  // Future<void> fetchNotices() async {
  //   final response = await http.get(Uri.parse('$baseUrl/notice_board.json'));
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic>? data = jsonDecode(response.body);
  //     if (data != null) {
  //       setState(() {
  //         notices = data.entries.map((entry) {
  //           return {
  //             'text': entry.value['title'],
  //             'date': entry.value['date'],
  //             'image': entry.value['image'] ?? '',
  //           };
  //         }).toList();
  //       });
  //     }
  //   } else {
  //     throw Exception('Failed to load notices');
  //   }
  // }

  void _addNotice() async {
    if (_noticeController.text.isNotEmpty) {
      await addNotice(_noticeController.text, '', _selectedImage?.path);
      _noticeController.clear();
      setState(() {
        _selectedImage = null;
      });
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
  void initState() {
    super.initState();
    // fetchNotices();
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
