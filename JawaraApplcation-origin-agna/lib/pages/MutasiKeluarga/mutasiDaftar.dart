import 'package:flutter/material.dart';

class mutasiDaftar extends StatelessWidget {
  const mutasiDaftar({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk daftar mutasi keluarga
    final List<Map<String, String>> dataMutasi = [
      {'jenis': 'Pindah Masuk', 'kepala_keluarga': 'Budi Santoso', 'tanggal': '01 Nov 2025', 'status': 'Diterima'},
      {'jenis': 'Pindah Keluar', 'kepala_keluarga': 'Ani Fitria', 'tanggal': '20 Okt 2025', 'status': 'Pending'},
      {'jenis': 'Pindah Masuk', 'kepala_keluarga': 'Citra Dewi', 'tanggal': '15 Sep 2025', 'status': 'Diterima'},
    ];

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: dataMutasi.length,
        itemBuilder: (context, index) {
          final mutasi = dataMutasi[index];
          
          Color statusColor;
          if (mutasi['status'] == 'Diterima') {
            statusColor = Colors.green;
          } else if (mutasi['status'] == 'Pending') {
            statusColor = Colors.orange;
          } else {
            statusColor = Colors.grey;
          }

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: Icon(
                mutasi['jenis'] == 'Pindah Masuk' ? Icons.arrow_downward : Icons.arrow_upward, 
                color: Colors.teal
              ),
              title: Text('${mutasi['jenis']} - ${mutasi['kepala_keluarga']!}', 
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Tanggal: ${mutasi['tanggal']!}'),
              trailing: Chip(
                label: Text(mutasi['status']!, style: TextStyle(color: statusColor)),
                backgroundColor: statusColor.withOpacity(0.1),
              ),
              onTap: () {
                // TODO: Navigasi ke halaman detail mutasi
              },
            ),
          );
        },
      ),
      // Tombol FAB untuk navigasi ke halaman Tambah Mutasi
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman Tambah Mutasi
          // Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Mutasitambah()));
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Tambah Mutasi Keluarga',
      ),
    );
  }
}