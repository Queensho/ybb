import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';
import '../matches/matches_screen.dart';

class PartnerPreferencesScreen extends StatefulWidget {
  const PartnerPreferencesScreen({super.key});
  @override State<PartnerPreferencesScreen> createState()=>_PartnerPreferencesScreenState();
}

class _PartnerPreferencesScreenState extends State<PartnerPreferencesScreen>{
  final Map<int,Set<String>> selections={};
  static const questions=<_PreferenceQuestion>[
    _PreferenceQuestion(title:'Daha önce evlendiniz mi?',options:['Daha önce evlenmiş','Daha önce evlenmemiş'],icon:Icons.favorite_rounded,multiSelect:false),
    _PreferenceQuestion(title:'Çocuğunuz var mı?',options:['Çocuğu var','Çocuğu yok'],icon:Icons.child_care_rounded,multiSelect:false),
    _PreferenceQuestion(title:'Gelecekte çocuk sahibi olmak ister misiniz?',options:['Kesinlikle istemesin','İstemesin','Kararsız olsun','İstesin','Kesinlikle istesin'],icon:Icons.family_restroom_rounded,multiSelect:true),
    _PreferenceQuestion(title:'Ne sıklıkla sigara kullanırsınız?',options:['Hiç','Çok nadir','Ara sıra','Sık','Çok sık'],icon:Icons.smoking_rooms_rounded,multiSelect:true),
    _PreferenceQuestion(title:'Ne sıklıkla alkol kullanırsınız?',options:['Hiç','Çok nadir','Ara sıra','Sık','Çok sık'],icon:Icons.local_bar_rounded,multiSelect:true),
    _PreferenceQuestion(title:'Tamamladığınız en yüksek eğitim düzeyi nedir?',options:['İlköğretim','Lise','Ön lisans / Lisans','Yüksek lisans','Doktora'],icon:Icons.school_rounded,multiSelect:true),
  ];
  int get selectedPreferenceCount=>selections.values.where((v)=>v.isNotEmpty).length;
  int get remainingRights=>(2-selectedPreferenceCount).clamp(0,2);
  bool get limitReached=>selectedPreferenceCount>=2;

  Future<void> _openQuestion(int index)async{
    final alreadySelected=(selections[index]??<String>{}).isNotEmpty;
    if(limitReached&&!alreadySelected)return;
    final result=await Navigator.of(context).push<Set<String>>(MaterialPageRoute(builder:(_)=>PartnerPreferenceDetailScreen(question:questions[index],initialSelection:selections[index]??<String>{})));
    if(result==null||!mounted)return;
    setState(()=>selections[index]=result);
    if(selectedPreferenceCount>=2&&mounted){
      await Future<void>.delayed(const Duration(milliseconds:220));
      if(!mounted)return;
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(_)=>const MatchesScreen()),(route)=>false);
    }
  }

  @override Widget build(BuildContext context){
    const black=Color(0xFF090712);
    return Scaffold(backgroundColor:black,body:SafeArea(child:Column(children:[
      Padding(padding:EdgeInsets.fromLTRB(context.tokens.spaceLg,18,context.tokens.spaceLg,10),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
        Align(alignment:Alignment.centerLeft,child:IconButton.filledTonal(onPressed:()=>Navigator.of(context).pop(),icon:const Icon(Icons.arrow_back_rounded))),
        const SizedBox(height:12),
        Text('Partner Tercihleri',style:context.texts.headlineMedium?.copyWith(color:Colors.white,fontWeight:FontWeight.w900)),
        const SizedBox(height:18),
        _ImportantPreferencesCard(selectedCount:selectedPreferenceCount,remainingRights:remainingRights),
      ])),
      Expanded(child:ListView.separated(physics:const AlwaysScrollableScrollPhysics(),padding:EdgeInsets.fromLTRB(context.tokens.spaceLg,12,context.tokens.spaceLg,40),itemCount:questions.length,separatorBuilder:(_,__)=>const SizedBox(height:12),itemBuilder:(context,i){
        final values=selections[i]??<String>{};final locked=limitReached&&values.isEmpty;
        return _PreferenceTile(question:questions[i],selectedValues:values,locked:locked,onTap:locked?null:()=>_openQuestion(i));
      })),
    ])));
  }
}

class _ImportantPreferencesCard extends StatelessWidget{
  const _ImportantPreferencesCard({required this.selectedCount,required this.remainingRights});
  final int selectedCount,remainingRights;
  @override Widget build(BuildContext context)=>Container(
    padding:const EdgeInsets.all(20),
    decoration:BoxDecoration(
      gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFF8F3DFF),Color(0xFF6D21D7),Color(0xFF4C149F)]),
      borderRadius:BorderRadius.circular(26),
      border:Border.all(color:const Color(0xFFAD73FF).withOpacity(.45)),
      boxShadow:const [BoxShadow(color:Color(0x442D0868),blurRadius:24,offset:Offset(0,12))],
    ),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Container(width:48,height:48,decoration:BoxDecoration(color:Colors.white.withOpacity(.12),borderRadius:BorderRadius.circular(16)),child:Icon(Icons.favorite_rounded,color:context.tokens.lime,size:27)),
        const SizedBox(width:14),
        Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text('Sizin için önemli olanlar',style:context.texts.titleLarge?.copyWith(color:Colors.white,fontWeight:FontWeight.w900)),
          const SizedBox(height:6),
          Text('En önemli iki tercihinizi seçin. Her seçim bir tercih hakkı kullanır.',style:context.texts.bodyMedium?.copyWith(color:const Color(0xFFE8DDF7),height:1.4)),
        ])),
      ]),
      const SizedBox(height:18),
      Text('2 başlangıç tercihinden $selectedCount tanesi seçildi',style:context.texts.titleSmall?.copyWith(color:Colors.white,fontWeight:FontWeight.w800)),
      const SizedBox(height:10),
      ClipRRect(borderRadius:BorderRadius.circular(999),child:LinearProgressIndicator(value:selectedCount/2,minHeight:7,backgroundColor:Colors.white.withOpacity(.18),valueColor:AlwaysStoppedAnimation<Color>(context.tokens.lime))),
      const SizedBox(height:14),
      Row(children:[const Icon(Icons.confirmation_number_outlined,color:Color(0xFFE8DDF7)),const SizedBox(width:9),Text('$remainingRights tercih hakkınız var.',style:context.texts.bodyLarge?.copyWith(color:const Color(0xFFE8DDF7),fontWeight:FontWeight.w600))]),
    ]),
  );
}

class PartnerPreferenceDetailScreen extends StatefulWidget{
  const PartnerPreferenceDetailScreen({super.key,required this.question,required this.initialSelection});
  final _PreferenceQuestion question;final Set<String> initialSelection;
  @override State<PartnerPreferenceDetailScreen> createState()=>_PartnerPreferenceDetailScreenState();
}
class _PartnerPreferenceDetailScreenState extends State<PartnerPreferenceDetailScreen>{
  late Set<String> selected;bool doesntMatter=false;
  @override void initState(){super.initState();selected={...widget.initialSelection};doesntMatter=selected.contains('Fark etmez');if(doesntMatter)selected.clear();}
  void _toggle(String option)=>setState((){doesntMatter=false;if(widget.question.multiSelect){if(!selected.add(option))selected.remove(option);}else{selected={option};}});
  void _toggleDoesntMatter()=>setState((){doesntMatter=!doesntMatter;if(doesntMatter)selected.clear();});
  @override Widget build(BuildContext context){
    const black=Color(0xFF090712);final canSave=selected.isNotEmpty||doesntMatter;
    return Scaffold(backgroundColor:black,body:SafeArea(child:Column(children:[
      Expanded(child:SingleChildScrollView(physics:const AlwaysScrollableScrollPhysics(),padding:EdgeInsets.fromLTRB(context.tokens.spaceLg,18,context.tokens.spaceLg,120),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
        Align(alignment:Alignment.centerLeft,child:IconButton.filledTonal(onPressed:()=>Navigator.of(context).pop(),icon:const Icon(Icons.arrow_back_rounded))),
        const SizedBox(height:18),
        Text(widget.question.title,style:context.texts.headlineLarge?.copyWith(color:Colors.white,fontWeight:FontWeight.w900,height:1.08)),const SizedBox(height:10),
        Text('Karşınızdaki kişide aradığınız cevabı seçin.',style:context.texts.bodyLarge?.copyWith(color:const Color(0xFFC9C3D5))),
        if(widget.question.multiSelect)...[const SizedBox(height:8),Text('Sizin için uygun olan birden fazla cevabı seçebilirsiniz.',style:context.texts.bodyMedium?.copyWith(color:const Color(0xFF8F879A)))],
        const SizedBox(height:22),
        for(final option in widget.question.options)...[_PreferenceOptionCard(label:option,selected:selected.contains(option),square:widget.question.multiSelect,onTap:()=>_toggle(option)),const SizedBox(height:12)],
        const Divider(color:Color(0xFF31283D)),const SizedBox(height:10),
        _PreferenceOptionCard(label:'Fark etmez',selected:doesntMatter,square:false,onTap:_toggleDoesntMatter),
      ]))),
    ])),bottomNavigationBar:SafeArea(minimum:EdgeInsets.fromLTRB(context.tokens.spaceLg,10,context.tokens.spaceLg,16),child:SizedBox(height:58,child:FilledButton(
      onPressed:canSave?()=>Navigator.of(context).pop<Set<String>>(doesntMatter?{'Fark etmez'}:selected):null,
      style:FilledButton.styleFrom(backgroundColor:context.tokens.lime,foregroundColor:black,disabledBackgroundColor:const Color(0xFF221B30),disabledForegroundColor:const Color(0xFF6E6878)),
      child:const Text('Tercihi kaydet',style:TextStyle(fontWeight:FontWeight.w800,fontSize:16)),
    ))));
  }
}
class _PreferenceQuestion{const _PreferenceQuestion({required this.title,required this.options,required this.icon,required this.multiSelect});final String title;final List<String> options;final IconData icon;final bool multiSelect;}
class _PreferenceTile extends StatelessWidget{
  const _PreferenceTile({required this.question,required this.selectedValues,required this.locked,required this.onTap});final _PreferenceQuestion question;final Set<String> selectedValues;final bool locked;final VoidCallback? onTap;
  @override Widget build(BuildContext context){
    final has=selectedValues.isNotEmpty;final subtitle=locked?'2 tercih hakkınız doldu':(has?selectedValues.join(', '):'Henüz seçilmedi');
    return Opacity(opacity:locked ? .45 : 1,child:InkWell(onTap:onTap,borderRadius:BorderRadius.circular(24),child:Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:const Color(0xFF14101D),borderRadius:BorderRadius.circular(24),border:Border.all(color:const Color(0xFF31283D))),child:Row(children:[
      Container(width:52,height:52,decoration:BoxDecoration(color:const Color(0xFF21172F),borderRadius:BorderRadius.circular(16)),child:Icon(locked?Icons.lock_rounded:question.icon,color:locked?const Color(0xFF9E95AA):context.tokens.lime)),const SizedBox(width:14),
      Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(question.title,style:context.texts.titleMedium?.copyWith(color:Colors.white,fontWeight:FontWeight.w800)),const SizedBox(height:6),Text(subtitle,maxLines:2,overflow:TextOverflow.ellipsis,style:context.texts.bodyMedium?.copyWith(color:has?context.tokens.lime:const Color(0xFF9E95AA)))])),const Icon(Icons.chevron_right_rounded,color:Color(0xFFC9C3D5)),
    ]))));
  }
}
class _PreferenceOptionCard extends StatelessWidget{
  const _PreferenceOptionCard({required this.label,required this.selected,required this.square,required this.onTap});final String label;final bool selected,square;final VoidCallback onTap;
  @override Widget build(BuildContext context)=>InkWell(onTap:onTap,borderRadius:BorderRadius.circular(24),child:AnimatedContainer(duration:const Duration(milliseconds:180),padding:const EdgeInsets.symmetric(horizontal:18,vertical:18),decoration:BoxDecoration(color:selected?context.tokens.lime.withOpacity(.10):const Color(0xFF14101D),borderRadius:BorderRadius.circular(24),border:Border.all(color:selected?context.tokens.lime:const Color(0xFF31283D),width:selected?2:1)),child:Row(children:[Icon(square?(selected?Icons.check_box_rounded:Icons.check_box_outline_blank_rounded):(selected?Icons.radio_button_checked_rounded:Icons.radio_button_unchecked_rounded),color:selected?context.tokens.lime:const Color(0xFF9E95AA),size:30),const SizedBox(width:14),Expanded(child:Text(label,style:context.texts.titleLarge?.copyWith(color:Colors.white,fontWeight:FontWeight.w700)))])));
}
