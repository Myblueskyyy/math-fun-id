import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';

class JualBeliSimulation extends StatefulWidget {
  const JualBeliSimulation({super.key});

  @override
  State<JualBeliSimulation> createState() => _JualBeliSimulationState();
}

class _JualBeliSimulationState extends State<JualBeliSimulation>
    with SingleTickerProviderStateMixin {
  final _hargaBeliController = TextEditingController();
  final _hargaJualController = TextEditingController();

  double? _hargaBeli;
  double? _hargaJual;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _hargaBeliController.dispose();
    _hargaJualController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _calculate() {
    if (_hargaBeliController.text.isEmpty ||
        _hargaJualController.text.isEmpty) {
      return;
    }

    setState(() {
      _hargaBeli = double.tryParse(
        _hargaBeliController.text.replaceAll('.', ''),
      );
      _hargaJual = double.tryParse(
        _hargaJualController.text.replaceAll('.', ''),
      );
    });

    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
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
              Icon(Icons.storefront_rounded, color: Colors.blue, size: 28),
              SizedBox(width: 8),
              Text(
                'Simulasi Pasar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  controller: _hargaBeliController,
                  label: 'Harga Beli (Rp)',
                  icon: Icons.shopping_cart_checkout_rounded,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInputField(
                  controller: _hargaJualController,
                  label: 'Harga Jual (Rp)',
                  icon: Icons.sell_rounded,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _calculate,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: const Text(
              'Simulasikan Transaksi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          if (_hargaBeli != null && _hargaJual != null) ...[
            const SizedBox(height: 24),
            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: _buildResult(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.normal,
        ),
        prefixIcon: Icon(icon, color: color),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color, width: 2),
        ),
      ),
    );
  }

  Widget _buildResult() {
    final status = _hargaJual! > _hargaBeli!
        ? 'Untung'
        : _hargaJual! < _hargaBeli!
        ? 'Rugi'
        : 'Impas';

    final selisih = (_hargaJual! - _hargaBeli!).abs();

    Color statusColor;
    IconData statusIcon;
    String message;

    if (status == 'Untung') {
      statusColor = Colors.green;
      statusIcon = Icons.trending_up_rounded;
      message = 'Hebat! Anda memenangkan transaksi ini.';
    } else if (status == 'Rugi') {
      statusColor = Colors.red;
      statusIcon = Icons.trending_down_rounded;
      message = 'Waduh, Anda mengalami kerugian. Coba sesuaikan harganya!';
    } else {
      statusColor = Colors.orange;
      statusIcon = Icons.compare_arrows_rounded;
      message = 'Impas! Balik modal.';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(statusIcon, color: statusColor, size: 36),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status: $status',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                  if (selisih > 0)
                    Text(
                      'Rp ${selisih.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
