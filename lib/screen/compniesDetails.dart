import 'package:flutter/material.dart';
import 'package:placement/models/company_models.dart';
import 'package:placement/services/services.dart';

import '../services/Company_services.dart';
import 'all_company_detail_screen.dart';

class CompanyDetails extends StatefulWidget {
  const CompanyDetails({Key? key}) : super(key: key);

  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  int selectedYear = DateTime.now().year;
  late TextEditingController _searchController;
  String _searchText = '';
  bool showAllCompanies = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        iconTheme: IconThemeData(color: Colors.black),
        title: _searchText.isEmpty
            ? Text(
                'Company Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            : TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchText = value.toLowerCase();
                  });
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Search Company',
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
        actions: [
          _searchText.isEmpty
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _searchText = ' ';
                    });
                  },
                )
              : Container(),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<int>(
              value: selectedYear,
              items: [
                DropdownMenuItem<int>(
                  value: -1,
                  child: Text('All'),
                ),
                ...List.generate(
                  DateTime.now().year - 2014,
                  (index) => DropdownMenuItem<int>(
                    value: 2015 + index,
                    child: Text('Year ${2015 + index}',
                        style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedYear = value!;
                  showAllCompanies = selectedYear == -1;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getCompanyDetails(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                            color: Colors.grey,
                            backgroundColor:
                                Color.fromARGB(255, 250, 215, 227)),
                        Text('Wait for just second...'),
                      ],
                    ),
                  );
                } else {
                  List<Company> companies = snapshot.data;
                  List<Company> filteredCompanies = companies
                      .where((company) => (company.companyName
                              .toLowerCase()
                              .contains(_searchText) &&
                          (showAllCompanies ||
                              company.year == selectedYear.toString())))
                      .toList();

                  if (filteredCompanies.isEmpty) {
                    return Center(
                      child: Text('No companies found.'),
                    );
                  }

                  return Scrollbar(
                    interactive: true,
                    thickness: 15,
                    radius: Radius.circular(10),
                    isAlwaysShown: false,
                    child: ListView.builder(
                      itemCount: filteredCompanies.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Color.fromARGB(255, 250, 215, 227),
                          elevation: 8,
                          margin: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListTile(
                              trailing: IconButton(
                                icon: Icon(Icons.info_outline_rounded),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              AllCompanyDetailScreen(
                                                name: filteredCompanies[index]
                                                    .companyName,
                                              )));
                                },
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              text: '',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Company Name : ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                TextSpan(
                                                    text:
                                                        '${filteredCompanies[index].companyName}',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ))
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Year : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          TextSpan(
                                              text:
                                                  '${filteredCompanies[index].year}',
                                              style: TextStyle(
                                                fontSize: 15,
                                              ))
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
