import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';

class DailyQuestionsScreen extends StatefulWidget {
  const DailyQuestionsScreen({super.key});
  @override State<DailyQuestionsScreen> createState()=>_DailyQuestionsScreenState();
}

class _DailyQuestionsScreenState extends State<DailyQuestionsScreen>{
  int index=0;
  final Map<int,String> answers={};
  bool completed=false;

  static const questions=<_DailyQuestion>[
    _DailyQuestion('Bir günde partnerinizi (ayrıyken) ne kadar özlersiniz?',['Hiç özlemem','Az','Orta','Çok','Dayanılmaz derecede']),
    _DailyQuestion('Ekran süresi (telefon/bilgisayar) konusunda kendini nasıl görürsün?',['Çok fazla vakit geçiriyorum','Ortalama bir kullanıcıyım','Bilinçli olarak sınırlıyorum','Çok az kullanırım']),
    _DailyQuestion('Kendi restoranını açmak ister miydin?',['Evet','Hayır']),
    _DailyQuestion('Klasik müzik mi, elektronik müzik mi?',['Klasik müzik','Elektronik müzik']),
    _DailyQuestion('Evlilik senin için önemli mi?',['Evet','Hayır']),
    _DailyQuestion('Böceklerden tiksinir misin?',['Evet','Hayır']),
    _DailyQuestion('Spor yapmak günlük rutininin bir parçası mı?',['Evet','Hayır']),
    _DailyQuestion('Sabah insanı mısın?',['Evet','Hayır']),
    _DailyQuestion('İlişkide özür dilemekte ne kadar zorlanırsınız?',['Hiç zorlanmam','Az','Orta','Çok','Aşırı zorlanırım']),
    _DailyQuestion('Sigara içer misiniz?',['Hiç içmedim','Bıraktım','Nadiren (sosyal ortamda)','Günde birkaç adet','Günde bir paket','Bir paketten fazla']),
  ];

  String? get selected=>answers[index];
  void _next(){if(selected==null)return;if(index<questions.length-1){setState(()=>index++);}else{setState(()=>completed=true);}}
  void _previous(){if(index>0)setState(()=>index--);}
  void _review(){setState((){completed=false;index=0;});}
  void _reset()=>setState((){index=0;answers.clear();completed=false;});

  @override Widget build(BuildContext context){
    if(completed)return _CompletionView(onReview:_review,onMatches:()=>Navigator.of(context).pop());
    final q=questions[index];
    return Scaffold(
      backgroundColor:const Color(0xFF090712),
      appBar:AppBar(backgroundColor:const Color(0xFF090712),foregroundColor:Colors.white,centerTitle:true,title:const Text('Günlük Sorular',style:TextStyle(fontWeight:FontWeight.w900)),automaticallyImplyLeading:false,actions:[IconButton(onPressed:_reset,icon:const Icon(Icons.refresh_rounded))]),
      body:SafeArea(top:false,child:Column(children:[
        Padding(padding:const EdgeInsets.fromLTRB(22,14,22,12),child:Column(children:[
          Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text('Soru ${index+1} / ${questions.length}',style:TextStyle(color:context.tokens.lime,fontWeight:FontWeight.w800,fontSize:16)),Text('${answers.length} / ${questions.length} tamamlandı',style:const TextStyle(color:Colors.white70,fontWeight:FontWeight.w700))]),
          const SizedBox(height:12),ClipRRect(borderRadius:BorderRadius.circular(99),child:LinearProgressIndicator(value:(index+1)/questions.length,minHeight:7,backgroundColor:const Color(0xFF282333),valueColor:AlwaysStoppedAnimation(context.tokens.lime))),
        ])),
        Expanded(child:SingleChildScrollView(padding:const EdgeInsets.fromLTRB(22,14,22,18),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text(q.text,style:const TextStyle(color:Colors.white,fontSize:30,height:1.2,fontWeight:FontWeight.w800)),const SizedBox(height:28),
          for(final option in q.options)...[_AnswerCard(label:option,selected:selected==option,onTap:()=>setState(()=>answers[index]=option)),const SizedBox(height:12)],
          const Divider(color:Color(0xFF332B40)),const SizedBox(height:10),_AnswerCard(label:'Cevap vermek istemiyorum',selected:selected=='Cevap vermek istemiyorum',muted:true,icon:Icons.block_rounded,onTap:()=>setState(()=>answers[index]='Cevap vermek istemiyorum')),
        ]))),
        Padding(padding:const EdgeInsets.fromLTRB(22,10,22,16),child:Row(children:[
          if(index>0)...[Expanded(child:SizedBox(height:58,child:OutlinedButton.icon(onPressed:_previous,icon:const Icon(Icons.arrow_back_rounded),label:const Text('Önceki'),style:OutlinedButton.styleFrom(foregroundColor:Colors.white,side:const BorderSide(color:Color(0xFF5B506A)),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)))))),const SizedBox(width:12)],
          Expanded(child:SizedBox(height:58,child:FilledButton(onPressed:selected==null?null:_next,style:FilledButton.styleFrom(backgroundColor:context.tokens.lime,foregroundColor:Colors.black,disabledBackgroundColor:const Color(0xFF28252F),disabledForegroundColor:const Color(0xFF77717E),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20))),child:Text(index==questions.length-1?'Kaydet ve tamamla':'Kaydet ve devam et',style:const TextStyle(fontWeight:FontWeight.w900))))),
        ])),
      ])),
    );
  }
}

class _CompletionView extends StatelessWidget{
  const _CompletionView({required this.onReview,required this.onMatches});
  final VoidCallback onReview;final VoidCallback onMatches;
  @override Widget build(BuildContext context)=>Scaffold(
    backgroundColor:const Color(0xFF090712),
    appBar:AppBar(backgroundColor:const Color(0xFF090712),foregroundColor:Colors.white,automaticallyImplyLeading:false,centerTitle:true,title:const Text('Günlük Sorular',style:TextStyle(fontWeight:FontWeight.w900))),
    body:SafeArea(child:Padding(padding:const EdgeInsets.fromLTRB(24,18,24,24),child:Column(children:[
      const Spacer(flex:2),
      Container(width:112,height:112,decoration:BoxDecoration(shape:BoxShape.circle,color:const Color(0xFF1B1230),border:Border.all(color:context.tokens.lime,width:3)),child:Icon(Icons.check_rounded,color:context.tokens.lime,size:62)),
      const SizedBox(height:28),
      const Text('Bugünün soruları\ntamamlandı',textAlign:TextAlign.center,style:TextStyle(color:Colors.white,fontSize:32,height:1.15,fontWeight:FontWeight.w900)),
      const SizedBox(height:14),
      const Text('10 sorunun 10 tanesini tamamladın.\nBugünkü set kapanana kadar cevaplarını gözden geçirip değiştirebilirsin.',textAlign:TextAlign.center,style:TextStyle(color:Color(0xFFBDB4C9),fontSize:16,height:1.5,fontWeight:FontWeight.w500)),
      const SizedBox(height:30),
      SizedBox(width:double.infinity,height:58,child:FilledButton.icon(onPressed:onReview,icon:const Icon(Icons.edit_note_rounded),label:const Text('Cevapları gözden geçir'),style:FilledButton.styleFrom(backgroundColor:const Color(0xFF7C2CFF),foregroundColor:Colors.white,textStyle:const TextStyle(fontSize:16,fontWeight:FontWeight.w900),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20))))),
      const SizedBox(height:12),
      SizedBox(width:double.infinity,height:56,child:OutlinedButton.icon(onPressed:onMatches,icon:const Icon(Icons.favorite_rounded),label:const Text('Eşleşmelere dön'),style:OutlinedButton.styleFrom(foregroundColor:context.tokens.lime,side:const BorderSide(color:Color(0xFF4B3C60)),textStyle:const TextStyle(fontWeight:FontWeight.w800),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20))))),
      const Spacer(flex:3),
    ]))),
  );
}

class _AnswerCard extends StatelessWidget{
  const _AnswerCard({required this.label,required this.selected,required this.onTap,this.muted=false,this.icon});
  final String label;final bool selected;final VoidCallback onTap;final bool muted;final IconData? icon;
  @override Widget build(BuildContext context)=>Material(color:Colors.transparent,child:InkWell(onTap:onTap,borderRadius:BorderRadius.circular(22),child:Ink(width:double.infinity,padding:const EdgeInsets.symmetric(horizontal:18,vertical:19),decoration:BoxDecoration(color:selected?const Color(0xFF25163B):(muted?const Color(0xFF121019):const Color(0xFF14111D)),borderRadius:BorderRadius.circular(22),border:Border.all(color:selected?context.tokens.lime:const Color(0xFF332B40),width:selected?2:1)),child:Row(children:[Icon(icon??(selected?Icons.radio_button_checked_rounded:Icons.radio_button_off_rounded),color:selected?context.tokens.lime:const Color(0xFFAAA1B4),size:30),const SizedBox(width:15),Expanded(child:Text(label,style:TextStyle(color:selected?Colors.white:const Color(0xFFD5CDDF),fontSize:17,fontWeight:selected?FontWeight.w800:FontWeight.w600)))]))));
}
class _DailyQuestion{const _DailyQuestion(this.text,this.options);final String text;final List<String> options;}
