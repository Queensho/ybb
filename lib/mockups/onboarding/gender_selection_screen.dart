import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';
import 'about_question_screen.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String? selectedGender;

  static const options = [
    ('Kadın', Icons.female_rounded),
    ('Erkek', Icons.male_rounded),
    ('Non-binary', Icons.transgender_rounded),
    ('Cevap vermek istemiyorum', Icons.remove_circle_outline_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _CurvedGenderHero(onBack: () => Navigator.of(context).pop()),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.tokens.spaceLg,
                  16,
                  context.tokens.spaceLg,
                  context.tokens.spaceXl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Seni nasıl tanımlayalım?',
                      style: context.texts.headlineLarge?.copyWith(
                        color: context.colors.onSurface,
                        fontWeight: FontWeight.w900,
                        height: 1.04,
                      ),
                    ),
                    SizedBox(height: context.tokens.spaceSm),
                    Text(
                      'Cinsiyet bilgin, sana daha uygun eşleşmeler ve daha doğru profil önerileri sunmamıza yardımcı olur.',
                      style: context.texts.bodyLarge?.copyWith(
                        color: context.colors.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: context.tokens.spaceLg),
                    ...options.map((option) {
                      final isSelected = selectedGender == option.$1;
                      return Padding(
                        padding: EdgeInsets.only(bottom: context.tokens.spaceSm),
                        child: InkWell(
                          onTap: () => setState(() => selectedGender = option.$1),
                          borderRadius: BorderRadius.circular(22),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (context.isDark ? const Color(0xFF1A1527) : context.colors.primaryContainer.withOpacity(.35))
                                  : context.colors.surfaceContainer,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: isSelected ? context.tokens.lime : context.colors.outlineVariant,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: isSelected ? context.tokens.lime : context.colors.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    option.$2,
                                    color: isSelected ? context.colors.onSecondary : context.colors.onSurfaceVariant,
                                  ),
                                ),
                                SizedBox(width: context.tokens.spaceMd),
                                Expanded(
                                  child: Text(
                                    option.$1,
                                    style: context.texts.titleMedium?.copyWith(
                                      color: context.colors.onSurface,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Icon(
                                  isSelected ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                                  color: isSelected ? context.tokens.lime : context.colors.outline,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: context.tokens.spaceMd),
                    const Row(
                      children: [
                        _StepBar(active: true),
                        _StepBar(),
                        _StepBar(),
                        _StepBar(),
                      ],
                    ),
                    SizedBox(height: context.tokens.spaceLg),
                    FilledButton(
                      onPressed: selectedGender == null
                          ? null
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(builder: (_) => const AboutQuestionScreen()),
                              );
                            },
                      style: FilledButton.styleFrom(
                        backgroundColor: context.tokens.lime,
                        foregroundColor: context.colors.onSecondary,
                        disabledBackgroundColor: context.colors.surfaceContainerHighest,
                        disabledForegroundColor: context.colors.onSurfaceVariant,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Devam et'),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_rounded),
                        ],
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

class _CurvedGenderHero extends StatelessWidget {
  const _CurvedGenderHero({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
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
                left: 22,
                top: 20,
                child: IconButton.filledTonal(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
              ),
              Positioned(
                right: 22,
                top: 22,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                  decoration: BoxDecoration(
                    color: const Color(0x33210A45),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: const Text(
                    'ADIM 1 / 4',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 126,
                  height: 126,
                  decoration: BoxDecoration(
                    color: context.isDark ? const Color(0xFF130C21) : Colors.white,
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(color: Colors.white12),
                    boxShadow: const [
                      BoxShadow(color: Color(0x66000000), blurRadius: 28, offset: Offset(10, 16)),
                    ],
                  ),
                  child: const Icon(Icons.person_rounded, size: 66, color: Color(0xFFB7FF2A)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OvalBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 68);
    path.quadraticBezierTo(size.width * .5, size.height + 24, size.width, size.height - 68);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _StepBar extends StatelessWidget {
  const _StepBar({this.active = false});
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 5,
        margin: const EdgeInsets.only(right: 7),
        decoration: BoxDecoration(
          color: active ? context.tokens.lime : context.colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}
