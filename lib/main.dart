import 'package:flutter/material.dart';

void main() {
  runApp(const Kalkulator());
}

// Widget utama (root)
class Kalkulator extends StatelessWidget {
  const Kalkulator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TampilanKalkulator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Scaffold
class TampilanKalkulator extends StatefulWidget {
  const TampilanKalkulator({super.key});

  @override
  State<TampilanKalkulator> createState() => _TampilanKalkulatorState();
}

class _TampilanKalkulatorState extends State<TampilanKalkulator> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  double? scoreBMI;
  String kategori = "Masukkan data terlebih dahulu";
  String? jenisKelamin;

  // Fungsi reset data
  void resetData() {
    setState(() {
      _bbController.clear();
      _tbController.clear();
      jenisKelamin = null;
      scoreBMI = null;
      kategori = "Masukkan data terlebih dahulu";
    });
  }

  // Fungsi menghitung BMI
  void hitungBMI() {
    double berat = double.tryParse(_bbController.text) ?? 0;
    double tinggi = double.tryParse(_tbController.text) ?? 0;

    setState(() {
      if (berat > 0 && tinggi > 0) {
        double bmi = berat / ((tinggi / 100) * (tinggi / 100));
        scoreBMI = bmi;

        if (jenisKelamin == "Laki-laki") {
          if (bmi < 18.5) {
            kategori = "Begang";
          } else if (bmi < 24.9) {
            kategori = "Normal";
          } else if (bmi < 29.9) {
            kategori = "Andatos Bukan Golongan Kamitos";
          } else {
            kategori = "Obesitas";
          }
        } else if (jenisKelamin == "Perempuan") {
          if (bmi < 17.5) {
            kategori = "Begang";
          } else if (bmi < 23.9) {
            kategori = "Normal";
          } else if (bmi < 28.9) {
            kategori = "Kelebihan berat badan";
          } else {
            kategori = "Andatos Bukan Golongan Kamitos";
          }
        } else {
          kategori = "Pilih jenis kelamin dahulu";
        }
      } else {
        kategori = "Data yang diinputkan salah";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplikasi Hitung BMI"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            
            TextField(
              controller: _bbController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Berat Badan (kg)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            
            TextField(
              controller: _tbController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Tinggi Badan (cm)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: "Laki-laki",
                  groupValue: jenisKelamin,
                  onChanged: (value) {
                    setState(() {
                      jenisKelamin = value;
                    });
                  },
                ),
                Text("Laki-laki"),
                SizedBox(width: 20),
                Radio<String>(
                  value: "Perempuan",
                  groupValue: jenisKelamin,
                  onChanged: (value) {
                    setState(() {
                      jenisKelamin = value;
                    });
                  },
                ),
              Text("Perempuan"),
              ],
            ),
            SizedBox(height: 15),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: hitungBMI,
                  icon: const Icon(Icons.calculate),
                  label: const Text("Hitung"),
                ),
                ElevatedButton.icon(
                  onPressed: resetData,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Reset"),
                ),
              ],
            ),
            const SizedBox(height: 20),

          
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      scoreBMI?.toStringAsFixed(1) ?? "0.0",
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      kategori,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
