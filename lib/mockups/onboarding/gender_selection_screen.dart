import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';

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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                context.tokens.spaceLg,
                context.tokens.spaceMd,
                context.tokens.spaceLg,
                context.tokens.spaceXl,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - context.tokens.spaceXl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: context.colors.primary.withOpacity(.12),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: context.colors.primary.withOpacity(.22),
                            ),
                          ),
                          child: Text(
                            'ADIM 1 / 4',
                            style: context.texts.labelLarge?.copyWith(
                              color: context.colors.primary,
                              fontWeight: FontWeight.w800,
                              letterSpacing: .5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.tokens.spaceLg),
                    Container(
                      height: 178,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            context.colors.primary,
                            const Color(0xFF5521A8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(
                          context.tokens.radiusLg + 8,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x334E1A9E),
                            blurRadius: 28,
                            offset: Offset(0, 14),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          const Positioned(
                            left: -24,
                            top: -28,
                            child: _GlowOrb(size: 112, color: Color(0x55B7FF2A)),
                          ),
                          const Positioned(
                            right: -14,
                            bottom: -24,
                            child: _GlowOrb(size: 118, color: Color(0x558C45FF)),
                          ),
                          Center(
                            child: Container(
                              width: 112,
                              height: 112,
                              decoration: BoxDecoration(
                                color: const Color(0xFF130C21),
                                borderRadius: BorderRadius.circular(34),
                                border: Border.all(color: Colors.white.withOpacity(.10)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x66000000),
                                    blurRadius: 30,
                                    offset: Offset(12, 18),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.person_search_rounded,
                                size: 58,
                                color: Color(0xFFB7FF2A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.tokens.spaceLg),
                    Text(
                      'Seni nasıl tanımlayalım?',
                      style: context.texts.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        height: 1.05,
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
                          borderRadius: BorderRadius.circular(context.tokens.radiusLg),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? context.tokens.lime.withOpacity(.12)
                                  : context.colors.surfaceContainer,
                              borderRadius: BorderRadius.circular(context.tokens.radiusLg),
                              border: Border.all(
                                color: isSelected
                                    ? context.tokens.lime
                                    : context.colors.outlineVariant,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? context.tokens.lime
                                        : context.colors.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    option.$2,
                                    color: isSelected
                                        ? const Color(0xFF100B1E)
                                        : context.colors.onSurfaceVariant,
                                  ),
                                ),
                                SizedBox(width: context.tokens.spaceMd),
                                Expanded(
                                  child: Text(
                                    option.$1,
                                    style: context.texts.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 180),
                                  child: isSelected
                                      ? Icon(
                                          Icons.check_circle_rounded,
                                          key: ValueKey(option.$1),
                                          color: context.tokens.lime,
                                        )
                                      : Icon(
                                          Icons.radio_button_unchecked_rounded,
                                          key: ValueKey('empty-${option.$1}'),
                                          color: context.colors.outline,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: context.tokens.spaceMd),
                    Row(
                      children: const [
                        _StepBar(active: true),
                        _StepBar(),
                        _StepBar(),
                        _StepBar(),
                      ],
                    ),
                    SizedBox(height: context.tokens.spaceLg),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: selectedGender == null ? null : () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: context.tokens.lime,
                          foregroundColor: const Color(0xFF100B1E),
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
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
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
          color: active
              ? context.tokens.lime
              : context.colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}
