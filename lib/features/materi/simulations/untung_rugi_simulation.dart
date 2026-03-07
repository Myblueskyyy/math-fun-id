import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class UntungRugiSimulation extends StatefulWidget {
  const UntungRugiSimulation({super.key});

  @override
  State<UntungRugiSimulation> createState() => _UntungRugiSimulationState();
}

class _UntungRugiSimulationState extends State<UntungRugiSimulation> {
  double _hargaBeli = 50000;
  double _hargaJual = 50000;

  @override
  Widget build(BuildContext context) {
    // Logic for weighing scale tilt
    double selisih = _hargaJual - _hargaBeli;
    double panRotation = 0.0; // rotation angle in radians

    if (selisih > 0) {
      panRotation = 0.2; // Untung (right side heavier/down)
    } else if (selisih < 0) {
      panRotation = -0.2; // Rugi (left side heavier/down)
    }

    String status = "Impas";
    Color statusColor = Colors.orange;

    if (selisih > 0) {
      status = "Untung Rp ${selisih.abs().toStringAsFixed(0)}";
      statusColor = Colors.green;
    } else if (selisih < 0) {
      status = "Rugi Rp ${selisih.abs().toStringAsFixed(0)}";
      statusColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.balance_rounded, color: Colors.green, size: 28),
              const SizedBox(width: 8),
              const Text(
                'Timbangan Untung/Rugi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Animated Balance Scale
          SizedBox(
            height: 120,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Base
                Container(
                  width: 60,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.brown.shade800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // Pillar
                Container(width: 10, height: 100, color: Colors.brown.shade600),
                // Tilted Beam
                Positioned(
                  top: 20,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutBack,
                    transformAlignment: Alignment.center,
                    transform: Matrix4.rotationZ(panRotation),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // Beam
                        Container(
                          width: 200,
                          height: 8,
                          color: Colors.brown.shade800,
                        ),
                        // Left Pan (Beli)
                        Positioned(
                          left: -20,
                          top: 8,
                          child: _buildPan('Beli', Colors.orange),
                        ),
                        // Right Pan (Jual)
                        Positioned(
                          right: -20,
                          top: 8,
                          child: _buildPan('Jual', Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),

          // Status Box
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: statusColor.withOpacity(0.5)),
            ),
            child: Center(
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Sliders
          _buildSlider(
            'Harga Beli: Rp ${_hargaBeli.toStringAsFixed(0)}',
            _hargaBeli,
            Colors.orange,
            (val) => setState(() => _hargaBeli = val),
          ),
          const SizedBox(height: 12),
          _buildSlider(
            'Harga Jual: Rp ${_hargaJual.toStringAsFixed(0)}',
            _hargaJual,
            Colors.blue,
            (val) => setState(() => _hargaJual = val),
          ),
        ],
      ),
    );
  }

  Widget _buildPan(String label, Color color) {
    return Column(
      children: [
        // Ropes
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 2, height: 30, color: Colors.grey.shade400),
            const SizedBox(width: 36),
            Container(width: 2, height: 30, color: Colors.grey.shade400),
          ],
        ),
        // Pan
        Container(
          width: 50,
          height: 15,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    Color color,
    ValueChanged<double> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Slider(
          value: value,
          min: 10000,
          max: 100000,
          divisions: 45, // step of 2k
          activeColor: color,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
