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
  bool _heroVisible = true;
  double _dragDistance = 0;

  static const questions = <_QuestionData>[
    _QuestionData(title: 'Daha önce evlendiniz mi?', options: ['Evet', 'Hayır'], icon: Icons.favorite_rounded),
    _QuestionData(title: 'Çocuğunuz var mı?', options: ['Evet', 'Hayır'], icon: Icons.child_care_rounded),
    _QuestionData(title: 'Gelecekte çocuk sahibi olmak ister misiniz?', options: ['Kesinlikle istemiyorum', 'İstemiyorum', 'Kararsızım', 'İstiyorum', 'Kesinlikle istiyorum'], icon: Icons.family_restroom_rounded),
    _QuestionData(title: 'Ne sıklıkla sigara kullanırsınız?', options: ['Hiç', 'Çok nadir', 'Ara sıra', 'Sık', 'Çok sık'], icon: Icons.smoking_rooms_rounded),
    _QuestionData(title: 'Ne sıklıkla alkol kullanırsınız?', options: ['Hiç', 'Çok nadir', 'Ara sıra', 'Sık', 'Çok sık'], icon: Icons.local_bar_rounded),
    _QuestionData(title: 'Tamamladığınız en yüksek eğitim düzeyi nedir?', options: ['İlköğretim', 'Lise', 'Ön lisans / Lisans', 'Yüksek lisans', 'Doktora'], icon: Icons.school_rounded),
  ];

  String? get selectedAnswer => answers[currentIndex];
  bool get isLastQuestion => currentIndex == questions.length - 1;

  void _goBack() {
    if (currentIndex == 0) { Navigator.of(context).pop(); return; }
    setState(() => currentIndex--);
  }

  void _continue() {
    if (selectedAnswer == null) return;
    if (!isLastQuestion) { setState(() => currentIndex++); return; }
    Navigator.of(context).pushReplacement(MaterialPageRoute<void>(builder: (_) => const PartnerPreferencesScreen()));
  }

  void _pointerMove(PointerMoveEvent event) {
    _dragDistance += event.delta.dy;
    if (_dragDistance < -60 && _heroVisible) {
      _dragDistance = 0;
      setState(() => _heroVisible = false);
    } else if (_dragDistance > 60 && !_heroVisible) {
      _dragDistance = 0;
      setState(() => _heroVisible = true);
    }
  }

  void _pointerEnd(PointerEvent event) => _dragDistance = 0;

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
        child: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerMove: _pointerMove,
          onPointerUp: _pointerEnd,
          onPointerCancel: _pointerEnd,
          child: Column(children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 650),
              curve: Curves.easeInOutCubic,
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: _heroVisible ? 220 : 0,
                width: double.infinity,
                child: ClipRect(
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 620),
                    curve: Curves.easeInOutCubic,
                    offset: _heroVisible ? Offset.zero : const Offset(0, -1.08),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 480),
                      curve: Curves.easeInOut,
                      opacity: _heroVisible ? 1 : 0,
                      child: _AboutHero(icon: question.icon, onBack: _goBack),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: black,
              padding: EdgeInsets.fromLTRB(context.tokens.spaceLg, _heroVisible ? 8 : 12, context.tokens.spaceLg, 14),
              child: Column(children: [
                if (!_heroVisible) Align(alignment: Alignment.centerLeft, child: IconButton.filledTonal(onPressed: _goBack, icon: const Icon(Icons.arrow_back_rounded))),
                Row(children: [
                  Text('SORU $step / ${questions.length}', style: context.texts.labelLarge?.copyWith(color: context.tokens.lime, fontWeight: FontWeight.w800, letterSpacing: .5)),
                  const Spacer(),
                  Text('%$percent', style: context.texts.labelLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
                ]),
                const SizedBox(height: 10),
                ClipRRect(borderRadius: BorderRadius.circular(999), child: LinearProgressIndicator(value: progress, minHeight: 7, backgroundColor: const Color(0xFF241B31), valueColor: AlwaysStoppedAnimation<Color>(context.tokens.lime))),
              ]),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: SingleChildScrollView(
                  key: ValueKey(currentIndex),
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(context.tokens.spaceLg, 16, context.tokens.spaceLg, 120),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Text(question.title, style: context.texts.headlineLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w900, height: 1.08)),
                    const SizedBox(height: 22),
                    for (final option in question.options) ...[
                      _AnswerCard(label: option, selected: selectedAnswer == option, onTap: () => setState(() => answers[currentIndex] = option)),
                      const SizedBox(height: 12),
                    ],
                  ]),
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.fromLTRB(context.tokens.spaceLg, 10, context.tokens.spaceLg, 16),
        child: SizedBox(height: 58, child: FilledButton(
          onPressed: selectedAnswer == null ? null : _continue,
          style: FilledButton.styleFrom(backgroundColor: context.tokens.lime, foregroundColor: black, disabledBackgroundColor: const Color(0xFF221B30), disabledForegroundColor: const Color(0xFF6E6878)),
          child: Text(isLastQuestion ? 'Tamamla' : 'Kaydet ve devam et', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        )),
      ),
    );
  }
}

class _QuestionData {
  const _QuestionData({required this.title, required this.options, required this.icon});
  final String title; final List<String> options; final IconData icon;
}

class _AboutHero extends StatelessWidget {
  const _AboutHero({required this.icon, required this.onBack});
  final IconData icon; final VoidCallback onBack;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 220, width: double.infinity,
    child: ClipPath(clipper: _OvalBottomClipper(), child: Container(
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF9A4DFF), Color(0xFF6D21D7), Color(0xFF45108D)])),
      child: Stack(children: [
        Positioned(left: 16, top: 14, child: IconButton.filledTonal(onPressed: onBack, icon: const Icon(Icons.arrow_back_rounded))),
        Positioned(left: 28, top: 84, child: Text('Hakkımda', style: context.texts.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w900))),
        Positioned(right: 34, top: 46, child: Container(width: 104, height: 104, decoration: BoxDecoration(color: const Color(0xFF2A1255).withOpacity(.84), shape: BoxShape.circle, border: Border.all(color: Colors.white12), boxShadow: const [BoxShadow(color: Color(0x44000000), blurRadius: 22, offset: Offset(0, 12))]), child: Icon(icon, size: 54, color: context.tokens.lime))),
      ]),
    )),
  );
}

class _AnswerCard extends StatelessWidget {
  const _AnswerCard({required this.label, required this.selected, required this.onTap});
  final String label; final bool selected; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(24),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(color: selected ? context.tokens.lime.withOpacity(.10) : const Color(0xFF14101D), borderRadius: BorderRadius.circular(24), border: Border.all(color: selected ? context.tokens.lime : const Color(0xFF31283D), width: selected ? 2 : 1)),
      child: Row(children: [
        Icon(selected ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded, color: selected ? context.tokens.lime : const Color(0xFF8E8798), size: 30),
        const SizedBox(width: 14),
        Expanded(child: Text(label, style: context.texts.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w700))),
      ]),
    ),
  );
}

class _OvalBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()..lineTo(0, size.height - 46);
    path.quadraticBezierTo(size.width * .5, size.height + 22, size.width, size.height - 46);
    path..lineTo(size.width, 0)..close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
