import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MultimediaScreen(),
  ));
}

class MultimediaScreen extends StatelessWidget {
  const MultimediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Multimedia',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            const TabBar(
              isScrollable: true,
              labelColor: Colors.deepPurple,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.deepPurple,
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Video'),
                Tab(text: 'Images'),
                Tab(text: 'Documents'),
                Tab(text: 'Links'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  MediaList(),
                  const Center(child: Text('Videos')),
                  const Center(child: Text('Images')),
                  const Center(child: Text('Documents')),
                  const Center(child: Text('Links')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MediaList extends StatelessWidget {
  final List<Map<String, dynamic>> mediaItems = [
    {
      'icon': Icons.picture_as_pdf,
      'title': 'Social Science Syllabus',
      'description': 'Syllabus for 2020 batch\n12 pages / 360 KB',
    },
    {
      'icon': Icons.archive,
      'title': 'Chapter-wise MCQs & Answers',
      'description': 'Live Stream Capture\nDuration: 25:00',
    },
    {
      'icon': Icons.video_collection_outlined,
      'title': 'Improvement in Food Resources',
      'description': '15 MB',
    },
    {
      'icon': Icons.picture_as_pdf,
      'title': 'Exemplar Solutions Class 10',
      'description': 'Syllabus for 2020 batch\n12 pages / 360 KB',
    },
    {
      'icon': Icons.folder_zip,
      'title': 'Preparation Tips',
      'description': '15 MB',
    },
  ];
  final List<Color> colors = [
    // Colors.blue.shade100,
    // Colors.green.shade100,
    // Colors.orange.shade100,
    Colors.green.shade100,
    Colors.pink.shade100,
  ];

   MediaList({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mediaItems.length,
      itemBuilder: (context, index) {
        final item = mediaItems[index];
        return Card(
          color: colors[index % colors.length],
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                item['icon']!,
                color: Colors.deepPurple,
                // style: TextStyle(color: Colors.deepPurple),
              ),
            ),
            title: Text(item['title']!),
            subtitle: Text(item['description']!),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ),
        );
      },
    );
  }
}
