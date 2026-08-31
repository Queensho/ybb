import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';

class AboutQuestionScreen extends StatefulWidget {
  const AboutQuestionScreen({super.key});

  @override
  State<AboutQuestionScreen> createState() => _AboutQuestionScreenState();
}

class _AboutQuestionScreenState extends State<AboutQuestionScreen> {
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    const black = Color(0xFF090712);
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Column(
          children: [
            const _AboutHero(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  context.tokens.spaceLg,
                  18,
                  context.tokens.spaceLg,
                  120,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Daha önce evlendiniz mi?',
                      style: context.texts.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        height: 1.08,
                      ),
                    ),
                    const SizedBox(height: 22),
                    _AnswerCard(
                      label: 'Evet',
                      selected: selectedAnswer == 'Evet',
                      onTap: () => setState(() => selectedAnswer = 'Evet'),
                    ),
                    const SizedBox(height: 12),
                    _AnswerCard(
                      label: 'Hayır',
                      selected: selectedAnswer == 'Hayır',
                      onTap: () => setState(() => selectedAnswer = 'Hayır'),
                    ),
                  ],
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
            onPressed: selectedAnswer == null ? null : () {},
            style: FilledButton.styleFrom(
              backgroundColor: context.tokens.lime,
              foregroundColor: black,
              disabledBackgroundColor: const Color(0xFF221B30),
              disabledForegroundColor: const Color(0xFF6E6878),
            ),
            child: const Text(
              'Kaydet ve devam et',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class _AboutHero extends StatelessWidget {
  const _AboutHero();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      width: double.infinity,
      child: ClipPath(
        clipper: _OvalBottomClipper(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF9A4DFF), Color(0xFF6D21D7), Color(0xFF45108D)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 16,
                top: 14,
                child: IconButton.filledTonal(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
              ),
              Positioned(
                right: 22,
                top: 20,
                child: Text(
                  '%17',
                  style: context.texts.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Positioned(
                left: 28,
                right: 28,
                top: 82,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hakkımda',
                      style: context.texts.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'SORU 1 / 6',
                      style: context.texts.labelLarge?.copyWith(
                        color: context.tokens.lime,
                        fontWeight: FontWeight.w800,
                        letterSpacing: .5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: .17,
                        minHeight: 7,
                        backgroundColor: Colors.white.withOpacity(.16),
                        valueColor: AlwaysStoppedAnimation<Color>(context.tokens.lime),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          color: selected ? context.tokens.lime.withOpacity(.10) : const Color(0xFF14101D),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? context.tokens.lime : const Color(0xFF31283D),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
              color: selected ? context.tokens.lime : const Color(0xFF8E8798),
              size: 30,
            ),
            const SizedBox(width: 14),
            Text(
              label,
              style: context.texts.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OvalBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 54);
    path.quadraticBezierTo(
      size.width * .5,
      size.height + 28,
      size.width,
      size.height - 54,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
