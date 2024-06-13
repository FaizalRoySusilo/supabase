import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'package:coba/barang.dart';

class EditPage extends StatefulWidget {
  final int id;

  const EditPage({super.key, required this.id}) ;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  late dynamic db;

  @override
  void initState() {
    super.initState();
    setupDatabase();
  }

  void setupDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'barang_db.db'),
    );
    db = await database;

    retrieve();
  }

  void retrieve() async {
    final List<Map<String, Object?>> barang = await db.query(
      'barang',
      where: 'id = ?',
      whereArgs: [widget.id],
    );

    setState(() {
      namaController.text = barang[0]['Nama_Barang'].toString();
      jumlahController.text = barang[0]['Jumlah_Barang'].toString();
      hargaController.text = barang[0]['Harga_Barang'].toString();
    });
  }

  void update() async {
    if (namaController.text.isEmpty ||
        jumlahController.text.isEmpty ||
        hargaController.text.isEmpty) {
    
        final snackBar = SnackBar(
        content: Text('Nama Barang, Jumlah Barang, Atau Harga Barang Tidak Boleh Kosong!'),
        );
        ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
        return;
    }
    await db.update(
      'barang',
      {
        "Nama_Barang": namaController.text,
        "Jumlah_Barang": jumlahController.text,
        "Harga_Barang": hargaController.text,
      },
      where: 'id = ?',
      whereArgs: [widget.id],
    );
    
        Navigator.push(
        this.context,
        MaterialPageRoute(builder: (context) => Home()),
      );
  }
  void refresh(){
              Navigator.push(
              this.context,
              MaterialPageRoute(builder: (context) => Home()),
              );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Update Data Barang")),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: namaController,
            decoration: InputDecoration(
              labelText: "Nama Barang",
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: jumlahController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: "Jumlah Barang",
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: hargaController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: "Harga Barang",
            ),
          ),
          SizedBox(height: 20.0),
          Row( 
            children: <Widget>[
              Expanded( 
                child: ElevatedButton(
                  onPressed: update,
                  child: Text("Update Barang"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, 
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10), 
              Expanded( 
                child: ElevatedButton(
                  onPressed: refresh,
                  child: Text("Batal Update"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}