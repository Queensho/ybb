import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/context_ext.dart';
import '../otp/otp_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              _HeroArea(),
              _LoginPanel(),
            ],
          ),
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
      height: 350,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [context.colors.primary, const Color(0xFF4B1597)],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(left: -46, top: 24, child: _Asset('assets/3d/07_lime_blob.svg', 150)),
            Positioned(right: -34, bottom: 20, child: _Asset('assets/3d/09_purple_blob.svg', 150)),
            Positioned(right: 18, top: 34, child: Transform.rotate(angle: .12, child: _Asset('assets/3d/04_message_bubble.svg', 92))),
            Positioned(left: 18, bottom: 30, child: Transform.rotate(angle: -.14, child: _Asset('assets/3d/05_security_shield.svg', 92))),
            Positioned(right: 54, bottom: 76, child: _Asset('assets/3d/06_lime_sphere.svg', 56)),
            Center(
              child: SizedBox(
                width: 250,
                height: 285,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: -.10,
                      child: SvgPicture.asset('assets/3d/01_phone.svg', width: 220),
                    ),
                    Positioned(
                      left: 12,
                      top: 78,
                      child: SvgPicture.asset('assets/3d/02_profile_user.svg', width: 118),
                    ),
                    Positioned(
                      right: 2,
                      bottom: 18,
                      child: Transform.rotate(
                        angle: .09,
                        child: SvgPicture.asset('assets/3d/03_lock.svg', width: 105),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Asset extends StatelessWidget {
  const _Asset(this.path, this.size);
  final String path;
  final double size;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(path, width: size, height: size);
}

class _LoginPanel extends StatelessWidget {
  const _LoginPanel();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -26),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          context.tokens.spaceLg,
          0,
          context.tokens.spaceLg,
          context.tokens.spaceLg,
        ),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(context.tokens.radiusLg + 14),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: const Offset(0, -38),
                child: Container(
                  width: 78,
                  height: 78,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(color: Color(0x55000000), blurRadius: 20, offset: Offset(0, 8)),
                    ],
                  ),
                  child: SvgPicture.asset('assets/3d/01_phone.svg'),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Giriş yap',
                    style: context.texts.headlineLarge?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: context.tokens.spaceSm),
                  Text(
                    'Telefon numaranızla devam edin',
                    style: context.texts.titleLarge?.copyWith(color: context.colors.onSurfaceVariant),
                  ),
                  SizedBox(height: context.tokens.spaceXs),
                  Text(
                    'Ülkenizi seçin ve cep telefonu numaranızı girin.',
                    style: context.texts.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                  ),
                  SizedBox(height: context.tokens.spaceLg),
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: '5xx xxx xx xx',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: context.tokens.spaceMd, right: context.tokens.spaceSm),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('🇹🇷', style: TextStyle(fontSize: 22)),
                            SizedBox(width: context.tokens.spaceSm),
                            Text('+90', style: context.texts.bodyLarge?.copyWith(fontWeight: FontWeight.w700)),
                            const Icon(Icons.keyboard_arrow_down_rounded),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.tokens.spaceMd),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: context.tokens.lime,
                        foregroundColor: context.colors.onSecondary,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(builder: (_) => const OtpScreen()),
                        );
                      },
                      child: const Text('Doğrulama kodu gönder'),
                    ),
                  ),
                  SizedBox(height: context.tokens.spaceMd),
                  Row(
                    children: [
                      Expanded(child: Divider(color: context.colors.outlineVariant)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: context.tokens.spaceSm),
                        child: Text('VEYA', style: context.texts.labelSmall?.copyWith(color: context.colors.onSurfaceVariant)),
                      ),
                      Expanded(child: Divider(color: context.colors.outlineVariant)),
                    ],
                  ),
                  SizedBox(height: context.tokens.spaceMd),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/3d/04_message_bubble.svg', width: 24),
                      label: const Text('Başka bir yöntemle giriş yap'),
                    ),
                  ),
                  SizedBox(height: context.tokens.spaceLg),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/3d/05_security_shield.svg', width: 26),
                      SizedBox(width: context.tokens.spaceSm),
                      Expanded(
                        child: Text(
                          'Numaranız güvende. Bilgileriniz asla paylaşılmaz.',
                          style: context.texts.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
