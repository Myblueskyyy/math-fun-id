import 'package:flutter/material.dart';

class AppleAdditionIllustration extends StatelessWidget {
  const AppleAdditionIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.apple, color: Colors.red, size: 28),
              const SizedBox(width: 8),
              Text(
                'Ilustrasi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildItem(Icons.apple, Colors.red, '1 Apel'),
              const Icon(Icons.add_circle, color: Colors.grey, size: 32),
              _buildItem(Icons.apple, Colors.red, '1 Apel'),
              const Icon(
                Icons.pause,
                color: Colors.grey,
                size: 32,
              ), // Equal sign abstraction
              _buildBasket(),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Jika kamu punya 1 apel, lalu ditambahkan 1 apel lagi, maka total apel di keranjangmu menjadi 2 buah apel.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.red.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, Color color, String label) {
    return Column(
      children: [
        Icon(icon, color: color, size: 48),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildBasket() {
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 50,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const Positioned(
                left: 5,
                bottom: 15,
                child: Icon(Icons.apple, color: Colors.red, size: 28),
              ),
              const Positioned(
                right: 5,
                bottom: 15,
                child: Icon(Icons.apple, color: Colors.red, size: 28),
              ),
              Icon(
                Icons.shopping_basket_rounded,
                color: Colors.orange.shade700,
                size: 48,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '2 Apel',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }
}
