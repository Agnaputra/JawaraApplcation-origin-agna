import 'package:flutter/material.dart';

class Mutasitambah extends StatefulWidget {
  const Mutasitambah({super.key});

  @override
  State<Mutasitambah> createState() => _MutasitambahState();
}

class _MutasitambahState extends State<Mutasitambah> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _kepalaKeluargaController = TextEditingController();
  final TextEditingController _alamatTujuanController = TextEditingController();
  String? _jenisMutasi;
  
  // Daftar jenis mutasi
  final List<String> jenisMutasiOptions = ['Pindah Masuk', 'Pindah Keluar'];

  @override
  void dispose() {
    _kepalaKeluargaController.dispose();
    _alamatTujuanController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Logika untuk menyimpan data mutasi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mutasi ${_kepalaKeluargaController.text} (${_jenisMutasi}) berhasil dicatat!')),
      );
      // Kembali ke halaman sebelumnya
      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Judul Halaman
            const Padding(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Text(
                'Formulir Tambah Mutasi Keluarga',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            
            // Dropdown Jenis Mutasi
            DropdownButtonFormField<String>(
              value: _jenisMutasi,
              decoration: const InputDecoration(
                labelText: 'Jenis Mutasi',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.compare_arrows),
              ),
              hint: const Text('Pilih Jenis Mutasi'),
              items: jenisMutasiOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _jenisMutasi = newValue;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Jenis Mutasi harus dipilih';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Input Nama Kepala Keluarga
            TextFormField(
              controller: _kepalaKeluargaController,
              decoration: const InputDecoration(
                labelText: 'Nama Kepala Keluarga',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama Kepala Keluarga tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Input Alamat Tujuan/Asal
            TextFormField(
              controller: _alamatTujuanController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: _jenisMutasi == 'Pindah Keluar' ? 'Alamat Tujuan' : 'Alamat Asal',
                alignLabelWithHint: true,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.location_on),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Alamat tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Tombol Simpan
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.save),
              label: const Text('Simpan Mutasi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}