import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1',name:'Metalica', votes: 5),
    Band(id: '2',name:'Queen', votes: 2),    
    Band(id: '3',name:'Heroes del silencio', votes: 4),
    Band(id: '4',name:'BonJovi', votes: 6),
    Band(id: '5',name:'Imagine Dragons', votes: 5)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames',style: TextStyle(color: Colors.black87)),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
         itemCount: bands.length, 
         itemBuilder: (BuildContext context, int index)  => _bandTile(bands [index])

      
     ),
     floatingActionButton:FloatingActionButton(
       child: Icon(Icons.add),
       elevation: 1,
       onPressed: addNewBand,
     )
   );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
        key: Key(band.id),
        direction: DismissDirection.startToEnd,
        onDismissed: (DismissDirection direction){
          print('direction: $direction');
          print('id: ${band.name}');
        },
        background: Container(
          padding: EdgeInsets.only( left: 15.0),
          color:Colors.red ,
          child:Align(
            alignment: Alignment.centerLeft,
            child: Text('Delete Band', style:TextStyle(color:Colors.white)),
          )),
        child: ListTile(
        leading:CircleAvatar(
          child: Text(band.name.substring(0,2)),
          backgroundColor:  Colors.blue[100],
          

        ),
        title: Text(band.name),
        trailing: Text('${band.votes}',style:TextStyle(fontSize: 20)),
        onTap:() {
          print(band.name);
        }, 
        ),
      );
  }

  addNewBand(){

    final textController = new TextEditingController();

    if(!Platform.isAndroid){

      showCupertinoDialog(context: context, builder: (_){
       return CupertinoAlertDialog(
        title:Text('New Band name:'),
        content: CupertinoTextField(
          controller: textController ,
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Add'),
            onPressed: ()=>addBandToList(textController.text)

          ),
          CupertinoDialogAction(isDefaultAction: true,child: Text('Dissmis'),onPressed: ()=>Navigator.pop(context),)
        ],
       );
     }
     );

      }

      else{
        showDialog(
      context: context,
       builder:(context){
         return AlertDialog(
           title:Text('New Band Name:'),
           content:TextField(
             controller: textController,
           ),
           actions:<Widget>[
             MaterialButton(
               child:Text('Add'),
               elevation:5,
               textColor:Colors.blue,
               onPressed:() =>addBandToList(textController.text) 
               )
           ],
         );
       });
      }

     
    
  }

  void addBandToList(String name){
    print(name);
    if(name.length>1){
      
      this.bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      Navigator.pop(context);

    }
  }

}