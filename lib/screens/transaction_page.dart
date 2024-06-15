import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rental_car/service/global_variable.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _customerNIKController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final _customerAddressController = TextEditingController();
  final _rentDateController = TextEditingController();
  final _paymentDateController = TextEditingController();
  String _status = 'unpaid'; // default status
  final _totalController = TextEditingController();
  final List<Map<String, TextEditingController>> _rentDetails = [];

  void _addRentDetail() {
    setState(() {
      _rentDetails.add({
        'nopol': TextEditingController(),
        'lama_sewa': TextEditingController(),
        'tgl_pengembalian': TextEditingController(),
      });
    });
  }

  void _removeRentDetail(int index) {
    setState(() {
      _rentDetails.removeAt(index);
    });
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final customer = {
        'NIK': _customerNIKController.text,
        'nama': _customerNameController.text,
        'no_telephon': _customerPhoneController.text,
        'alamat': _customerAddressController.text,
      };

      final rent = {
        'tgl_sewa': _rentDateController.text,
        'tgl_pembayaran': _paymentDateController.text,
        'status': _status,
        'total': double.parse(_totalController.text),
      };

      final rentDetails = _rentDetails.map((detail) {
        return {
          'nopol': detail['nopol']!.text,
          'lama_sewa': int.parse(detail['lama_sewa']!.text),
          'tgl_pengembalian': detail['tgl_pengembalian']!.text,
        };
      }).toList();

      final data = {
        'customer': customer,
        'rent': rent,
        'rent_details': rentDetails,
      };

      print('Submitting data: $data'); // Logging data to be submitted

      final response = await http.post(
        Uri.parse('${GlobalVariable.baseUrl}/api/pesanan'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      print(
          'Response status: ${response.statusCode}'); // Logging response status
      print('Response body: ${response.body}'); // Logging response body

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction created successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create transaction')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Pesanan'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _customerNIKController,
                decoration: const InputDecoration(labelText: 'Customer NIK'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter NIK';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _customerNameController,
                decoration: const InputDecoration(labelText: 'Customer Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _customerPhoneController,
                decoration: const InputDecoration(labelText: 'Customer Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _customerAddressController,
                decoration:
                    const InputDecoration(labelText: 'Customer Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _rentDateController,
                decoration: const InputDecoration(labelText: 'Rent Date'),
                onTap: () => _selectDate(context, _rentDateController),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter rent date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _paymentDateController,
                decoration: const InputDecoration(labelText: 'Payment Date'),
                onTap: () => _selectDate(context, _paymentDateController),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter payment date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['paid', 'unpaid'].map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select status';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _totalController,
                decoration: const InputDecoration(labelText: 'Total'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Rent Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 8.0),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _rentDetails.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _rentDetails[index]['nopol'],
                            decoration:
                                const InputDecoration(labelText: 'No. Pol'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter No. Pol';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _rentDetails[index]['lama_sewa'],
                            decoration: const InputDecoration(
                              labelText: 'Lama Sewa (hari)',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Lama Sewa';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _rentDetails[index]['tgl_pengembalian'],
                            decoration: const InputDecoration(
                              labelText: 'Tgl Pengembalian',
                            ),
                            onTap: () => _selectDate(context,
                                _rentDetails[index]['tgl_pengembalian']!),
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Tgl Pengembalian';
                              }
                              return null;
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle),
                            onPressed: () => _removeRentDetail(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _addRentDetail,
                child: const Text('Add Rent Detail'),
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
