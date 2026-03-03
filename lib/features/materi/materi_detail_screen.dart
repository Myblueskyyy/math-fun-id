import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/models/materi.dart';
import '../../shared/widgets/custom_card.dart';

class MateriDetailScreen extends StatelessWidget {
  final Materi materi;

  const MateriDetailScreen({super.key, required this.materi});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                materi.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Container(color: materi.color),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  'Penjelasan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  materi.content,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: isDark ? Colors.white70 : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Rumus Utama',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                ...materi.formulas.entries.map(
                  (entry) => _buildFormulaRow(context, entry.key, entry.value),
                ),
                const SizedBox(height: 32),
                Text(
                  'Contoh Soal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                ...materi.examples.map((ex) => _buildExampleCard(context, ex)),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormulaRow(BuildContext context, String label, String formula) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.grey.shade200,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white54 : AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              formula,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: materi.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard(BuildContext context, ExampleQuestion ex) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CustomCard(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.help_outline_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Soal',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ex.question,
              style: TextStyle(
                fontSize: 15,
                color: isDark ? Colors.white : AppColors.textPrimary,
              ),
            ),
            Divider(height: 24, color: isDark ? Colors.white10 : null),
            Row(
              children: [
                const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Colors.orange,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Penyelesaian',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ex.solution,
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: isDark ? Colors.white70 : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
