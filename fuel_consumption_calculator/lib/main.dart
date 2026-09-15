import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Consum Combustibil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2E7D32),
        scaffoldBackgroundColor: const Color(0xFFF4F6F5),
      ),
      home: const FuelCalculatorPage(),
    );
  }
}

class FuelCalculatorPage extends StatefulWidget {
  const FuelCalculatorPage({super.key});

  @override
  State<FuelCalculatorPage> createState() => _FuelCalculatorPageState();
}

class _FuelCalculatorPageState extends State<FuelCalculatorPage> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _fuelController = TextEditingController();

  String? _result;
  String? _error;

  void _calculateConsumption() {
    final double? distance = double.tryParse(
      _distanceController.text.replaceAll(',', '.'),
    );
    final double? fuel = double.tryParse(
      _fuelController.text.replaceAll(',', '.'),
    );

    setState(() {
      if (distance == null || fuel == null) {
        _result = null;
        _error = 'Introduceți valori numerice valide.';
      } else if (distance <= 0) {
        _result = null;
        _error = 'Distanța trebuie să fie mai mare ca 0.';
      } else {
        final double consumption = (fuel / distance) * 100;
        _result = consumption.toStringAsFixed(2);
        _error = null;
      }
    });
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _fuelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              children: [
                // Iconiță + titlu
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.local_gas_station_rounded,
                    size: 44,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Consum Combustibil',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Calculează consumul mediu al mașinii tale',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 28),

                // Card cu inputuri
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: _distanceController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Distanța parcursă',
                            hintText: 'ex: 450',
                            suffixText: 'km',
                            prefixIcon: const Icon(Icons.route_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _fuelController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Combustibil consumat',
                            hintText: 'ex: 32',
                            suffixText: 'litri',
                            prefixIcon: const Icon(
                              Icons.local_gas_station_outlined,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _calculateConsumption,
                            icon: const Icon(Icons.calculate_rounded),
                            label: const Text(
                              'Calculează',
                              style: TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Rezultat sau eroare
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: _result != null
                      ? Container(
                    key: const ValueKey('result'),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Consum mediu',
                          style: TextStyle(
                            fontSize: 14,
                            color: colorScheme.onPrimaryContainer
                                .withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$_result l/100km',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  )
                      : _error != null
                      ? Container(
                    key: const ValueKey('error'),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          color: Colors.red.shade400,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            _error!,
                            style: TextStyle(
                              color: Colors.red.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                      : const SizedBox.shrink(key: ValueKey('empty')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}