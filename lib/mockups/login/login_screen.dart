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
      height: 330,
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
            const Positioned(right: 16, top: 14, child: _ThemeSwitch()),
            Positioned(left: -58, top: 18, child: _Asset('assets/3d/07_lime_blob.svg', 138)),
            Positioned(right: -46, bottom: 8, child: _Asset('assets/3d/09_purple_blob.svg', 138)),
            Positioned(right: 12, top: 76, child: Transform.rotate(angle: .10, child: _Asset('assets/3d/04_message_bubble.svg', 76))),
            Positioned(left: 18, bottom: 24, child: Transform.rotate(angle: -.10, child: _Asset('assets/3d/05_security_shield.svg', 72))),
            Positioned(right: 52, bottom: 64, child: _Asset('assets/3d/06_lime_sphere.svg', 44)),
            Center(
              child: SizedBox(
                width: 290,
                height: 300,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: -.07,
                      child: SvgPicture.asset('assets/3d/01_phone.svg', width: 248),
                    ),
                    Positioned(
                      left: 12,
                      top: 96,
                      child: Transform.rotate(
                        angle: -.04,
                        child: SvgPicture.asset('assets/3d/02_profile_user.svg', width: 112),
                      ),
                    ),
                    Positioned(
                      right: 4,
                      bottom: 28,
                      child: Transform.rotate(
                        angle: .06,
                        child: SvgPicture.asset('assets/3d/03_lock.svg', width: 92),
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

class _ThemeSwitch extends StatelessWidget {
  const _ThemeSwitch();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        final isDark = themeController.isDark;
        return Semantics(
          button: true,
          label: isDark ? 'Aydınlık temaya geç' : 'Karanlık temaya geç',
          child: GestureDetector(
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
                  BoxShadow(color: Color(0x26000000), blurRadius: 14, offset: Offset(0, 5)),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 220),
                        opacity: isDark ? .55 : 1,
                        child: Icon(
                          Icons.light_mode_rounded,
                          size: 18,
                          color: isDark ? Colors.white70 : const Color(0xFF7C2CFF),
                        ),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 220),
                        opacity: isDark ? 1 : .55,
                        child: Icon(
                          Icons.dark_mode_rounded,
                          size: 18,
                          color: isDark ? context.tokens.lime : const Color(0xFF756C80),
                        ),
                      ),
                    ],
                  ),
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOutBack,
                    alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 320),
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark ? const Color(0xFF7C2CFF) : context.tokens.lime,
                        boxShadow: const [
                          BoxShadow(color: Color(0x33000000), blurRadius: 8, offset: Offset(0, 3)),
                        ],
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 220),
                        transitionBuilder: (child, animation) => RotationTransition(
                          turns: Tween<double>(begin: .65, end: 1).animate(animation),
                          child: FadeTransition(opacity: animation, child: child),
                        ),
                        child: Icon(
                          isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                          key: ValueKey(isDark),
                          size: 19,
                          color: isDark ? Colors.white : const Color(0xFF17111F),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
      offset: const Offset(0, -22),
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
                offset: const Offset(0, -34),
                child: Container(
                  width: 72,
                  height: 72,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB7FF2A), Color(0xFF8FE600)],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: context.colors.surface, width: 7),
                    boxShadow: const [
                      BoxShadow(color: Color(0x55000000), blurRadius: 20, offset: Offset(0, 8)),
                    ],
                  ),
                  child: SvgPicture.asset('assets/3d/01_phone.svg'),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -18),
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
                      icon: SvgPicture.asset('assets/3d/04_message_bubble.svg', width: 22),
                      label: const Text('Başka bir yöntemle giriş yap'),
                    ),
                  ),
                  SizedBox(height: context.tokens.spaceLg),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/3d/05_security_shield.svg', width: 24),
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
