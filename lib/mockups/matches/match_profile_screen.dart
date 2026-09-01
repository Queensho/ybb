import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';

class MatchProfileScreen extends StatelessWidget {
  const MatchProfileScreen({super.key,required this.name,required this.city,required this.age,required this.score,required this.interests,required this.status,required this.online,required this.imageUrl,required this.verified});
  final String name,city,status,imageUrl; final int age,score; final List<String> interests; final bool online,verified;

  @override
  Widget build(BuildContext context) {
    final bg=context.colors.surface;
    return Scaffold(
      backgroundColor:bg,
      body:CustomScrollView(slivers:[
        SliverAppBar(
          expandedHeight:390,pinned:true,backgroundColor:bg,surfaceTintColor:Colors.transparent,
          leading:Padding(padding:const EdgeInsets.all(8),child:_CircleButton(icon:Icons.arrow_back_rounded,onTap:()=>Navigator.pop(context))),
          actions:const [Padding(padding:EdgeInsets.only(right:12),child:_CircleButton(icon:Icons.more_horiz_rounded))],
          flexibleSpace:LayoutBuilder(builder:(context,constraints){
            final minHeight=kToolbarHeight+MediaQuery.paddingOf(context).top;
            final collapse=(1-((constraints.maxHeight-minHeight)/(390-minHeight))).clamp(0.0,1.0);
            final expandedOpacity=(1-collapse*1.8).clamp(0.0,1.0);
            return Stack(fit:StackFit.expand,children:[
              Image.network(imageUrl,fit:BoxFit.cover,errorBuilder:(_,__,___)=>const ColoredBox(color:Color(0xFF4B168F),child:Icon(Icons.person_rounded,size:120,color:Colors.white54))),
              if(collapse>0)Opacity(opacity:collapse,child:ClipRect(child:BackdropFilter(filter:ImageFilter.blur(sigmaX:14,sigmaY:14),child:const ColoredBox(color:Color(0x66090712))))),
              DecoratedBox(decoration:BoxDecoration(gradient:LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,colors:[Color.lerp(Colors.transparent,const Color(0x66090712),collapse)!,const Color(0x33000000),Color.lerp(const Color(0xFF090712),const Color(0x99090712),collapse)!],stops:const [0.2,.7,1]))),
              Positioned(left:24,right:24,bottom:24,child:Opacity(opacity:expandedOpacity,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                Row(children:[Flexible(child:Text('$name, $age',style:const TextStyle(color:Colors.white,fontSize:34,height:1,fontWeight:FontWeight.w900))),if(verified)const Padding(padding:EdgeInsets.only(left:8),child:Icon(Icons.verified_rounded,color:Color(0xFF9A4DFF),size:25))]),
                const SizedBox(height:10),
                Wrap(spacing:14,runSpacing:6,children:[Row(mainAxisSize:MainAxisSize.min,children:[Icon(Icons.circle,size:9,color:online?context.tokens.lime:Colors.white54),const SizedBox(width:7),Text(status,style:TextStyle(color:online?context.tokens.lime:Colors.white70,fontWeight:FontWeight.w600))]),Row(mainAxisSize:MainAxisSize.min,children:[const Icon(Icons.location_on_outlined,color:Colors.white70,size:18),const SizedBox(width:3),Text(city,style:const TextStyle(color:Colors.white70))])]),
              ]))),
              IgnorePointer(child:Opacity(opacity:collapse,child:Center(child:Padding(padding:EdgeInsets.only(top:MediaQuery.paddingOf(context).top*.45),child:Row(mainAxisSize:MainAxisSize.min,children:[Text('$name, $age',style:const TextStyle(color:Colors.white,fontSize:18,fontWeight:FontWeight.w900,shadows:[Shadow(color:Colors.black54,blurRadius:10)])),if(verified)const Padding(padding:EdgeInsets.only(left:6),child:Icon(Icons.verified_rounded,color:Color(0xFFB45CFF),size:19))]))))),
            ]);
          }),
        ),
        SliverToBoxAdapter(child:Padding(padding:const EdgeInsets.fromLTRB(20,6,20,120),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          _CompatibilityCard(score:score),const SizedBox(height:18),const _SectionTitle('Ortak noktalar'),const SizedBox(height:10),Wrap(spacing:8,runSpacing:8,children:interests.map((e)=>_Chip(label:e)).toList()),const SizedBox(height:22),const _SectionTitle('Uyum özeti'),const SizedBox(height:10),const _InfoCard(children:[_InfoRow(icon:Icons.question_answer_outlined,title:'Ortak cevaplar',value:'4 ortak cevap'),_InfoRow(icon:Icons.tune_rounded,title:'Partner tercihleri',value:'2 tercih uyumlu'),_InfoRow(icon:Icons.translate_rounded,title:'Konuştuğu dil',value:'Türkçe')]),const SizedBox(height:22),const _SectionTitle('Hakkında'),const SizedBox(height:10),const _InfoCard(children:[_AboutText()]),
        ]))),
      ]),
      bottomNavigationBar:SafeArea(top:false,child:Container(color:bg,padding:const EdgeInsets.fromLTRB(20,10,20,14),child:Row(children:[
        Container(width:58,height:58,decoration:BoxDecoration(shape:BoxShape.circle,border:Border.all(color:context.colors.outlineVariant)),child:Icon(Icons.favorite_border_rounded,color:context.isDark?context.tokens.lime:context.colors.primary)),
        const SizedBox(width:12),
        Expanded(child:SizedBox(height:58,child:FilledButton.icon(onPressed:(){},icon:const Icon(Icons.chat_bubble_rounded),label:const Text('Mesaj gönder'),style:FilledButton.styleFrom(backgroundColor:context.tokens.lime,foregroundColor:context.colors.onSecondary,textStyle:const TextStyle(fontSize:16,fontWeight:FontWeight.w900),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20))))),
      ]))),
    );
  }
}

class _CompatibilityCard extends StatelessWidget {
  const _CompatibilityCard({required this.score}); final int score;
  @override Widget build(BuildContext context)=>Container(
    padding:const EdgeInsets.all(18),
    decoration:BoxDecoration(color:context.colors.surfaceContainer,borderRadius:BorderRadius.circular(26),border:Border.all(color:context.colors.outlineVariant)),
    child:Column(children:[
      Row(children:[Container(width:48,height:48,decoration:BoxDecoration(color:context.colors.surfaceContainerHighest,borderRadius:BorderRadius.circular(16)),child:Icon(Icons.auto_awesome_rounded,color:context.isDark?context.tokens.lime:context.colors.primary)),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Eşleşme uyumu',style:TextStyle(color:context.colors.onSurfaceVariant,fontWeight:FontWeight.w600)),Text('%$score',style:TextStyle(color:context.isDark?context.tokens.lime:context.colors.primary,fontSize:30,fontWeight:FontWeight.w900))])),Icon(Icons.chevron_right_rounded,color:context.colors.onSurfaceVariant)]),
      const SizedBox(height:14),ClipRRect(borderRadius:BorderRadius.circular(99),child:LinearProgressIndicator(value:score/100,minHeight:8,backgroundColor:context.colors.surfaceContainerHighest,valueColor:AlwaysStoppedAnimation(context.tokens.lime))),
      const SizedBox(height:10),Align(alignment:Alignment.centerLeft,child:Text('Cevaplarınız ve partner tercihleriniz karşılaştırılarak hesaplanır.',style:TextStyle(color:context.colors.onSurfaceVariant,fontSize:12,height:1.35))),
    ]),
  );
}

class _SectionTitle extends StatelessWidget { const _SectionTitle(this.text);final String text;@override Widget build(BuildContext context)=>Text(text,style:TextStyle(color:context.colors.onSurface,fontSize:20,fontWeight:FontWeight.w900)); }
class _Chip extends StatelessWidget { const _Chip({required this.label});final String label;@override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.symmetric(horizontal:14,vertical:9),decoration:BoxDecoration(color:context.colors.surfaceContainerHighest,borderRadius:BorderRadius.circular(99),border:Border.all(color:context.colors.outlineVariant)),child:Text(label,style:TextStyle(color:context.colors.onSurfaceVariant,fontWeight:FontWeight.w600))); }
class _InfoCard extends StatelessWidget { const _InfoCard({required this.children});final List<Widget> children;@override Widget build(BuildContext context)=>Container(width:double.infinity,padding:const EdgeInsets.all(18),decoration:BoxDecoration(color:context.colors.surfaceContainer,borderRadius:BorderRadius.circular(26),border:Border.all(color:context.colors.outlineVariant)),child:Column(children:children)); }
class _InfoRow extends StatelessWidget { const _InfoRow({required this.icon,required this.title,required this.value});final IconData icon;final String title,value;@override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.symmetric(vertical:9),child:Row(children:[Container(width:42,height:42,decoration:BoxDecoration(color:context.colors.surfaceContainerHighest,borderRadius:BorderRadius.circular(14)),child:Icon(icon,color:context.isDark?context.tokens.lime:context.colors.primary,size:21)),const SizedBox(width:12),Expanded(child:Text(title,style:TextStyle(color:context.colors.onSurfaceVariant,fontSize:14))),Text(value,style:TextStyle(color:context.colors.onSurface,fontWeight:FontWeight.w700))])); }
class _AboutText extends StatelessWidget { const _AboutText();@override Widget build(BuildContext context)=>Text('Yeni insanlarla tanışmayı, güzel sohbetleri ve küçük kaçamakları seviyorum. Ortak noktalarımız varsa tanışalım.',style:TextStyle(color:context.colors.onSurfaceVariant,fontSize:15,height:1.55)); }
class _CircleButton extends StatelessWidget { const _CircleButton({required this.icon,this.onTap});final IconData icon;final VoidCallback? onTap;@override Widget build(BuildContext context)=>Material(color:const Color(0x99090712),shape:const CircleBorder(),child:InkWell(customBorder:const CircleBorder(),onTap:onTap,child:SizedBox(width:44,height:44,child:Icon(icon,color:Colors.white)))); }
