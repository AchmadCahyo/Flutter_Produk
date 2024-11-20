import 'dart:convert';
import 'dart:async';
import 'package:produkform/models/api.dart';
import 'package:produkform/models/datamodel.dart';
import 'package:produkform/views/produkDetail.dart';
import 'package:produkform/views/produkAdd.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController stokController = TextEditingController();

  late Future<List<DataModel>> produkListFuture; // Ganti nama sw menjadi produkListFuture

  @override
  void initState() {
    super.initState();
    produkListFuture = getSwList(); // Gunakan nama yang sama dengan yang dideklarasikan
  }

  Future<List<DataModel>> getSwList() async {
    try {
      final response = await http.get(Uri.parse(BaseUrl.data));
      print(response.statusCode);

      if (response.statusCode == 200) {
        final List<dynamic> items = json.decode(response.body);

        // Mencetak data dari API untuk debug
        print(items);

        return items
            .map<DataModel>((json) => DataModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to Load Data!');
      }
    } catch (e) {
      print('Error Fetching Data: $e');
      throw Exception('Error Fetching Data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Barang'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<DataModel>>(
              future: produkListFuture, // Gunakan produkListFuture di sini
              builder: (BuildContext context,
                  AsyncSnapshot<List<DataModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No Data Found'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data![index];
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.check_box),
                        trailing: Icon(Icons.view_list),
                        title: Text(
                          data.nama,
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text("${data.code}, ${data.stok}"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Produkdetail(
                                sw: data,
                                nama: data.nama,
                                code: data.code,
                                stok: data.stok,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.green,
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Produkadd()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
