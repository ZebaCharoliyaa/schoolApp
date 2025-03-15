import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school/services/api_services.dart';

class NoticeBoard extends StatefulWidget {
  const NoticeBoard({super.key});

  @override
  _NoticeBoardState createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> notices = [];
  bool isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchNotices(); // ✅ Fetch notices when screen loads
    _startAutoRefresh(); // ✅ Automatically fetch notices
  }

  // ✅ Fetch Notices from API
  Future<void> fetchNotices() async {
    try {
      List<Map<String, dynamic>> newNotices = await apiService.getNotices();
      newNotices.sort((a, b) {
        DateTime dateA = DateTime.parse(a['date']);
        DateTime dateB = DateTime.parse(b['date']);
        return dateB.compareTo(dateA); // Descending order
      });
      if (mounted) {
        setState(() {
          notices = newNotices;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching notices: $e");
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  // ✅ Automatically Refresh Notices Every 30 Seconds
  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      fetchNotices();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // ✅ Stop auto-refresh when the screen is closed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title:
            const Text('Notice Board', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator()) // ✅ Show loading indicator
            : notices.isEmpty
                ? const Center(child: Text("No notices available."))
                : GridView.count(
                    crossAxisCount: 2, // Two items per row
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    children: notices.map((notice) {
                      return NoticeCard(
                        title: notice['title'],
                        date: notice['date'],
                      );
                    }).toList(),
                  ),
      ),
    );
  }
}

class NoticeCard extends StatelessWidget {
  final String title;
  final String date;

  const NoticeCard({
    super.key,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple[50],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            date,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
