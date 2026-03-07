import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/story_node.dart';

class VnDialogueOverlay extends StatelessWidget {
  final StoryNode node;
  final VoidCallback onNext;
  final ValueChanged<Choice> onChoiceSelected;

  const VnDialogueOverlay({
    Key? key,
    required this.node,
    required this.onNext,
    required this.onChoiceSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Click area to advance dialogue if there are no choices and no interaction
        if (node.choices.isEmpty &&
            (node.interactionType == InteractionType.none ||
                node.interactionType == InteractionType.imageDisplay ||
                node.interactionType == InteractionType.strukDigital))
          GestureDetector(
            onTap: onNext,
            behavior: HitTestBehavior.opaque,
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

        // Interaction Overlay (Calculators, Cards, etc.)
        if (node.interactionType != InteractionType.none)
          _buildInteractionUI(context),

        // Dialogue Box at the bottom
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Choices (only if not handled by interaction or alongside it)
                if (node.choices.isNotEmpty &&
                    node.interactionType != InteractionType.miniCalculator &&
                    node.interactionType != InteractionType.strategyCards &&
                    node.interactionType != InteractionType.statusCards &&
                    node.interactionType != InteractionType.compareChallenge &&
                    node.interactionType != InteractionType.reportTable)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: node.choices.map((choice) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.9),
                              foregroundColor: Colors.black87,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => onChoiceSelected(choice),
                            child: Text(
                              choice.text,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                // Dialogue Box Container
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: node.interactionType == InteractionType.none
                        ? 120
                        : 80,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Speaker Name
                      if (node.speakerName.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            node.speakerName,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      // Dialogue Text
                      Text(
                        node.dialogue,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18,
                          height: 1.5,
                        ),
                      ),
                      // Next indicator
                      if (node.choices.isEmpty &&
                          node.interactionType == InteractionType.none)
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInteractionUI(BuildContext context) {
    switch (node.interactionType) {
      case InteractionType.miniCalculator:
        return _buildMiniCalculator(context);
      case InteractionType.strategyCards:
        return _buildStrategyCards(context);
      case InteractionType.reportTable:
        return _buildReportTable(context);
      case InteractionType.statusCards:
        return _buildStatusCards(context);
      case InteractionType.priceLabel:
        return _buildPriceLabel(context);
      case InteractionType.compareChallenge:
        return _buildCompareChallenge(context);
      case InteractionType.strukDigital:
        return _buildStrukDigital(context);
      case InteractionType.numberSlider:
        return _buildNumberSlider(context);
      case InteractionType.imageDisplay:
        return _buildImageDisplay(context);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildMiniCalculator(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.7),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Berapakah total modal yang dikeluarkan Bimo?",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 16),
            ...node.choices.map((choice) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade500,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () => onChoiceSelected(choice),
                  child: Text(
                    choice.text,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStrategyCards(BuildContext context) {
    final colors = [Colors.green, Colors.orange, Colors.red];
    return Align(
      alignment: const Alignment(0, -0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(node.choices.length, (index) {
          final choice = node.choices[index];
          final color = colors[index % colors.length];
          return GestureDetector(
            onTap: () => onChoiceSelected(choice),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.28,
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lightbulb_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    choice.text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildReportTable(BuildContext context) {
    final List<dynamic> rows = node.interactionData?['rows'] ?? [];
    return Align(
      alignment: const Alignment(0, -0.6),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFD2B48C), // Tan/Wood color
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF8B4513), width: 4),
          boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 15)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "LAPORAN PENJUALAN",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: const Color(0xFF5D2E0A),
              ),
            ),
            const SizedBox(height: 12),
            Table(
              border: TableBorder.all(color: const Color(0xFF8B4513)),
              children: [
                TableRow(
                  children: [
                    _buildTableCell("Item", isHeader: true),
                    _buildTableCell("Qty", isHeader: true),
                    _buildTableCell("Total", isHeader: true),
                  ],
                ),
                ...rows.map(
                  (row) => TableRow(
                    children: [
                      _buildTableCell(row['item']),
                      _buildTableCell(row['qty']),
                      _buildTableCell(row['price']),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: node.choices
                  .map(
                    (choice) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B4513),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => onChoiceSelected(choice),
                          child: Text(choice.text),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: const Color(0xFF5D2E0A),
        ),
      ),
    );
  }

  Widget _buildStatusCards(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: node.choices.map((choice) {
          final isUntung = choice.text == 'UNTUNG';
          final color = isUntung ? Colors.amber.shade600 : Colors.blue.shade900;
          return GestureDetector(
            onTap: () => onChoiceSelected(choice),
            child: Container(
              width: 160,
              height: 160,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color, color.withOpacity(0.7)],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isUntung
                        ? Icons.trending_up_rounded
                        : Icons.trending_down_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    choice.text,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPriceLabel(BuildContext context) {
    final data = node.interactionData ?? {};
    return Align(
      alignment: const Alignment(0, -0.4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 10),
              ],
            ),
            child: Column(
              children: [
                Text(
                  data['title'] ?? "",
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data['price'] ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.red,
                  ),
                ),
                Text(
                  data['diskon'] ?? "",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Rumus: ${data['formula']}",
                  style: GoogleFonts.inter(
                    fontStyle: FontStyle.italic,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompareChallenge(BuildContext context) {
    final data = node.interactionData ?? <String, dynamic>{};
    final item1 = Map<String, dynamic>.from(
      data['item1'] ?? <String, dynamic>{},
    );
    final item2 = Map<String, dynamic>.from(
      data['item2'] ?? <String, dynamic>{},
    );

    // Safety check for choices
    if (node.choices.length < 2) return const SizedBox.shrink();

    return Align(
      alignment: const Alignment(0, -0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildItemCompareCard(context, item1, node.choices[0], true),
          const SizedBox(width: 20),
          _buildItemCompareCard(context, item2, node.choices[1], false),
        ],
      ),
    );
  }

  Widget _buildItemCompareCard(
    BuildContext context,
    Map<String, dynamic> item,
    Choice choice,
    bool isLeft,
  ) {
    return GestureDetector(
      onTap: () => onChoiceSelected(choice),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            item['image'] != null
                ? Image.asset(
                    'assets/images/vn/${item['image']}',
                    height: 50,
                    fit: BoxFit.contain,
                  )
                : Icon(
                    isLeft ? Icons.rocket_launch : Icons.shopping_bag,
                    size: 40,
                    color: Colors.blue,
                  ),
            const SizedBox(height: 8),
            Text(
              item['name'] ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            Text(
              item['diskon'] ?? "",
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Text(
              "Harga Akhir:\n${item['final']}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStrukDigital(BuildContext context) {
    final data = node.interactionData ?? {};
    final List<dynamic> items = data['items'] ?? [];
    return Align(
      alignment: const Alignment(0, -0.5),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "STRUK PEMBAYARAN",
              style: GoogleFonts.courierPrime(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Text("-------------------------"),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item['name'], style: GoogleFonts.courierPrime()),
                    Text(item['price'], style: GoogleFonts.courierPrime()),
                  ],
                ),
              ),
            ),
            const Text("-------------------------"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "PPN (${data['taxRate']})",
                  style: GoogleFonts.courierPrime(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data['taxAmount'],
                  style: GoogleFonts.courierPrime(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Text("========================="),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TOTAL",
                  style: GoogleFonts.courierPrime(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  data['total'],
                  style: GoogleFonts.courierPrime(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberSlider(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.4),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Geser untuk menjawab!",
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Icon(
              Icons.linear_scale_rounded,
              size: 40,
              color: Colors.blue.shade300,
            ),
            const SizedBox(height: 8),
            Text(
              "Pilih jawaban yang paling tepat di kotak bawah.",
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageDisplay(BuildContext context) {
    final data = node.interactionData ?? {};
    final image = data['image'] as String?;
    if (image == null) return const SizedBox.shrink();

    return Align(
      alignment: const Alignment(0, -0.4),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(
          'assets/images/vn/$image',
          width: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
