import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

// --- BAGIAN 1: FORMULIR INPUT (STATEFUL) ---
// Kelas ini mengelola semua state input: controller, tanggal, dan dropdown.

class _KegiatanTambahForm extends StatefulWidget {
  _KegiatanTambahForm({super.key});

  @override
  State<_KegiatanTambahForm> createState() => _KegiatanTambahFormState();
}

class _KegiatanTambahFormState extends State<_KegiatanTambahForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _penanggungJawabController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  
  String? _selectedKategori;
  DateTime? _selectedDate;
  
  final List<String> kategoriOptions = ['Musyawarah', 'Komunitas & Sosial', 'Keagamaan', 'Pendidikan', 'Lain-lain'];

  @override
  void dispose() {
    _namaController.dispose();
    _lokasiController.dispose();
    _penanggungJawabController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF7166F9), 
            colorScheme: const ColorScheme.light(primary: Color(0xFF7166F9)),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _namaController.clear();
    _lokasiController.clear();
    _penanggungJawabController.clear();
    _deskripsiController.clear();

    setState(() {
      _selectedKategori = null;
      _selectedDate = null;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Logika untuk menyimpan data kegiatan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kegiatan "${_namaController.text}" berhasil disimpan!'),
          backgroundColor: Colors.green,
        ),
      );
      _resetForm();
    }
  }

  // Komponen TextFormField dengan gaya minimalis
  Widget _buildTextField(TextEditingController controller, String label, String hint, {int maxLines = 1, String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF454545))),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF0F0F5), // Warna isian abu-abu muda
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none, // Menghilangkan border utama
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF7166F9), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
          validator: validator,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String dateText = _selectedDate == null 
        ? '-- / -- / ----' 
        : DateFormat('dd-MM-yyyy').format(_selectedDate!);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // 1. Nama Kegiatan
          _buildTextField(_namaController, 'Nama Kegiatan', 'Contoh: Musyawarah Warga',
            validator: (value) => (value == null || value.isEmpty) ? 'Nama kegiatan wajib diisi' : null),

          // 2. Kategori Kegiatan (Dropdown)
          const Text('Kategori Kegiatan', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF454545))),
          const SizedBox(height: 5),
          DropdownButtonFormField<String>(
            value: _selectedKategori,
            decoration: InputDecoration(
              hintText: '-- Pilih Kategori --',
              filled: true,
              fillColor: const Color(0xFFF0F0F5),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF7166F9), width: 1.5)),
            ),
            items: kategoriOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(color: Color(0xFF454545))),
              );
            }).toList(),
            onChanged: (String? newValue) => setState(() => _selectedKategori = newValue),
            validator: (value) => (value == null || value.isEmpty) ? 'Kategori wajib dipilih' : null,
          ),
          const SizedBox(height: 20),

          // 3. Tanggal
          const Text('Tanggal', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF454545))),
          const SizedBox(height: 5),
          TextFormField(
            readOnly: true,
            controller: TextEditingController(text: dateText),
            onTap: () => _selectDate(context),
            decoration: InputDecoration(
              hintText: '-- / -- / ----',
              filled: true,
              fillColor: const Color(0xFFF0F0F5),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF7166F9), width: 1.5)),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, size: 20, color: _selectedDate != null ? Colors.redAccent : Colors.grey),
                    onPressed: _selectedDate != null ? _resetForm : null, 
                  ),
                  Container(color: Colors.grey.shade400, width: 1, height: 24),
                  IconButton(
                    icon: const Icon(Icons.calendar_month, size: 20, color: Color(0xFF7166F9)),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
            ),
            validator: (value) => (_selectedDate == null) ? 'Tanggal wajib diisi' : null,
          ),
          const SizedBox(height: 20),

          // 4. Lokasi
          _buildTextField(_lokasiController, 'Lokasi', 'Contoh: Balai RT 03'),

          // 5. Penanggung Jawab
          _buildTextField(_penanggungJawabController, 'Penanggung Jawab', 'Contoh: Pak RT atau Bu RW',
            validator: (value) => (value == null || value.isEmpty) ? 'Penanggung Jawab wajib diisi' : null),

          // 6. Deskripsi
          _buildTextField(_deskripsiController, 'Deskripsi', 'Tuliskan detail event seperti agenda, keperluan, dll.', maxLines: 5),

          // Tombol Aksi
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7166F9),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 5, // Tambahkan elevasi untuk kesan floating
                ),
                child: const Text('Submit'),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: _resetForm,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text('Reset', style: TextStyle(color: Colors.black54)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- BAGIAN 2: KELAS UTAMA (kegiatanTambahPage) ---
// Kelas ini hanya mengatur layout utama.

class kegiatanTambahPage extends StatelessWidget {
  const kegiatanTambahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header yang Dibuat Unik
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF7166F9).withOpacity(0.9), const Color(0xFFC4B8FD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.event_note, color: Colors.white, size: 30),
                SizedBox(width: 15),
                Text(
                  'Buat Kegiatan Baru',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          
          // Card Utama untuk Form
          Card(
            elevation: 8, // Tingkatkan shadow untuk kesan floating
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: _KegiatanTambahForm(), 
            ),
          ),
        ],
      ),
    );
  }
}