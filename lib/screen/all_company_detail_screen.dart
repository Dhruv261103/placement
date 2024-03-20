import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:placement/models/company_models.dart';
import 'package:placement/services/services.dart';

import '../models/all_company_detail_model.dart';
import '../models/statastic_model.dart';
import '../services/Company_services.dart';
import '../services/all_company_services.dart';
import '../services/statastic_service.dart';

class AllCompanyDetailScreen extends StatefulWidget {
  String name;
  AllCompanyDetailScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<AllCompanyDetailScreen> createState() => _AllCompanyDetailScreenState();
}

class _AllCompanyDetailScreenState extends State<AllCompanyDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.grey, // Updated app bar color
          title: Text(
            'All Company Information',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: FutureBuilder<AllCompanyDetail>(
          future: getAllCompanyDetails(),
          builder: (context, AsyncSnapshot<AllCompanyDetail> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                        color: Colors.grey,
                        backgroundColor: Color.fromARGB(255, 250, 215, 227)),
                    Text('Wait for just second...'),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              log('${snapshot.error}');
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.allcompany.isEmpty) {
              return Center(child: Text('No company details available.'));
            } else {
              List<AllCompany> company = snapshot.data!.allcompany;

              return ListView.builder(
                itemCount: company.length,
                itemBuilder: (context, index) {
                  return company[index].name == widget.name
                      ? Card(
                          color: Color.fromARGB(255, 250, 215, 227),
                          elevation: 8,
                          margin: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: '',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Name: ',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${company[index].name}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: '',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Subtype: \n',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${company[index].subtype}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: '',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Bound: \n',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${company[index].bound}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: '',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Package: \n',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${company[index].package}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: '',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Total Round: ',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${company[index].totalitstu}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: '',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Total IT Student: ',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${company[index].totalitstu}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container();
                },
              );
            }
          },
        ));
  }
}
