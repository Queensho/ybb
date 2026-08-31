import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';
import 'gender_selection_screen.dart';

class WelcomeIntroScreen extends StatelessWidget {
  const WelcomeIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const black = Color(0xFF090712);
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _CurvedHero(),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.tokens.spaceLg,
                  10,
                  context.tokens.spaceLg,
                  34,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hoş geldiniz',
                      style: context.texts.titleMedium?.copyWith(
                        color: context.tokens.lime,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sizi biraz tanıyalım',
                      style: context.texts.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        height: 1.04,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Önce cinsiyet bilginizi, ardından sizinle ilgili birkaç temel soru soracağız. Son adımda sizin için en önemli iki partner tercihini seçebileceksiniz. Cevaplarınız, eşleşme raporlarının daha doğru hazırlanmasına yardımcı olur.',
                      style: context.texts.bodyLarge?.copyWith(
                        color: const Color(0xFFC9C3D5),
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF120D20),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFF6E35C8).withOpacity(.55),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2B174A),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.info_outline_rounded,
                              color: Color(0xFF9A55FF),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              'Daha sonra profilinizdeki “Hakkımda” bölümünden cevaplarınızı yeniden görebilir ve değiştirebilirsiniz. Bu seçeneğin sunulduğu sorularda “Cevap vermek istemiyorum” seçeneğini kullanabilirsiniz.',
                              style: context.texts.bodyMedium?.copyWith(
                                color: const Color(0xFFC9C3D5),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: context.tokens.lime,
                          foregroundColor: black,
                          padding: const EdgeInsets.symmetric(vertical: 19),
                        ),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const GenderSelectionScreen(),
                          ),
                        ),
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: const Text(
                          'Hazırsanız başlayalım',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
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

class _CurvedHero extends StatelessWidget {
  const _CurvedHero();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      width: double.infinity,
      child: ClipPath(
        clipper: _OvalBottomClipper(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF9A4DFF),
                Color(0xFF6D21D7),
                Color(0xFF45108D),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(left: 22, top: 24, child: _Pill()),
              Positioned(
                right: 22,
                top: 20,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Color(0x33210A45),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white70,
                  ),
                ),
              ),
              const Center(child: _WelcomeHandBadge()),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeHandBadge extends StatelessWidget {
  const _WelcomeHandBadge();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 8),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: const Color(0xFF120D20),
              borderRadius: BorderRadius.circular(42),
              border: Border.all(color: Colors.white.withOpacity(.10)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x66000000),
                  blurRadius: 30,
                  offset: Offset(0, 18),
                ),
                BoxShadow(
                  color: Color(0x557B2CFF),
                  blurRadius: 24,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(
              Icons.waving_hand_rounded,
              size: 78,
              color: Color(0xFFB7FF2A),
            ),
          ),
          Positioned(
            right: -12,
            bottom: 10,
            child: Container(
              width: 54,
              height: 54,
              decoration: const BoxDecoration(
                color: Color(0xFF8C45FF),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x55000000),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.favorite_rounded,
                size: 27,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        decoration: BoxDecoration(
          color: const Color(0x33210A45),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white12),
        ),
        child: const Text(
          'ADIM 1 / 4',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: .4,
          ),
        ),
      );
}

class _OvalBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 70);
    path.quadraticBezierTo(
      size.width * .5,
      size.height + 16,
      size.width,
      size.height - 70,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
