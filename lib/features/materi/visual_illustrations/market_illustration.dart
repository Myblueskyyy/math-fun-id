import 'package:flutter/material.dart';

class MarketVisualIllustration extends StatelessWidget {
  const MarketVisualIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.visibility_rounded,
                color: Colors.blue,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                'Ilustrasi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.blue.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPerson(
                Icons.person_outline_rounded,
                'Pedagang',
                Colors.orange,
                isDark,
                'Beli: Rp10rb',
              ),
              Expanded(
                child: Column(
                  children: [
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.blue,
                      size: 32,
                    ),
                    const SizedBox(height: 4),
                    const Icon(
                      Icons.menu_book_rounded,
                      color: Colors.brown,
                      size: 40,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Dijual\nRp12rb',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? Colors.blue.shade200
                            : Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              _buildPerson(
                Icons.face_rounded,
                'Pembeli',
                Colors.green,
                isDark,
                'Bayar: Rp12rb',
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Pedagang awalnya mengeluarkan modal Rp10.000 (Harga Beli) untuk buku tersebut. Lalu, pembeli membayar Rp12.000 (Harga Jual) untuk mendapatkannya.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white70 : Colors.blue.shade900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerson(
    IconData icon,
    String role,
    Color color,
    bool isDark,
    String actionText,
  ) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color, size: 36),
        ),
        const SizedBox(height: 8),
        Text(
          role,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.5)),
          ),
          child: Text(
            actionText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
