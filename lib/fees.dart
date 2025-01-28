import 'package:flutter/material.dart';

class FeesDetailsScreen extends StatefulWidget {
  const FeesDetailsScreen({super.key});

  @override
  _FeesDetailsScreenState createState() => _FeesDetailsScreenState();
}

class _FeesDetailsScreenState extends State<FeesDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

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
        backgroundColor: Colors.deepPurple,
        title: const Text("Fees Details", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                labelStyle: const TextStyle(color: Colors.deepPurple),
                unselectedLabelColor: Colors.black,
                controller: _tabController,
                indicatorColor: Colors.deepPurple,
                tabs: const [
                  Tab(text: "School Fee"),
                  Tab(text: "Exam Fee"),
                  Tab(text: "Activity Fee"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildFeesList("School Fee"),
                    _buildFeesList("Exam Fee"),
                    _buildFeesList("Activity Fee"),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildFeesList(String category) {
    final List<Map<String, dynamic>> feesData = [
      {
        'month': 'January',
        'fee': 16600,
        'paid': true,
        'extra': 2000,
        'lateCharges': 600,
        'discount': 20
      },
      {
        'month': 'December',
        'fee': 14500,
        'paid': true,
      },
      {
        'month': 'November',
        'fee': 16600,
        'paid': true,
      },
      {
        'month': 'October',
        'fee': 14500,
        'paid': true,
      },
    ];
    final List<Color> colors = [
      // Colors.blue.shade100,
      // Colors.green.shade100,
      // Colors.orange.shade100,
      Colors.green.shade100,
      Colors.pink.shade100,
      Colors.blue.shade100,
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: feesData.length,
      itemBuilder: (context, index) {
        final feeItem = feesData[index];
        return Card(
          // color: Colors.blue[100],
          color: colors[index % colors.length],

          child: ExpansionTile(
            title: Text(
              '${feeItem['month']} Fee',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '₹ ${feeItem['fee']}',
              style: TextStyle(
                fontSize: 14,
                color: feeItem['paid'] ? Colors.green : Colors.red,
              ),
            ),
            trailing: feeItem['paid']
                ? const Text(
                    "Paid",
                    style: TextStyle(color: Colors.green, fontSize: 14),
                  )
                : const Text(
                    "Unpaid",
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
            children: feeItem.containsKey('extra')
                ? [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Fee: ₹ ${feeItem['fee']}'),
                          const SizedBox(height: 8),
                          Text('Extra Charges: ₹ ${feeItem['extra']}'),
                          Text('Late Charges: ₹ ${feeItem['lateCharges']}'),
                          Text('Discount: ${feeItem['discount']}%'),
                          const Divider(),
                          Text(
                            'Paid Fee: ₹ ${(feeItem['fee'] + feeItem['extra'] + feeItem['lateCharges'] - (feeItem['fee'] * feeItem['discount'] / 100)).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]
                : [],
          ),
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FeesDetailsScreen(),
  ));
}
