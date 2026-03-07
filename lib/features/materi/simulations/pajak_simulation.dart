import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PajakSimulation extends StatefulWidget {
  const PajakSimulation({super.key});

  @override
  State<PajakSimulation> createState() => _PajakSimulationState();
}

class _PajakSimulationState extends State<PajakSimulation>
    with SingleTickerProviderStateMixin {
  double _hargaBarang = 50000;
  bool _includePajak = false;

  late AnimationController _stampController;
  late Animation<double> _stampScale;
  late Animation<double> _stampOpacity;

  @override
  void initState() {
    super.initState();
    _stampController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _stampScale = Tween<double>(begin: 2.0, end: 1.0).animate(
      CurvedAnimation(parent: _stampController, curve: Curves.bounceOut),
    );

    _stampOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _stampController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _stampController.dispose();
    super.dispose();
  }

  void _togglePajak(bool value) {
    setState(() {
      _includePajak = value;
    });

    if (value) {
      _stampController.reset();
      _stampController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pajakAmount = _includePajak ? _hargaBarang * 0.11 : 0.0; // PPN 11%
    final totalBayar = _hargaBarang + pajakAmount;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            children: [
              Icon(Icons.receipt_long_rounded, color: Colors.red, size: 28),
              SizedBox(width: 8),
              Text(
                'Simulasi Kasir (Pajak PPN 11%)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          const Text(
            'Harga Makanan/Barang:',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          Slider(
            value: _hargaBarang,
            min: 10000,
            max: 500000,
            divisions: 49,
            activeColor: Colors.blue,
            onChanged: (val) {
              setState(() {
                _hargaBarang = val;
              });
            },
          ),
          Text(
            'Rp ${_hargaBarang.toStringAsFixed(0)}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text(
              'Terapkan Pajak (PPN)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Misal: Makan di restoran'),
            value: _includePajak,
            activeColor: Colors.red,
            onChanged: _togglePajak,
            contentPadding: EdgeInsets.zero,
          ),

          const SizedBox(height: 24),

          // Receipt UI
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade300,
                style: BorderStyle.solid,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    const Text(
                      'Struk Belanja',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Divider(color: Colors.grey, thickness: 1, height: 24),
                    _buildReceiptRow('Harga Awal', _hargaBarang),
                    if (_includePajak)
                      _buildReceiptRow('PPN (11%)', pajakAmount, isTax: true),
                    const Divider(color: Colors.grey, thickness: 1, height: 24),
                    _buildReceiptRow('TOTAL', totalBayar, isTotal: true),
                  ],
                ),

                // Animated Stamp
                if (_includePajak)
                  Positioned(
                    right: 0,
                    top: 20,
                    child: AnimatedBuilder(
                      animation: _stampController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _stampScale.value,
                          child: Opacity(
                            opacity: _stampOpacity.value,
                            child: Transform.rotate(
                              angle: -0.2, // Tilted stamp
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  '+ PAJAK',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptRow(
    String label,
    double amount, {
    bool isTotal = false,
    bool isTax = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Courier',
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 14,
              color: isTax ? Colors.red : AppColors.textPrimary,
            ),
          ),
          Text(
            'Rp ${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontFamily: 'Courier',
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 14,
              color: isTax ? Colors.red : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
