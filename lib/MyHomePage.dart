import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});




  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Wellcome to my app",style: TextStyle(fontFamily: "Inter",fontWeight: FontWeight.w900),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:

        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(

              children: [
               Text("Wellcome to my app",style: TextStyle(fontFamily: "Inter",fontWeight: FontWeight.w900,fontSize: 30),),

                Text("when  new app open  ",style: TextStyle(fontFamily: "Inter",fontWeight: FontWeight.w700,fontSize: 30),),


                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum.",style: TextStyle(fontSize: 30,fontFamily: "Inter",fontWeight: FontWeight.w500),),
               SizedBox(height: 30,),
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, ",style: TextStyle( fontSize: 30,fontFamily: "Inter",fontWeight: FontWeight.w600),),
                SizedBox(height: 30,),

                Text("Lorem Ipsum is simply dummy text of the printing",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900),),
                 SizedBox(height: 30,),
                Text(" Lorem Ipsum has been the industry's standard dummy text ever since 1966",style: TextStyle(fontSize: 30,fontFamily: "Inter",fontWeight: FontWeight.w400),),
                SizedBox(height: 30,),


              ],
            ),
          ),
        ),


    );
  }
}
