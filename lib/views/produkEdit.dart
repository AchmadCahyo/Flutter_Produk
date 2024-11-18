import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:produkform/models/datamodel.dart';
import 'package:produkform/models/api.dart';
import 'package:produkform/views/produkForm.dart';

class Produkedit extends StatefulWidget {
  final DataModel sw;

  const Produkedit({super.key, required this.sw});

  @override
  EditState createState() => EditState();
}

class EditState extends State<Produkedit>{
  final formkey = GlobalKey<FormState>();
  late TextEditingController namaController, codeController, stokController;

  Future editSw() async {
    return await http.post(Uri.parse(BaseUrl.edit),
      body: {
        "id": widget.sw.id.toString(),
        "nama": namaController.text,
        "code": codeController.text,
        "stok": stokController.text,
      }
    );
  }

  pesan() {
    Fluttertoast.showToast(msg: "Data Berhasil Dirubah", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16);
  }

  void _onConfirm(context) async {
    try {
      http.Response response = await editSw();
      final data = json.decode(response.body);
      if (data['success']) {
        pesan();
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        // Tangani jika update gagal
        print('Update failed: ${data['message']}');
      }
    } catch (e) {
      print('Error: $e');
      // Tampilkan pesan kesalahan kepada pengguna
    }
  }

  @override
  void initState() {
    namaController = TextEditingController(text: widget.sw.nama);
    codeController = TextEditingController(text: widget.sw.code);
    stokController = TextEditingController(text: widget.sw.stok.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Data"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.green,
            textStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          child: const Text("Update"),
          onPressed: () {
              _onConfirm(context);
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(28.0), // Pastikan padding langsung di sini
        child: Center( // Form di sini adalah form utama
          child: Produkform(
            formkey: formkey, // Operkan key form
            namaController: namaController,
            codeController: codeController,
            stokController: stokController,
          ),
        ),
      ),
    );
  }
}