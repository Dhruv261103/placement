import 'package:flutter/material.dart';
import 'package:placement/models/company_models.dart';
import 'package:placement/services/services.dart';

import '../services/Company_services.dart';

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
        backgroundColor: Colors.green,
        title: _searchText.isEmpty
            ? Text(
                'Company Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            : TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchText = value.toLowerCase();
                  });
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search Company',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
        actions: [
          _searchText.isEmpty
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _searchText = 'Crestdata';
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
                    child: CircularProgressIndicator(),
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
                          elevation: 8,
                          margin: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListTile(
                              title: Text(
                                '${filteredCompanies[index].companyName}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Year: ${filteredCompanies[index].year}',
                                style: TextStyle(fontSize: 14),
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
