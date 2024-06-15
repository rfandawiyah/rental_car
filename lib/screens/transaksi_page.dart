import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rental_car/models/customers_models.dart';
import 'package:rental_car/models/rent_details_models.dart';
import 'package:rental_car/models/rents_models.dart';
import 'package:rental_car/screens/main_page.dart';

class TransaksiPage extends StatefulWidget {
  final CustomersModel customer;
  final String nopol;

  const TransaksiPage({super.key, required this.customer, required this.nopol});

  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _lamaSewaController = TextEditingController();

  DateTime? _tglSewa;
  DateTime? _tglPengembalian;
  DateTime? _tglPembayaran;

  @override
  void initState() {
    super.initState();
    _nopolController.text = widget.nopol;
  }

  final TextEditingController _nopolController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _tglSewa != null &&
        _tglPengembalian != null &&
        _tglPembayaran != null) {
      final rent = RentModel(
        idSewa: DateTime.now().millisecondsSinceEpoch,
        tglSewa: _tglSewa!,
        tglPembayaran: _tglPembayaran!,
        status: 'Pending',
        total: 500000.0,
        NIK: widget.customer.NIK,
      );

      final rentDetails = [
        RentDetailModel(
          idSewa: rent.idSewa,
          nopol: _nopolController.text,
          lamaSewa: int.parse(_lamaSewaController.text),
          tglPengembalian: _tglPengembalian!,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      // Here you would normally send rent and rentDetails to your backend

      // Navigate back to the Dashboard
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  Future<void> _selectDate(
      BuildContext context, Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'No. Polisi'),
                controller: _nopolController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan No. Polisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Lama Sewa (hari)'),
                controller: _lamaSewaController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan Lama Sewa';
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text(_tglSewa == null
                    ? 'Pilih Tanggal Sewa'
                    : 'Tanggal Sewa: ${DateFormat('yyyy-MM-dd').format(_tglSewa!)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, (date) {
                  setState(() {
                    _tglSewa = date;
                  });
                }),
              ),
              ListTile(
                title: Text(_tglPengembalian == null
                    ? 'Pilih Tanggal Pengembalian'
                    : 'Tanggal Pengembalian: ${DateFormat('yyyy-MM-dd').format(_tglPengembalian!)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, (date) {
                  setState(() {
                    _tglPengembalian = date;
                  });
                }),
              ),
              ListTile(
                title: Text(_tglPembayaran == null
                    ? 'Pilih Tanggal Pembayaran'
                    : 'Tanggal Pembayaran: ${DateFormat('yyyy-MM-dd').format(_tglPembayaran!)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, (date) {
                  setState(() {
                    _tglPembayaran = date;
                  });
                }),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Lanjutkan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
