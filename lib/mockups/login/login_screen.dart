import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/context_ext.dart';
import '../../core/theme/theme_controller.dart';
import '../otp/otp_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  const _HeroBackground(),
                  Transform.translate(
                    offset: const Offset(0, -58),
                    child: const _LoginPanel(),
                  ),
                ],
              ),
              Positioned(
                left: 10,
                right: 10,
                top: 30,
                child: IgnorePointer(
                  child: SizedBox(
                    height: 370,
                    child: Image.asset(
                      'assets/images/ybb_hero.png',
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
              const Positioned(
                right: 16,
                top: 14,
                child: _ThemeSwitch(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroBackground extends StatelessWidget {
  const _HeroBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colors.primary,
            const Color(0xFF7B31F3),
            const Color(0xFF4B1597),
          ],
        ),
      ),
    );
  }
}

class _ThemeSwitch extends StatelessWidget {
  const _ThemeSwitch();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        final isDark = themeController.isDark;
        return GestureDetector(
          onTap: () => themeController.setDark(!isDark),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOutCubic,
            width: 82,
            height: 42,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xB20C0718) : const Color(0xEFFFFFFF),
              borderRadius: BorderRadius.circular(99),
              border: Border.all(
                color: isDark ? const Color(0xFF9B61FF) : const Color(0xFFE2D9F2),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 14,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.light_mode_rounded,
                      size: 18,
                      color: isDark ? Colors.white54 : const Color(0xFF7C2CFF),
                    ),
                    Icon(
                      Icons.dark_mode_rounded,
                      size: 18,
                      color: isDark ? context.tokens.lime : const Color(0xFF756C80),
                    ),
                  ],
                ),
                AnimatedAlign(
                  duration: const Duration(milliseconds: 320),
                  curve: Curves.easeOutBack,
                  alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? const Color(0xFF7C2CFF) : context.tokens.lime,
                    ),
                    child: Icon(
                      isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      size: 19,
                      color: isDark ? Colors.white : const Color(0xFF17111F),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LoginPanel extends StatelessWidget {
  const _LoginPanel();

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const _OvalTopPanelClipper(),
      child: Container(
        width: double.infinity,
        color: context.colors.surface,
        padding: EdgeInsets.fromLTRB(
          context.tokens.spaceLg,
          108,
          context.tokens.spaceLg,
          30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Giriş yap',
              style: context.texts.headlineLarge?.copyWith(
                fontSize: 34,
                height: 1.05,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Telefon numaranızla devam edin',
              style: context.texts.titleLarge?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: context.colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ülkenizi seçin ve cep telefonu numaranızı girin.',
              style: context.texts.bodyMedium?.copyWith(
                fontSize: 15,
                color: context.colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 70,
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: '5xx xxx xx xx',
                  contentPadding: const EdgeInsets.symmetric(vertical: 22),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: context.colors.outlineVariant,
                      width: 1.4,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: context.colors.primary,
                      width: 1.6,
                    ),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🇹🇷', style: TextStyle(fontSize: 23)),
                        const SizedBox(width: 10),
                        Text(
                          '+90',
                          style: context.texts.bodyLarge?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.keyboard_arrow_down_rounded),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 64,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: context.tokens.lime,
                  foregroundColor: const Color(0xFF151019),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const OtpScreen()),
                ),
                child: const Text('Doğrulama kodu gönder'),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(child: Divider(color: context.colors.outlineVariant)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'VEYA',
                    style: context.texts.labelMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: context.colors.outlineVariant)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: context.colors.outlineVariant,
                    width: 1.4,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  foregroundColor: context.colors.primary,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/3d/04_message_bubble.svg',
                  width: 22,
                ),
                label: const Text('Başka bir yöntemle giriş yap'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OvalTopPanelClipper extends CustomClipper<Path> {
  const _OvalTopPanelClipper();

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 82)
      ..cubicTo(0, 28, 42, 0, 96, 0)
      ..lineTo(size.width - 96, 0)
      ..cubicTo(size.width - 42, 0, size.width, 28, size.width, 82)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
