import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';
import 'partner_preferences_screen.dart';

class AboutQuestionScreen extends StatefulWidget {
  const AboutQuestionScreen({super.key});

  @override
  State<AboutQuestionScreen> createState() => _AboutQuestionScreenState();
}

class _AboutQuestionScreenState extends State<AboutQuestionScreen> {
  int currentIndex = 0;
  final Map<int, String> answers = {};

  static const questions = <_QuestionData>[
    _QuestionData(title: 'Daha önce evlendiniz mi?', options: ['Evet', 'Hayır']),
    _QuestionData(title: 'Çocuğunuz var mı?', options: ['Evet', 'Hayır']),
    _QuestionData(title: 'Gelecekte çocuk sahibi olmak ister misiniz?', options: ['Kesinlikle istemiyorum', 'İstemiyorum', 'Kararsızım', 'İstiyorum', 'Kesinlikle istiyorum']),
    _QuestionData(title: 'Ne sıklıkla sigara kullanırsınız?', options: ['Hiç', 'Çok nadir', 'Ara sıra', 'Sık', 'Çok sık']),
    _QuestionData(title: 'Ne sıklıkla alkol kullanırsınız?', options: ['Hiç', 'Çok nadir', 'Ara sıra', 'Sık', 'Çok sık']),
    _QuestionData(title: 'Tamamladığınız en yüksek eğitim düzeyi nedir?', options: ['İlköğretim', 'Lise', 'Ön lisans / Lisans', 'Yüksek lisans', 'Doktora']),
  ];

  String? get selectedAnswer => answers[currentIndex];
  bool get isLastQuestion => currentIndex == questions.length - 1;

  void _goBack() {
    if (currentIndex == 0) {
      Navigator.of(context).pop();
      return;
    }
    setState(() => currentIndex--);
  }

  void _continue() {
    if (selectedAnswer == null) return;
    if (!isLastQuestion) {
      setState(() => currentIndex++);
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const PartnerPreferencesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const black = Color(0xFF090712);
    final question = questions[currentIndex];
    final step = currentIndex + 1;
    final progress = step / questions.length;
    final percent = (progress * 100).round();

    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.tokens.spaceLg,
                18,
                context.tokens.spaceLg,
                12,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton.filledTonal(
                      onPressed: _goBack,
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'SORU $step / ${questions.length}',
                        style: context.texts.labelLarge?.copyWith(
                          color: context.tokens.lime,
                          fontWeight: FontWeight.w900,
                          letterSpacing: .5,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '%$percent',
                        style: context.texts.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 7,
                      backgroundColor: const Color(0xFF241B31),
                      valueColor: AlwaysStoppedAnimation<Color>(context.tokens.lime),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: SingleChildScrollView(
                  key: ValueKey(currentIndex),
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    context.tokens.spaceLg,
                    30,
                    context.tokens.spaceLg,
                    120,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        question.title,
                        style: context.texts.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          height: 1.08,
                        ),
                      ),
                      const SizedBox(height: 34),
                      for (final option in question.options) ...[
                        _AnswerCard(
                          label: option,
                          selected: selectedAnswer == option,
                          onTap: () => setState(
                            () => answers[currentIndex] = option,
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.fromLTRB(
          context.tokens.spaceLg,
          10,
          context.tokens.spaceLg,
          16,
        ),
        child: SizedBox(
          height: 58,
          child: FilledButton(
            onPressed: selectedAnswer == null ? null : _continue,
            style: FilledButton.styleFrom(
              backgroundColor: context.tokens.lime,
              foregroundColor: black,
              disabledBackgroundColor: const Color(0xFF221B30),
              disabledForegroundColor: const Color(0xFF6E6878),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            child: Text(
              isLastQuestion ? 'Tamamla' : 'Kaydet ve devam et',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuestionData {
  const _QuestionData({required this.title, required this.options});

  final String title;
  final List<String> options;
}

class _AnswerCard extends StatelessWidget {
  const _AnswerCard({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          decoration: BoxDecoration(
            color: selected
                ? context.tokens.lime.withOpacity(.10)
                : const Color(0xFF14101D),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: selected ? context.tokens.lime : const Color(0xFF31283D),
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: selected
                    ? context.tokens.lime
                    : const Color(0xFF8E8798),
                size: 30,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: context.texts.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
