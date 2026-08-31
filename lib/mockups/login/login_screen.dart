import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: const [
                    _HeroArea(),
                    _LoginPanel(),
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

class _HeroArea extends StatelessWidget {
  const _HeroArea();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
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
          clipBehavior: Clip.none,
          children: [
            Positioned(left: -28, top: 38, child: _Orb(size: 118)),
            Positioned(right: 18, top: 36, child: _Small3DIcon(icon: Icons.chat_bubble_rounded, angle: .13)),
            Positioned(right: -22, bottom: 28, child: _Orb(size: 88)),
            Positioned(left: 28, bottom: 35, child: _Small3DIcon(icon: Icons.verified_user_rounded, angle: -.16)),
            const Center(child: _Phone3D()),
          ],
        ),
      ),
    );
  }
}

class _Phone3D extends StatelessWidget {
  const _Phone3D();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -.11,
      child: Container(
        width: 162,
        height: 236,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF30224C), Color(0xFF090611)],
          ),
          borderRadius: BorderRadius.circular(38),
          border: Border.all(color: Colors.white.withOpacity(.14), width: 2),
          boxShadow: const [
            BoxShadow(color: Color(0x66000000), blurRadius: 32, offset: Offset(16, 24)),
            BoxShadow(color: Color(0x557C2CFF), blurRadius: 32, offset: Offset(-10, -8)),
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 54,
                height: 7,
                decoration: BoxDecoration(color: const Color(0xFF050309), borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Center(
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(colors: [Color(0xFFC8FF49), Color(0xFF94F500)]),
                  boxShadow: const [BoxShadow(color: Color(0x779EFF00), blurRadius: 30, spreadRadius: 2)],
                ),
                child: const Icon(Icons.person_rounded, size: 54, color: Color(0xFF100B1E)),
              ),
            ),
            Positioned(
              right: 8,
              bottom: 18,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF8C45FF),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [BoxShadow(color: Color(0x77000000), blurRadius: 16, offset: Offset(5, 8))],
                ),
                child: const Icon(Icons.lock_rounded, color: Colors.white, size: 27),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Small3DIcon extends StatelessWidget {
  const _Small3DIcon({required this.icon, required this.angle});
  final IconData icon;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFB7FF2A), Color(0xFF8FE600)]),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [BoxShadow(color: Color(0x55000000), blurRadius: 20, offset: Offset(8, 12))],
        ),
        child: Icon(icon, size: 34, color: const Color(0xFF160B25)),
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
        gradient: RadialGradient(center: Alignment(-.35, -.4), colors: [Color(0xFFD9FF70), Color(0xFF9CF400), Color(0xFF6AB500)]),
        boxShadow: [BoxShadow(color: Color(0x449DFF00), blurRadius: 28, spreadRadius: 4)],
      ),
    );
  }
}

class _LoginPanel extends StatelessWidget {
  const _LoginPanel();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -22),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(context.tokens.spaceLg, 0, context.tokens.spaceLg, context.tokens.spaceLg),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(context.tokens.radiusLg + 12)),
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
                    gradient: const LinearGradient(colors: [Color(0xFFB7FF2A), Color(0xFF8FE600)]),
                    shape: BoxShape.circle,
                    border: Border.all(color: context.colors.surface, width: 7),
                    boxShadow: const [BoxShadow(color: Color(0x55000000), blurRadius: 18, offset: Offset(0, 8))],
                  ),
                  child: const Icon(Icons.phone_rounded, color: Color(0xFF100B1E), size: 30),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Giriş yap', style: context.texts.headlineLarge?.copyWith(fontWeight: FontWeight.w800)),
                  SizedBox(height: context.tokens.spaceSm),
                  Text('Telefon numaranızla devam edin', style: context.texts.titleLarge?.copyWith(color: context.colors.onSurfaceVariant)),
                  SizedBox(height: context.tokens.spaceXs),
                  Text('Ülkenizi seçin ve cep telefonu numaranızı girin.', style: context.texts.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant)),
                  SizedBox(height: context.tokens.spaceLg),
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: '5xx xxx xx xx',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: context.tokens.spaceMd, right: context.tokens.spaceSm),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          const Text('🇹🇷', style: TextStyle(fontSize: 22)),
                          SizedBox(width: context.tokens.spaceSm),
                          Text('+90', style: context.texts.bodyLarge?.copyWith(fontWeight: FontWeight.w700)),
                          const Icon(Icons.keyboard_arrow_down_rounded),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(height: context.tokens.spaceMd),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: context.tokens.lime, foregroundColor: context.colors.onSecondary),
                      onPressed: () {},
                      child: const Text('Doğrulama kodu gönder'),
                    ),
                  ),
                  SizedBox(height: context.tokens.spaceMd),
                  Row(children: [
                    Expanded(child: Divider(color: context.colors.outlineVariant)),
                    Padding(padding: EdgeInsets.symmetric(horizontal: context.tokens.spaceSm), child: Text('VEYA', style: context.texts.labelSmall?.copyWith(color: context.colors.onSurfaceVariant))),
                    Expanded(child: Divider(color: context.colors.outlineVariant)),
                  ]),
                  SizedBox(height: context.tokens.spaceMd),
                  SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.chat_bubble_outline_rounded), label: const Text('Başka bir yöntemle giriş yap'))),
                  SizedBox(height: context.tokens.spaceLg),
                  Row(children: [
                    Icon(Icons.shield_outlined, size: 18, color: context.tokens.lime),
                    SizedBox(width: context.tokens.spaceSm),
                    Expanded(child: Text('Numaranız güvende. Bilgileriniz asla paylaşılmaz.', style: context.texts.bodySmall?.copyWith(color: context.colors.onSurfaceVariant))),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
