import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class DiskonSimulation extends StatefulWidget {
  const DiskonSimulation({super.key});

  @override
  State<DiskonSimulation> createState() => _DiskonSimulationState();
}

class _DiskonSimulationState extends State<DiskonSimulation> {
  double _hargaAwal = 100000;
  double _diskonPercent = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final diskonAmount = _hargaAwal * (_diskonPercent / 100);
    final hargaAkhir = _hargaAwal - diskonAmount;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.1),
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
              const Icon(
                Icons.local_offer_rounded,
                color: Colors.orange,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                'Simulasi Diskon',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Visual Representation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildPriceBox(
                'Harga Awal',
                _hargaAwal,
                Colors.grey,
                isDark,
                strikethrough: _diskonPercent > 0,
              ),
              Icon(
                Icons.arrow_forward_rounded,
                color: isDark ? Colors.white54 : Colors.grey,
              ),
              _buildPriceBox(
                'Harga Akhir',
                hargaAkhir,
                Colors.orange,
                isDark,
                isHighlight: true,
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Interactive Controls
          Text(
            'Atur Harga Awal: Rp ${_hargaAwal.toStringAsFixed(0)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
          ),
          Slider(
            value: _hargaAwal,
            min: 10000,
            max: 1000000,
            divisions: 99,
            activeColor: Colors.blue,
            onChanged: (val) {
              setState(() {
                _hargaAwal = val;
              });
            },
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tarik Diskon:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_diskonPercent.toInt()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Slider(
            value: _diskonPercent,
            min: 0,
            max: 90,
            divisions: 18, // Steps of 5%
            activeColor: Colors.orange,
            inactiveColor: Colors.orange.withOpacity(0.2),
            onChanged: (val) {
              setState(() {
                _diskonPercent = val;
              });
            },
          ),

          // Savings banner
          if (_diskonPercent > 0)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.savings_rounded, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Hore! Kamu hemat Rp ${diskonAmount.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPriceBox(
    String label,
    double price,
    Color color,
    bool isDark, {
    bool strikethrough = false,
    bool isHighlight = false,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white54 : AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isHighlight
                ? color.withOpacity(0.1)
                : (isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade100),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHighlight ? color : Colors.transparent,
              width: isHighlight ? 2 : 0,
            ),
          ),
          child: Text(
            'Rp ${price.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: isHighlight ? 18 : 16,
              fontWeight: FontWeight.bold,
              decoration: strikethrough
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: strikethrough
                  ? (isDark ? Colors.white38 : Colors.grey)
                  : (isHighlight
                        ? color
                        : (isDark ? Colors.white : AppColors.textPrimary)),
            ),
          ),
        ),
      ],
    );
  }
}
