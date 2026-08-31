import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';

class WelcomeIntroScreen extends StatelessWidget {
  const WelcomeIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                context.tokens.spaceLg,
                context.tokens.spaceLg,
                context.tokens.spaceLg,
                context.tokens.spaceXl,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight - context.tokens.spaceXl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: context.colors.primary.withOpacity(.12),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: context.colors.primary.withOpacity(.22)),
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
                        const Spacer(),
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: context.colors.surfaceContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close_rounded, color: context.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                    SizedBox(height: context.tokens.spaceLg),
                    _HeroCard(),
                    SizedBox(height: context.tokens.spaceLg),
                    Text(
                      'Hoş geldiniz',
                      style: context.texts.labelLarge?.copyWith(
                        color: context.tokens.lime,
                        fontWeight: FontWeight.w800,
                        letterSpacing: .3,
                      ),
                    ),
                    SizedBox(height: context.tokens.spaceSm),
                    Text(
                      'Sizi biraz tanıyalım',
                      style: context.texts.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        height: 1.05,
                      ),
                    ),
                    SizedBox(height: context.tokens.spaceMd),
                    Text(
                      'Önce cinsiyet bilginizi, ardından sizinle ilgili birkaç temel soru soracağız. Son adımda sizin için en önemli iki partner tercihini seçebileceksiniz. Cevaplarınız, eşleşme raporlarının daha doğru hazırlanmasına yardımcı olur.',
                      style: context.texts.bodyLarge?.copyWith(
                        color: context.colors.onSurfaceVariant,
                        height: 1.55,
                      ),
                    ),
                    SizedBox(height: context.tokens.spaceLg),
                    Container(
                      padding: EdgeInsets.all(context.tokens.spaceMd),
                      decoration: BoxDecoration(
                        color: context.colors.surfaceContainer,
                        borderRadius: BorderRadius.circular(context.tokens.radiusLg),
                        border: Border.all(color: context.colors.outlineVariant.withOpacity(.6)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: context.colors.primary.withOpacity(.12),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(Icons.info_outline_rounded, color: context.colors.primary),
                          ),
                          SizedBox(width: context.tokens.spaceMd),
                          Expanded(
                            child: Text(
                              'Daha sonra profilinizdeki “Hakkımda” bölümünden cevaplarınızı yeniden görebilir ve değiştirebilirsiniz. Bu seçeneğin sunulduğu sorularda “Cevap vermek istemiyorum” seçeneğini kullanabilirsiniz.',
                              style: context.texts.bodyMedium?.copyWith(
                                color: context.colors.onSurfaceVariant,
                                height: 1.48,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.tokens.spaceLg),
                    Row(
                      children: [
                        _StepDot(active: true),
                        _StepDot(),
                        _StepDot(),
                        _StepDot(),
                      ],
                    ),
                    SizedBox(height: context.tokens.spaceLg),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: context.tokens.lime,
                          foregroundColor: const Color(0xFF100B1E),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Hazırsanız başlayalım'),
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

class _HeroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [context.colors.primary, const Color(0xFF5521A8)],
        ),
        borderRadius: BorderRadius.circular(context.tokens.radiusLg + 8),
        boxShadow: const [
          BoxShadow(color: Color(0x334E1A9E), blurRadius: 28, offset: Offset(0, 14)),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: -24,
            top: -18,
            child: _Blob(size: 110, color: const Color(0x33B7FF2A)),
          ),
          Positioned(
            right: -18,
            bottom: -22,
            child: _Blob(size: 120, color: const Color(0x338C45FF)),
          ),
          Center(
            child: Container(
              width: 118,
              height: 118,
              decoration: BoxDecoration(
                color: const Color(0xFF130C21),
                borderRadius: BorderRadius.circular(34),
                border: Border.all(color: Colors.white.withOpacity(.10)),
                boxShadow: const [
                  BoxShadow(color: Color(0x66000000), blurRadius: 30, offset: Offset(12, 18)),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.waving_hand_rounded, size: 58, color: Color(0xFFB7FF2A)),
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFF8C45FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.favorite_rounded, size: 17, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({this.active = false});
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
