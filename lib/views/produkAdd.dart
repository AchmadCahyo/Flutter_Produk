import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:http/http.dart' as http;
import 'package:produkform/models/api.dart';
import 'package:intl/intl.dart';

class Produkadd extends StatefulWidget {
  const Produkadd({super.key});

  @override
  State<StatefulWidget> createState() => ProdukaddState();
}

class ProdukaddState extends State<Produkadd>{
  final formkey = GlobalKey<FormState>();
  TextEditingController namaController = new TextEditingController();
  TextEditingController codeController = new TextEditingController();
  TextEditingController stokController = new TextEditingController();

  Future createSw() async {
    return await http.post(Uri.parse(BaseUrl.tambah),
      body: {
        "nama": namaController.text,
        "code": codeController.text,
        "stok": stokController.text
      },
    );
  }

  void _onConfirm(context) async {
    http.Response response = await createSw();
    final data = json.decode(response.body);
    if(data['success']) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _tbNama(),
            _tbCode(),
            _tbstok(),
            _save()
          ],
        ),
      ),
    );
  }

  _tbNama() {
    return TextFormField(
      controller: namaController, // Hubungkan controller
      decoration: InputDecoration(
        labelText: 'Nama Produk',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkkan Nama Produk...';
        }
        return null;
      },
    );
  }

  _tbCode() {
    return TextFormField(
      controller: codeController, // Hubungkan controller
      decoration: InputDecoration(
        labelText: 'Code Produk',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkkan Code Produk...';
        }
        return null;
      },
    );
  }

  _tbstok() {
    return TextFormField(
      controller: stokController, // Hubungkan controller
      decoration: InputDecoration(
        labelText: 'Jumlah Stok',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkkan Jumlah Stok...';
        }
        return null;
      },
    );
  }

  _save() {
    return ElevatedButton(
      onPressed: () {
        _onConfirm(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green, // Warna teks
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(10.0), // Membuat sudut tombol melengkung
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 15.0, horizontal: 30.0), // Padding di dalam tombol
        elevation: 5.0, // Efek shadow di bawah tombol
        shadowColor: Colors.grey.withOpacity(0.5), // Warna shadow
      ),
      child: const Text(
        'Submit',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}