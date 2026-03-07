class Choice {
  final String text;
  final String nextNodeId;

  Choice({required this.text, required this.nextNodeId});
}

enum InteractionType {
  none,
  miniCalculator,
  strategyCards,
  reportTable,
  statusCards,
  priceLabel,
  compareChallenge,
  strukDigital,
  numberSlider,
  imageDisplay,
}

class StoryNode {
  final String id;
  final String dialogue;
  final String speakerName;
  final String backgroundId; // Key for the background asset
  final String? characterLeftId; // Key for the left character asset
  final String? characterRightId; // Key for the right character asset
  final List<Choice> choices;
  final String? nextNodeId; // Null if it has choices or is the end
  final InteractionType interactionType;
  final Map<String, dynamic>? interactionData;

  StoryNode({
    required this.id,
    required this.dialogue,
    required this.speakerName,
    required this.backgroundId,
    this.characterLeftId,
    this.characterRightId,
    this.choices = const [],
    this.nextNodeId,
    this.interactionType = InteractionType.none,
    this.interactionData,
  });
}
