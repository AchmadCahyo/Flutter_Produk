import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
// import 'package:biodata/models/api.dart';
// import 'package:http/http.dart' as http;

class Produkform extends StatefulWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late TextEditingController namaController, codeController, stokController;

  Produkform(
  {super.key,
    required this.formkey,
    required this.namaController,
    required this.codeController,
    required this.stokController});

  @override
  AppFormState createState() => AppFormState();
}

class AppFormState extends State<Produkform>{
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            tbNama(),
            tbCode(),
            tbStok(),
          ],
        ),
    );
  }

  Widget tbNama() {
    return TextFormField(
      controller: widget.namaController, // Hubungkan controller
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

  Widget tbCode() {
    return TextFormField(
      controller: widget.codeController, // Hubungkan controller
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

  Widget tbStok() {
    return TextFormField(
      controller: widget.stokController, // Hubungkan controller
      decoration: InputDecoration(
        labelText: 'Stok Produk',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkkan Stok Produk...';
        }
        return null;
      },
    );
  }

}