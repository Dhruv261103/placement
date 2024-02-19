import 'package:flutter/material.dart';
import 'package:placement/models/post_models.dart';
import 'package:placement/services/services.dart';

class StudentDetail extends StatefulWidget {
  const StudentDetail({Key? key}) : super(key: key);

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  int selectedYear = DateTime.now().year;
  late TextEditingController _searchController;
  String _searchText = '';
  bool showAllStudent = false;
  bool searchByCompanyName = true;

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
        backgroundColor: Colors.indigo,
        title: _searchText.isEmpty
            ? Text(
                'Placement Details',
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
                  hintText:
                      'Search by ${searchByCompanyName ? 'Company Name' : 'Student ID'}',
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
                      _searchText = '***';
                    });
                  },
                )
              : Container(),
          IconButton(
            icon: Icon(Icons.switch_account),
            onPressed: () {
              setState(() {
                searchByCompanyName = !searchByCompanyName;
                _searchText = '';
                _searchController.clear();
              });
            },
          ),
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
                  showAllStudent = selectedYear == -1;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getPosts(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<Placement> products = snapshot.data;
                  List<Placement> filteredProducts =
                      products.where((placement) {
                    bool matchesYear = showAllStudent ||
                        (placement.yaer == selectedYear.toString());
                    if (searchByCompanyName) {
                      return placement.company!
                              .toLowerCase()
                              .contains(_searchText) &&
                          matchesYear;
                    } else {
                      return placement.idNo
                              .toLowerCase()
                              .contains(_searchText) &&
                          matchesYear;
                    }
                  }).toList();
                  if (filteredProducts.isEmpty) {
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
                      itemCount: filteredProducts.length,
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
                                'Enrollment No: ${filteredProducts[index].idNo}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Student Name: ${filteredProducts[index].firstName} ${filteredProducts[index].middleName} ${filteredProducts[index].lastName}',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(height: 8),
                                  filteredProducts[index].company != ""
                                      ? Text(
                                          'Company Name: ${filteredProducts[index].company}',
                                          style: TextStyle(fontSize: 14),
                                        )
                                      : Text(
                                          "Not Placed",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 16),
                                        ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Year: ${filteredProducts[index].yaer}',
                                    style: TextStyle(fontSize: 14),
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
