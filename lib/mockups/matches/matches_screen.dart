import 'package:flutter/material.dart';
import '../../core/theme/context_ext.dart';
import '../questions/daily_questions_screen.dart';
import 'match_profile_screen.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});
  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> favorites = {};

  static const matches = <_MatchData>[
    _MatchData(name:'Zeynep',city:'İstanbul, TR',age:28,score:92,interests:['Seyahat','Müzik','Kahve'],status:'Şu an aktif',online:true,verified:true,imageUrl:'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=300'),
    _MatchData(name:'Emre',city:'Ankara, TR',age:31,score:88,interests:['Spor','Film','Doğa'],status:'2 saat önce aktif',online:false,imageUrl:'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300'),
    _MatchData(name:'Duru',city:'İzmir, TR',age:26,score:85,interests:['Kitap','Sanat','Yemek'],status:'Şu an aktif',online:true,verified:true,imageUrl:'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300'),
    _MatchData(name:'Mert',city:'Bursa, TR',age:30,score:78,interests:['Müzik','Spor','Teknoloji'],status:'5 saat önce aktif',online:false,imageUrl:'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300'),
    _MatchData(name:'Selin',city:'Antalya, TR',age:27,score:75,interests:['Yemek','Seyahat','Doğa'],status:'Şu an aktif',online:true,verified:true,imageUrl:'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=300'),
  ];

  @override
  void dispose(){_searchController.dispose();super.dispose();}

  void _openMatch(_MatchData m){
    Navigator.of(context).push(MaterialPageRoute(builder:(_)=>MatchProfileScreen(
      name:m.name,city:m.city,age:m.age,score:m.score,interests:m.interests,
      status:m.status,online:m.online,imageUrl:m.imageUrl,verified:m.verified,
    )));
  }

  void _openQuestions()=>Navigator.of(context).push(MaterialPageRoute(builder:(_)=>const DailyQuestionsScreen()));

  @override
  Widget build(BuildContext context){
    const black=Color(0xFF090712);
    final query=_searchController.text.trim().toLowerCase();
    final visible=matches.where((m)=>query.isEmpty||m.name.toLowerCase().contains(query)||m.city.toLowerCase().contains(query)||m.interests.any((e)=>e.toLowerCase().contains(query))).toList();
    return Scaffold(
      backgroundColor:black,
      body:SafeArea(child:Column(children:[
        const _MatchesHero(),
        Padding(
          padding:EdgeInsets.fromLTRB(context.tokens.spaceLg,14,context.tokens.spaceLg,10),
          child:Row(children:[
            Expanded(child:TextField(
              controller:_searchController,
              onChanged:(_)=>setState((){}),
              style:const TextStyle(color:Colors.white),
              decoration:InputDecoration(
                hintText:'İsim, şehir veya ilgi alanı ara',
                prefixIcon:const Icon(Icons.search_rounded),
                filled:true,
                fillColor:const Color(0xFF12101B),
                border:OutlineInputBorder(borderRadius:BorderRadius.circular(24),borderSide:const BorderSide(color:Color(0xFF30263E))),
                enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(24),borderSide:const BorderSide(color:Color(0xFF30263E))),
              ),
            )),
            const SizedBox(width:10),
            Container(width:58,height:58,decoration:BoxDecoration(color:const Color(0xFF12101B),borderRadius:BorderRadius.circular(20),border:Border.all(color:const Color(0xFF30263E))),child:Icon(Icons.tune_rounded,color:context.tokens.lime)),
          ]),
        ),
        Expanded(child:ListView.separated(
          padding:EdgeInsets.fromLTRB(context.tokens.spaceLg,8,context.tokens.spaceLg,120),
          itemCount:visible.length,
          separatorBuilder:(_,__)=>const SizedBox(height:12),
          itemBuilder:(context,i){
            final m=visible[i];
            return _MatchCard(
              data:m,
              favorite:favorites.contains(m.name),
              onTap:()=>_openMatch(m),
              onFavorite:()=>setState((){if(!favorites.add(m.name))favorites.remove(m.name);}),
            );
          },
        )),
      ])),
      bottomNavigationBar:_BottomNav(onQuestions:_openQuestions),
    );
  }
}

class _MatchesHero extends StatelessWidget{
  const _MatchesHero();
  @override Widget build(BuildContext context)=>SizedBox(
    height:210,width:double.infinity,
    child:ClipPath(
      clipper:_OvalBottomClipper(),
      child:Container(
        decoration:const BoxDecoration(gradient:LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFF9A4DFF),Color(0xFF6D21D7),Color(0xFF45108D)])),
        child:Stack(children:[
          Center(child:Padding(padding:const EdgeInsets.only(bottom:24),child:Column(mainAxisSize:MainAxisSize.min,children:[
            Icon(Icons.favorite_border_rounded,color:context.tokens.lime,size:48),
            const SizedBox(height:8),
            Text('Eşleşmeler',style:context.texts.headlineLarge?.copyWith(color:Colors.white,fontWeight:FontWeight.w900)),
            const SizedBox(height:4),
            Text('Seninle uyumlu olabilecek kişiler',style:context.texts.bodyLarge?.copyWith(color:const Color(0xFFD7CDE4))),
          ]))),
          const Positioned(right:20,top:18,child:Icon(Icons.refresh_rounded,color:Colors.white,size:30)),
        ]),
      ),
    ),
  );
}

class _MatchCard extends StatelessWidget{
  const _MatchCard({required this.data,required this.favorite,required this.onTap,required this.onFavorite});
  final _MatchData data;
  final bool favorite;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      behavior:HitTestBehavior.opaque,
      onTap:onTap,
      child:Container(
        width:double.infinity,
        padding:const EdgeInsets.all(16),
        decoration:BoxDecoration(
          color:const Color(0xFF111019),
          borderRadius:BorderRadius.circular(26),
          border:Border.all(color:const Color(0xFF2B2338)),
        ),
        child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Stack(clipBehavior:Clip.none,children:[
            Container(
              width:92,height:92,padding:const EdgeInsets.all(2),
              decoration:BoxDecoration(shape:BoxShape.circle,border:Border.all(color:context.tokens.lime,width:2)),
              child:ClipOval(child:Image.network(data.imageUrl,fit:BoxFit.cover,errorBuilder:(_,__,___)=>const ColoredBox(color:Color(0xFF21172F),child:Icon(Icons.person_rounded,color:Colors.white70,size:44)))),
            ),
            Positioned(right:0,bottom:3,child:Container(width:18,height:18,decoration:BoxDecoration(color:data.online?context.tokens.lime:const Color(0xFF9B95A5),shape:BoxShape.circle,border:Border.all(color:const Color(0xFF111019),width:3)))),
          ]),
          const SizedBox(width:14),
          Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Row(children:[
              Text(data.name,style:context.texts.titleLarge?.copyWith(color:Colors.white,fontWeight:FontWeight.w900)),
              if(data.verified)...[const SizedBox(width:6),const Icon(Icons.verified_rounded,color:Color(0xFF8B34FF),size:20)],
            ]),
            const SizedBox(height:6),
            Wrap(spacing:10,runSpacing:6,children:[_Meta(icon:Icons.location_on_outlined,text:data.city),_Meta(icon:Icons.person_outline_rounded,text:'${data.age}')]),
            const SizedBox(height:10),
            Wrap(spacing:6,runSpacing:6,children:data.interests.map((e)=>_Interest(label:e)).toList()),
            const SizedBox(height:9),
            Row(children:[
              Container(width:7,height:7,decoration:BoxDecoration(color:data.online?context.tokens.lime:const Color(0xFF827B8D),shape:BoxShape.circle)),
              const SizedBox(width:6),
              Text(data.status,style:context.texts.bodySmall?.copyWith(color:data.online?context.tokens.lime:const Color(0xFF9D96A7))),
            ]),
          ])),
          const SizedBox(width:10),
          Column(children:[
            Container(
              padding:const EdgeInsets.symmetric(horizontal:12,vertical:10),
              decoration:BoxDecoration(color:const Color(0xFF1A1723),borderRadius:BorderRadius.circular(18)),
              child:Column(children:[
                Text('%${data.score}',style:TextStyle(color:context.tokens.lime,fontSize:22,fontWeight:FontWeight.w900)),
                const Text('Uyum',style:TextStyle(color:Color(0xFFA49BAF),fontSize:11)),
              ]),
            ),
            const SizedBox(height:14),
            GestureDetector(
              behavior:HitTestBehavior.opaque,
              onTap:onFavorite,
              child:Container(
                width:46,height:46,
                decoration:BoxDecoration(shape:BoxShape.circle,border:Border.all(color:const Color(0xFF514765))),
                child:Icon(favorite?Icons.favorite_rounded:Icons.favorite_border_rounded,color:context.tokens.lime),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}

class _Meta extends StatelessWidget{
  const _Meta({required this.icon,required this.text});
  final IconData icon;final String text;
  @override Widget build(BuildContext context)=>Row(mainAxisSize:MainAxisSize.min,children:[Icon(icon,color:const Color(0xFFBDB5C7),size:17),const SizedBox(width:4),Text(text,style:const TextStyle(color:Color(0xFFC9C3D5),fontSize:13))]);
}
class _Interest extends StatelessWidget{
  const _Interest({required this.label});final String label;
  @override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:5),decoration:BoxDecoration(color:const Color(0xFF1B1825),borderRadius:BorderRadius.circular(999)),child:Text(label,style:const TextStyle(color:Color(0xFFD1CAD9),fontSize:12)));
}

class _BottomNav extends StatelessWidget{
  const _BottomNav({required this.onQuestions});final VoidCallback onQuestions;
  @override Widget build(BuildContext context)=>SafeArea(top:false,child:Container(
    padding:const EdgeInsets.fromLTRB(18,12,18,10),
    decoration:const BoxDecoration(color:Color(0xFF0E0C15),borderRadius:BorderRadius.vertical(top:Radius.circular(30))),
    child:Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[
      const _NavItem(icon:Icons.favorite_rounded,label:'Eşleşmeler',active:true),
      _NavItem(icon:Icons.quiz_outlined,label:'Sorular',onTap:onQuestions),
      const _NavItem(icon:Icons.chat_bubble_outline_rounded,label:'Mesajlar'),
      const _NavItem(icon:Icons.person_outline_rounded,label:'Profil'),
    ]),
  ));
}
class _NavItem extends StatelessWidget{
  const _NavItem({required this.icon,required this.label,this.active=false,this.onTap});
  final IconData icon;final String label;final bool active;final VoidCallback? onTap;
  @override Widget build(BuildContext context)=>InkWell(
    onTap:onTap,borderRadius:BorderRadius.circular(18),
    child:Padding(padding:const EdgeInsets.symmetric(horizontal:8,vertical:4),child:Column(mainAxisSize:MainAxisSize.min,children:[
      Icon(icon,color:active?context.tokens.lime:const Color(0xFFA49CAE),size:27),
      const SizedBox(height:5),
      Text(label,style:TextStyle(color:active?context.tokens.lime:const Color(0xFFA49CAE),fontWeight:active?FontWeight.w800:FontWeight.w500,fontSize:12)),
      if(active)...[const SizedBox(height:6),Container(width:38,height:4,decoration:BoxDecoration(color:context.tokens.lime,borderRadius:BorderRadius.circular(999)))],
    ])),
  );
}

class _MatchData{
  const _MatchData({required this.name,required this.city,required this.age,required this.score,required this.interests,required this.status,required this.online,required this.imageUrl,this.verified=false});
  final String name,city,status,imageUrl;final int age,score;final List<String> interests;final bool online,verified;
}
class _OvalBottomClipper extends CustomClipper<Path>{
  @override Path getClip(Size size){final p=Path()..lineTo(0,size.height-46);p.quadraticBezierTo(size.width*.5,size.height+22,size.width,size.height-46);p..lineTo(size.width,0)..close();return p;}
  @override bool shouldReclip(covariant CustomClipper<Path> oldClipper)=>false;
}
