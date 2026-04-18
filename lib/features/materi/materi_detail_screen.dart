import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/models/materi.dart';
import '../../shared/widgets/custom_card.dart';
import '../../core/widgets/bubbly_background.dart';
import 'visual_novel/data/story_data.dart';
import 'visual_novel/models/story_node.dart';
import 'visual_novel/presentation/vn_screen.dart';
import '../../core/utils/audio_controller.dart';

class MateriDetailScreen extends StatefulWidget {
  final Materi materi;

  const MateriDetailScreen({super.key, required this.materi});

  @override
  State<MateriDetailScreen> createState() => _MateriDetailScreenState();
}

class _MateriDetailScreenState extends State<MateriDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BubblyBackground(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 150.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.materi.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      "assets/images/bg-appbar.png",
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            widget.materi.color.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([..._buildContent(context)]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context) {
    return [
      const Text(
        'Konsep Dasar',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.surface,
        ),
      ),
      const SizedBox(height: 12),
      Text(
        widget.materi.content,
        style: const TextStyle(
          fontSize: 16,
          height: 1.6,
          color: AppColors.surface,
        ),
      ),
      const SizedBox(height: 24),

      // 1.5 Visual Novel Integration
      if (_hasVisualNovel(widget.materi.title)) ...[
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 24),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple.shade400,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
            ),
            onPressed: () {
              AudioController.instance.playButtonClick();
              _launchVisualNovel(context, widget.materi.title);
            },
            icon: const Icon(Icons.videogame_asset_rounded, size: 28),
            label: const Text(
              'Mainkan Cerita Interaktif',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],

      // 2. Visual Illustration
      if (widget.materi.visualIllustrationWidget != null)
        widget.materi.visualIllustrationWidget!(context),

      // 3. Case Study
      if (widget.materi.caseStudy != null) ...[
        const Text(
          'Studi Kasus di Kehidupan Nyata',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.surface,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.menu_book_rounded,
                color: Colors.amber,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.materi.caseStudy!,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],

      // 4. Interactive Simulation
      if (widget.materi.interactiveWidget != null) ...[
        const SizedBox(height: 8),
        const Text(
          'Simulasi Interaktif',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.surface,
          ),
        ),
        const SizedBox(height: 16),
        widget.materi.interactiveWidget!(context),
      ],

      const SizedBox(height: 32),

      const Text(
        'Rumus Utama',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.surface,
        ),
      ),
      const SizedBox(height: 12),
      ...widget.materi.formulas.entries.map(
        (entry) => _buildFormulaRow(context, entry.key, entry.value),
      ),
      const SizedBox(height: 32),
      const Text(
        'Contoh Soal',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.surface,
        ),
      ),
      const SizedBox(height: 16),
      ...widget.materi.examples.map((ex) => _buildExampleCard(context, ex)),
      const SizedBox(height: 40),
    ];
  }

  Widget _buildFormulaRow(BuildContext context, String label, String formula) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              formula,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: widget.materi.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard(BuildContext context, ExampleQuestion ex) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CustomCard(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.help_outline_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Soal',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ex.question,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),
            const Divider(height: 24),
            const Row(
              children: [
                Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Colors.orange,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Penyelesaian',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ex.solution,
              style: const TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _hasVisualNovel(String title) {
    return title == 'Jual-Beli' ||
        title == 'Untung-Rugi' ||
        title == 'Diskon' ||
        title == 'Pajak';
  }

  void _launchVisualNovel(BuildContext context, String title) {
    Map<String, StoryNode> storyData = {};
    if (title == 'Jual-Beli') {
      storyData = StoryData.getEpisode1();
    } else if (title == 'Untung-Rugi') {
      storyData = StoryData.getEpisode2();
    } else if (title == 'Diskon') {
      storyData = StoryData.getEpisode3();
    } else if (title == 'Pajak') {
      storyData = StoryData.getEpisode4();
    }

    if (storyData.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VnScreen(initialNode: storyData['start']!, storyNodes: storyData),
        ),
      );
    }
  }
}
