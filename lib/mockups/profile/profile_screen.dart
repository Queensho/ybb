import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';
import '../onboarding/about_question_screen.dart';
import '../onboarding/partner_preferences_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
          children: [
            Row(children: [
              Expanded(child: Text('Profil', style: context.texts.headlineMedium?.copyWith(color: context.colors.onSurface, fontWeight: FontWeight.w900))),
              _TopIcon(icon: Icons.settings_outlined, onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen()))),
            ]),
            const SizedBox(height: 24),
            _ProfileHero(lime: context.tokens.lime),
            const SizedBox(height: 22),
            Text('Profilini yönet', style: context.texts.titleLarge?.copyWith(color: context.colors.onSurface, fontWeight: FontWeight.w900)),
            const SizedBox(height: 12),
            _ActionCard(icon: Icons.edit_note_rounded,title: 'Hakkımda cevapların',subtitle: 'Kendin hakkında verdiğin cevapları görüntüle ve düzenle',trailing: '6 cevap',onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AboutQuestionScreen()))),
            const SizedBox(height: 12),
            _ActionCard(icon: Icons.tune_rounded,title: 'Partner tercihlerin',subtitle: 'Eşleşmelerde senin için önemli olan tercihleri yönet',trailing: '2 aktif',onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PartnerPreferencesScreen()))),
            const SizedBox(height: 12),
            _ActionCard(icon: Icons.photo_camera_outlined,title: 'Profil fotoğrafların',subtitle: 'Adayların gördüğü fotoğrafları düzenle',trailing: '3 fotoğraf',onTap: () {}),
            const SizedBox(height: 22),
            Text('Hesap', style: context.texts.titleLarge?.copyWith(color: context.colors.onSurface, fontWeight: FontWeight.w900)),
            const SizedBox(height: 12),
            _SimpleRow(icon: Icons.shield_outlined, label: 'Gizlilik ve güvenlik', onTap: () {}),
            const SizedBox(height: 10),
            _SimpleRow(icon: Icons.notifications_none_rounded, label: 'Bildirimler', onTap: () {}),
            const SizedBox(height: 10),
            _SimpleRow(icon: Icons.help_outline_rounded, label: 'Yardım ve destek', onTap: () {}),
            const SizedBox(height: 16),
            _LogoutButton(onTap: () {}),
          ],
        ),
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({required this.lime});
  final Color lime;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,colors: [Color(0xFF8F3DFF), Color(0xFF6D21D7), Color(0xFF45108D)]),
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [BoxShadow(color: Color(0x442D0868), blurRadius: 26, offset: Offset(0, 14))],
    ),
    child: Row(children: [
      Container(width:82,height:82,padding:const EdgeInsets.all(3),decoration:BoxDecoration(shape:BoxShape.circle,border:Border.all(color:lime,width:2),color:const Color(0xFF2A1450)),child:const CircleAvatar(backgroundColor:Color(0xFF21172F),child:Icon(Icons.person_rounded,size:44,color:Colors.white70))),
      const SizedBox(width:16),
      Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        const Row(children:[Flexible(child:Text('Tayfun, 31',overflow:TextOverflow.ellipsis,style:TextStyle(color:Colors.white,fontSize:24,fontWeight:FontWeight.w900))),SizedBox(width:6),Icon(Icons.verified_rounded,color:Color(0xFFC5FF45),size:21)]),
        const SizedBox(height:5),
        const Text('İstanbul, TR',style:TextStyle(color:Color(0xFFE5D7F6),fontWeight:FontWeight.w600)),
        const SizedBox(height:12),
        Row(children:[Expanded(child:ClipRRect(borderRadius:BorderRadius.circular(99),child:LinearProgressIndicator(value:.82,minHeight:7,backgroundColor:Colors.white24,valueColor:AlwaysStoppedAnimation<Color>(lime)))),const SizedBox(width:10),const Text('%82',style:TextStyle(color:Colors.white,fontWeight:FontWeight.w900))]),
        const SizedBox(height:5),
        const Text('Profil tamamlanma',style:TextStyle(color:Color(0xFFD8CBE8),fontSize:12)),
      ])),
    ]),
  );
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.icon, required this.title, required this.subtitle, required this.trailing, required this.onTap});
  final IconData icon; final String title, subtitle, trailing; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(onTap:onTap,borderRadius:BorderRadius.circular(24),child:Ink(
      padding:const EdgeInsets.all(16),
      decoration:BoxDecoration(color:context.colors.surfaceContainer,borderRadius:BorderRadius.circular(24),border:Border.all(color:context.colors.outlineVariant)),
      child:Row(children:[
        Container(width:50,height:50,decoration:BoxDecoration(color:context.colors.surfaceContainerHighest,borderRadius:BorderRadius.circular(16)),child:Icon(icon,color:context.isDark?context.tokens.lime:context.colors.primary)),
        const SizedBox(width:14),
        Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text(title,style:TextStyle(color:context.colors.onSurface,fontSize:16,fontWeight:FontWeight.w800)),
          const SizedBox(height:5),
          Text(subtitle,style:TextStyle(color:context.colors.onSurfaceVariant,height:1.35,fontSize:13)),
          const SizedBox(height:8),
          Text(trailing,style:TextStyle(color:context.isDark?context.tokens.lime:context.colors.primary,fontWeight:FontWeight.w800,fontSize:12)),
        ])),
        Icon(Icons.chevron_right_rounded,color:context.colors.onSurfaceVariant),
      ]),
    )),
  );
}

class _SimpleRow extends StatelessWidget {
  const _SimpleRow({required this.icon, required this.label, required this.onTap});
  final IconData icon; final String label; final VoidCallback onTap;
  @override
  Widget build(BuildContext context)=>Material(color:Colors.transparent,child:InkWell(onTap:onTap,borderRadius:BorderRadius.circular(20),child:Ink(
    padding:const EdgeInsets.symmetric(horizontal:16,vertical:15),
    decoration:BoxDecoration(color:context.colors.surfaceContainer,borderRadius:BorderRadius.circular(20),border:Border.all(color:context.colors.outlineVariant)),
    child:Row(children:[Icon(icon,color:context.isDark?context.tokens.lime:context.colors.primary),const SizedBox(width:13),Expanded(child:Text(label,style:TextStyle(color:context.colors.onSurface,fontWeight:FontWeight.w700))),Icon(Icons.chevron_right_rounded,color:context.colors.onSurfaceVariant)]),
  )));
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.onTap}); final VoidCallback onTap;
  @override Widget build(BuildContext context)=>OutlinedButton.icon(
    onPressed:onTap,icon:const Icon(Icons.logout_rounded),label:const Text('Çıkış yap'),
    style:OutlinedButton.styleFrom(minimumSize:const Size.fromHeight(56),foregroundColor:const Color(0xFFFF5267),side:const BorderSide(color:Color(0xFFFFA7B2)),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),textStyle:const TextStyle(fontWeight:FontWeight.w800)),
  );
}

class _TopIcon extends StatelessWidget { const _TopIcon({required this.icon,required this.onTap});final IconData icon;final VoidCallback onTap;@override Widget build(BuildContext context)=>IconButton.filledTonal(onPressed:onTap,icon:Icon(icon)); }
