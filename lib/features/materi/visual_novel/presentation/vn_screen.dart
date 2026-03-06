import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../flame/vn_game.dart';
import '../models/story_node.dart';
import 'vn_dialogue_overlay.dart';

class VnScreen extends StatefulWidget {
  final StoryNode initialNode;
  final Map<String, StoryNode> storyNodes; // Map of Node ID to StoryNode

  const VnScreen({
    Key? key,
    required this.initialNode,
    required this.storyNodes,
  }) : super(key: key);

  @override
  State<VnScreen> createState() => _VnScreenState();
}

class _VnScreenState extends State<VnScreen> {
  late VisualNovelGame _game;
  late StoryNode _currentNode;

  @override
  void initState() {
    super.initState();
    _currentNode = widget.initialNode;
    _game = VisualNovelGame();
    // Delay scene update to allow game to load slightly
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateGameScene();
    });
  }

  void _updateGameScene() {
    _game.updateScene(
      bgId: _currentNode.backgroundId,
      charLeftId: _currentNode.characterLeftId,
      charRightId: _currentNode.characterRightId,
    );
  }

  void _advanceNode(String? nextNodeId) {
    if (nextNodeId == null || !widget.storyNodes.containsKey(nextNodeId)) {
      // End of story
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _currentNode = widget.storyNodes[nextNodeId]!;
    });
    _updateGameScene();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: _game,
        overlayBuilderMap: {
          'dialogue': (context, VisualNovelGame game) {
            return VnDialogueOverlay(
              node: _currentNode,
              onNext: () {
                if (_currentNode.choices.isEmpty) {
                  _advanceNode(_currentNode.nextNodeId);
                }
              },
              onChoiceSelected: (Choice choice) {
                _advanceNode(choice.nextNodeId);
              },
            );
          },
        },
        initialActiveOverlays: const ['dialogue'],
      ),
    );
  }
}
