import 'package:flutter/material.dart';

class boradcastTambahPage extends StatefulWidget {
  const boradcastTambahPage({super.key});

  @override
  State<boradcastTambahPage> createState() => _boradcastTambahPageState();
}

class _boradcastTambahPageState extends State<boradcastTambahPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _pesanController = TextEditingController();
  String? _tipeBroadcast;
  
  // Daftar tipe broadcast
  final List<String> tipeBroadcastOptions = ['Informasi Umum', 'Peringatan', 'Undangan'];

  @override
  void dispose() {
    _judulController.dispose();
    _pesanController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Logika untuk menyimpan dan mengirim broadcast
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Broadcast "${_judulController.text}" berhasil dikirim!')),
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
                'Formulir Tambah Broadcast',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            
            // Input Judul Broadcast
            TextFormField(
              controller: _judulController,
              decoration: const InputDecoration(
                labelText: 'Judul Broadcast',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.subject),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Judul tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Dropdown Tipe Broadcast
            DropdownButtonFormField<String>(
              value: _tipeBroadcast,
              decoration: const InputDecoration(
                labelText: 'Tipe Broadcast',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              hint: const Text('Pilih Tipe Broadcast'),
              items: tipeBroadcastOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _tipeBroadcast = newValue;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tipe Broadcast harus dipilih';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Input Pesan Broadcast
            TextFormField(
              controller: _pesanController,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Isi Pesan / Detail Broadcast',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.message),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pesan tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Tombol Kirim
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.send),
              label: const Text('Kirim Broadcast'),
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