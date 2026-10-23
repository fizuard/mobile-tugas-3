import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();
  
  double? _hasilBMI;
  String _keterangan = 'Silakan Masukkan Data Anda!';
  String _jenisKelamin = 'Laki-laki';

  void _hitungBMI() {
    final double bb = double.tryParse(_bbController.text) ?? 0;
    final double tbInCm = double.tryParse(_tbController.text) ?? 0;

    setState(() {
      if (bb > 0 && tbInCm > 0) {
        final double tbInM = tbInCm / 100;
        final double bmi = bb / (tbInM * tbInM);

        _hasilBMI = bmi;
        
        if (_jenisKelamin == 'Laki-laki') {
          if (bmi < 18.5) {
            _keterangan = 'Kurus (Kurus Pria)';
          } else if (bmi < 25) {
            _keterangan = 'Normal / Ideal (Pria)';
          } else if (bmi < 30) {
            _keterangan = 'Gemuk / Overweight (Pria)';
          } else {
            _keterangan = 'Obesitas (Pria)!!!';
          }
        } else {
          if (bmi < 18.5) {
            _keterangan = 'Kurus (Kurus Wanita)';
          } else if (bmi < 25) {
            _keterangan = 'Normal / Ideal (Wanita)';
          } else if (bmi < 30) {
            _keterangan = 'Gemuk / Overweight (Wanita)';
          } else {
            _keterangan = 'Obesitas (Wanita)!!!';
          }
        }
      } else {
        _hasilBMI = null;
        _keterangan = 'Masukkan Data Yang Valid!!!';
      }
    });
  }

  void _resetBMI() {
    setState(() {
      _bbController.clear();
      _tbController.clear();
      _hasilBMI = null;
      _keterangan = 'Silakan Masukkan Data Anda!';
      _jenisKelamin = 'Laki-laki';
    });
  }

  @override
  void dispose() {
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI', 
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        leading: const Icon(Icons.monitor_weight_rounded, color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Pilih Jenis Kelamin',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: 'Laki-laki',
                    label: Text('Laki-laki'),
                    icon: Icon(Icons.male),
                  ),
                  ButtonSegment(
                    value: 'Perempuan',
                    label: Text('Perempuan'),
                    icon: Icon(Icons.female),
                  ),
                ],
                selected: {_jenisKelamin},
                onSelectionChanged: (Set<String> newSelection) {
                  setState(() {
                    _jenisKelamin = newSelection.first;
                  });
                },
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _bbController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.monitor_weight, color: Colors.indigo),
                          labelText: 'Berat Badan (kg)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _tbController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.height, color: Colors.indigo),
                          labelText: 'Tinggi Badan (cm)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _hitungBMI,
                      icon: const Icon(Icons.calculate, color: Colors.white),
                      label: const Text(
                        'Hitung BMI',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _resetBMI,
                      icon: const Icon(Icons.refresh, color: Colors.redAccent),
                      label: const Text(
                        'Reset',
                        style: TextStyle(color: Colors.redAccent, fontSize: 16),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.redAccent),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Hasil BMI :',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  border: Border.all(color: Colors.indigo.shade200),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _hasilBMI?.toStringAsFixed(1) ?? '--',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _keterangan,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: _hasilBMI == null ? Colors.grey.shade700 : Colors.indigo.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Kategori untuk: $_jenisKelamin',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
