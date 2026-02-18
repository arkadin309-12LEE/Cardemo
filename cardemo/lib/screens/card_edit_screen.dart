import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../database/database_helper.dart';
import '../models/card_model.dart';

class CardEditScreen extends StatefulWidget {
  final int? cardId;

  const CardEditScreen({super.key, this.cardId});

  @override
  State<CardEditScreen> createState() => _CardEditScreenState();
}

class _CardEditScreenState extends State<CardEditScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String? _imagePath;
  bool _isLoading = false;
  CardModel? _existingCard;

  bool get isEditMode => widget.cardId != null;

  @override
  void initState() {
    super.initState();
    if (isEditMode) {
      _loadCard();
    }
  }

  Future<void> _loadCard() async {
    setState(() => _isLoading = true);
    try {
      final cardData = await DatabaseHelper.instance.getCard(widget.cardId!);
      if (cardData != null) {
        _existingCard = CardModel.fromMap(cardData);
        _titleController.text = _existingCard!.title;
        _contentController.text = _existingCard!.content;
        _imagePath = _existingCard!.frontImage;
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
    setState(() => _isLoading = false);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imagePath = pickedFile.path);
    }
  }

  Future<void> _saveCard() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('제목을 입력해주세요')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final now = DateTime.now();
    final card = CardModel(
      id: _existingCard?.id,
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      frontImage: _imagePath,
      deckId: _existingCard?.deckId,
      createdAt: _existingCard?.createdAt ?? now,
      updatedAt: now,
    );

    try {
      if (isEditMode) {
        await DatabaseHelper.instance.updateCard(widget.cardId!, card.toMap());
      } else {
        await DatabaseHelper.instance.insertCard(card.toMap());
      }
      if (mounted) {
        context.go('/cards');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? '카드 수정' : '새 카드 작성'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isLoading ? null : _saveCard,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: '제목',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      labelText: '내용',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 10,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: const Text('이미지 추가'),
                  ),
                  if (_imagePath != null) ...[
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(_imagePath!),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: const Center(child: Text('이미지를 불러올 수 없습니다')),
                          );
                        },
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _saveCard,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(isEditMode ? '수정 완료' : '저장'),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
