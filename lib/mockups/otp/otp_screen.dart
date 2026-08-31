import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final controllers = List.generate(6, (_) => TextEditingController());
  final nodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final n in nodes) {
      n.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _OtpHero(onBack: () => Navigator.of(context).pop()),
              Transform.translate(
                offset: const Offset(0, -22),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    context.tokens.spaceLg,
                    0,
                    context.tokens.spaceLg,
                    context.tokens.spaceXl,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(context.tokens.radiusLg + 12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Transform.translate(
                          offset: const Offset(0, -34),
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFB7FF2A), Color(0xFF8FE600)],
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(color: context.colors.surface, width: 7),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x55000000),
                                  blurRadius: 18,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.mark_email_read_rounded,
                              color: Color(0xFF100B1E),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kodu doğrula',
                              style: context.texts.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: context.tokens.spaceSm),
                            Text(
                              '+90 5•• ••• •• •• numarasına gönderilen 6 haneli kodu gir.',
                              style: context.texts.bodyLarge?.copyWith(
                                color: context.colors.onSurfaceVariant,
                                height: 1.35,
                              ),
                            ),
                            SizedBox(height: context.tokens.spaceLg),
                            Row(
                              children: List.generate(6, (index) {
                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: index == 5 ? 0 : context.tokens.spaceSm,
                                    ),
                                    child: TextField(
                                      controller: controllers[index],
                                      focusNode: nodes[index],
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      maxLength: 1,
                                      style: context.texts.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.w800,
                                      ),
                                      decoration: const InputDecoration(
                                        counterText: '',
                                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                                      ),
                                      onChanged: (value) {
                                        if (value.isNotEmpty && index < 5) {
                                          nodes[index + 1].requestFocus();
                                        } else if (value.isEmpty && index > 0) {
                                          nodes[index - 1].requestFocus();
                                        }
                                      },
                                    ),
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: context.tokens.spaceLg),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: context.tokens.lime,
                                  foregroundColor: context.colors.onSecondary,
                                ),
                                onPressed: () {},
                                child: const Text('Doğrula ve devam et'),
                              ),
                            ),
                            SizedBox(height: context.tokens.spaceLg),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Kod gelmedi mi?',
                                    style: context.texts.bodyMedium?.copyWith(
                                      color: context.colors.onSurfaceVariant,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('Kodu tekrar gönder  00:42'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: context.tokens.spaceMd),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(context.tokens.spaceMd),
                              decoration: BoxDecoration(
                                color: context.colors.surfaceContainer,
                                borderRadius: BorderRadius.circular(context.tokens.radius),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.shield_rounded,
                                    color: context.tokens.lime,
                                  ),
                                  SizedBox(width: context.tokens.spaceSm),
                                  Expanded(
                                    child: Text(
                                      'Bu kod yalnızca hesabınızı doğrulamak için kullanılır.',
                                      style: context.texts.bodySmall?.copyWith(
                                        color: context.colors.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpHero extends StatelessWidget {
  const _OtpHero({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [context.colors.primary, const Color(0xFF5521A8)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 12,
              left: 12,
              child: IconButton.filledTonal(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            ),
            const Positioned(left: -22, bottom: 24, child: _Orb(size: 96)),
            const Positioned(right: -18, top: 54, child: _Orb(size: 78)),
            Center(
              child: Transform.rotate(
                angle: -.08,
                child: Container(
                  width: 180,
                  height: 145,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF352151), Color(0xFF0B0712)],
                    ),
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(color: Colors.white24),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x66000000),
                        blurRadius: 30,
                        offset: Offset(14, 20),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.sms_rounded,
                        size: 74,
                        color: Color(0xFFB7FF2A),
                      ),
                      Positioned(
                        right: 24,
                        bottom: 20,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF8C45FF),
                          ),
                          child: const Icon(
                            Icons.lock_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: Alignment(-.35, -.4),
          colors: [Color(0xFFD9FF70), Color(0xFF9CF400), Color(0xFF6AB500)],
        ),
        boxShadow: [
          BoxShadow(color: Color(0x449DFF00), blurRadius: 28, spreadRadius: 4),
        ],
      ),
    );
  }
}
