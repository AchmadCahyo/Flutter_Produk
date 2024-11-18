import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:produkform/models/api.dart';
import 'package:produkform/models/datamodel.dart';
import 'package:produkform/views/produkEdit.dart';
import 'package:http/http.dart' as http;

// Halaman Detail Produk
class Produkdetail extends StatefulWidget {
  final DataModel sw;
  final String? nama;
  final String? code;
  final int? stok;

  Produkdetail({super.key, required this.sw, this.nama, this.code, this.stok});

  @override
  ProdukDetailState createState() => ProdukDetailState();
}

class ProdukDetailState extends State<Produkdetail> {

  void deleteProduk(BuildContext context) async {
    http.Response response = await http.post(
      Uri.parse(BaseUrl.hapus),
      body: {'id': widget.sw.id.toString()},
    );

    final data = json.decode(response.body);
    if (data['success']) {
      pesan();
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  void pesan() {
    Fluttertoast.showToast(
      msg: 'Data Sudah Terhapus',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.greenAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void confirmDelete(BuildContext context) {
    showDialog(
        context: context, builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Apakah Yakin Hapus Data Ini?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(Icons.cancel),
              ),
              ElevatedButton(
                onPressed: () => deleteProduk(context),
                child: Icon(Icons.check_box),
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Card untuk menampilkan detail produk
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                widget.nama ?? 'Nama tidak tersedia',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Kode: ${widget.code ?? 'Tidak ada kode'}\nStok: ${widget.stok?.toString() ?? 'Tidak ada stok'}',
                style: TextStyle(fontSize: 16),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red,),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Hapus Produk'),
                          content: Text('Yakin Hapus Data Ini?'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                              Navigator.of(context).pop();
                              },
                              child: Text('Batal'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                deleteProduk(context);
                              },
                              child: Text('Hapus'),
                            ),
                          ],
                        );
                      }
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Produkedit(sw: widget.sw))),
      ),
    );
  }
}