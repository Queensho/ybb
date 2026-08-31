import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                padding: EdgeInsets.fromLTRB(context.tokens.spaceLg, 18, context.tokens.spaceLg, 34),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hoş geldiniz', style: context.texts.titleMedium?.copyWith(color: context.tokens.lime, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text('Sizi biraz tanıyalım', style: context.texts.headlineLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w900, height: 1.04)),
                    const SizedBox(height: 18),
                    Text(
                      'Önce cinsiyet bilginizi, ardından sizinle ilgili birkaç temel soru soracağız. Son adımda sizin için en önemli iki partner tercihini seçebileceksiniz. Cevaplarınız, eşleşme raporlarının daha doğru hazırlanmasına yardımcı olur.',
                      style: context.texts.bodyLarge?.copyWith(color: const Color(0xFFC9C3D5), height: 1.55),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF120D20),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFF6E35C8).withOpacity(.55)),
                      ),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(
                          width: 46, height: 46,
                          decoration: BoxDecoration(color: const Color(0xFF2B174A), borderRadius: BorderRadius.circular(15)),
                          child: const Icon(Icons.info_outline_rounded, color: Color(0xFF9A55FF)),
                        ),
                        const SizedBox(width: 14),
                        Expanded(child: Text(
                          'Daha sonra profilinizdeki “Hakkımda” bölümünden cevaplarınızı yeniden görebilir ve değiştirebilirsiniz. Bu seçeneğin sunulduğu sorularda “Cevap vermek istemiyorum” seçeneğini kullanabilirsiniz.',
                          style: context.texts.bodyMedium?.copyWith(color: const Color(0xFFC9C3D5), height: 1.5),
                        )),
                      ]),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(backgroundColor: context.tokens.lime, foregroundColor: black, padding: const EdgeInsets.symmetric(vertical: 19)),
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const GenderSelectionScreen())),
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: const Text('Hazırsanız başlayalım', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
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
      height: 430,
      width: double.infinity,
      child: ClipPath(
        clipper: _OvalBottomClipper(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF9A4DFF), Color(0xFF6D21D7), Color(0xFF45108D)]),
          ),
          child: Stack(children: [
            Positioned(left: 22, top: 24, child: _Pill()),
            Positioned(right: 22, top: 20, child: Container(width: 48, height: 48, decoration: const BoxDecoration(color: Color(0x33210A45), shape: BoxShape.circle), child: const Icon(Icons.close_rounded, color: Colors.white70))),
            Positioned(left: -45, top: 100, child: SvgPicture.asset('assets/3d/07_lime_blob.svg', width: 145)),
            Positioned(right: -38, bottom: 55, child: SvgPicture.asset('assets/3d/09_purple_blob.svg', width: 155)),
            Positioned(right: 24, top: 112, child: Transform.rotate(angle: .1, child: SvgPicture.asset('assets/3d/04_message_bubble.svg', width: 92))),
            Positioned(left: 24, bottom: 92, child: Transform.rotate(angle: -.12, child: SvgPicture.asset('assets/3d/05_security_shield.svg', width: 88))),
            Positioned(right: 64, bottom: 112, child: SvgPicture.asset('assets/3d/03_lock.svg', width: 98)),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 42),
                child: SizedBox(width: 260, height: 270, child: Stack(alignment: Alignment.center, children: [
                  Transform.rotate(angle: -.07, child: SvgPicture.asset('assets/3d/01_phone.svg', width: 220)),
                  Positioned(left: 4, top: 84, child: SvgPicture.asset('assets/3d/02_profile_user.svg', width: 116)),
                ])),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
    decoration: BoxDecoration(color: const Color(0x33210A45), borderRadius: BorderRadius.circular(999), border: Border.all(color: Colors.white12)),
    child: const Text('ADIM 1 / 4', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: .4)),
  );
}

class _OvalBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 92);
    path.quadraticBezierTo(size.width * .5, size.height + 42, size.width, size.height - 92);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
