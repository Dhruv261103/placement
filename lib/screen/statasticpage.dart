import 'package:flutter/material.dart';
import 'package:placement/models/company_models.dart';
import 'package:placement/services/services.dart';

import '../models/statastic_model.dart';
import '../services/Company_services.dart';
import '../services/statastic_service.dart';

class StatasticDetail extends StatefulWidget {
  const StatasticDetail({Key? key}) : super(key: key);

  @override
  State<StatasticDetail> createState() => _StatasticDetailState();
}

class _StatasticDetailState extends State<StatasticDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green, // Updated app bar color
          title: Text(
            'Statastic',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: FutureBuilder<StatasticModels>(
          future: getStatasticDetails(),
          builder: (context, AsyncSnapshot<StatasticModels> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.statastic.isEmpty) {
              return Center(child: Text('No company details available.'));
            } else {
              List<Statastic> statastic = snapshot.data!.statastic;

              return ListView.builder(
                itemCount: statastic.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8,
                    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListTile(
                        title: Text(
                          'Year: ${statastic[index].year}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MIN: ${statastic[index].minPack}',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              'AVG: ${statastic[index].avgPack}',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              'MAX: ${statastic[index].maxPack}',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              'Percentage: ${statastic[index].percentage}%',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
