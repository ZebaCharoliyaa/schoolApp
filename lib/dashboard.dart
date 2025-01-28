import 'package:flutter/material.dart';
import 'package:school/menu.dart';

class firstpage extends StatelessWidget {
  const firstpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuScreen(),
                  ));
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            )),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notice Board Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Notice Board',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        // Example data for notices
                        final List<Map<String, String>> notices = [
                          {
                            'text': 'School is going for vacation in June',
                            'image': 'assets/images/pic1.jpg',
                          },
                          {
                            'text': 'Book Fair is scheduled for next month',
                            'image': 'assets/images/pic2.jpg',
                          },
                          {
                            'text': 'School Campus will be closed on 02 March',
                            'image': 'assets/images/pic3.jpg',
                          },
                        ];
                        final List<Color> colors = [
                          Colors.green.shade100,
                          Colors.pink.shade100,
                          Colors.blue.shade100,
                        ];

                        return Container(
                          width: 200, // Adjust width for horizontal scrolling
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colors[index % colors.length],
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            // color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  notices[index]['image']!,
                                  height: 40, // Adjust image size
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  notices[index]['text']!,
                                  style: const TextStyle(fontSize: 16),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
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

            // Homework Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Homework',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3, // Replace with actual homework data count
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.book,
                            color: Colors.deepPurple,
                          ),
                          title: Text('Homework Title ${index + 1}'),
                          subtitle: const Text('Subject details and deadlines'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Other sections can be added here
          ],
        ),
      ),
    );
  }
}
