import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'Qeen', votes: 2),
    Band(id: '3', name: 'Depp Purple', votes: 1),
    Band(id: '4', name: 'Bon Jovi', votes: 7),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' BandNames',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        backgroundColor: Colors.blue,
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band banda) {
    return Dismissible(
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        //llamar el borrado en el server
        debugPrint('banda eliminada: ${banda.name}');
      },
      background: Container(
        padding: const EdgeInsets.only(left: 10.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Delete Band',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(banda.name!.substring(0, 2)),
        ),
        title: Text(banda.name!),
        trailing: Text('${banda.votes}', style: const TextStyle(fontSize: 20)),
        onTap: () {
          debugPrint(banda.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New Band name: '),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5,
                color: Colors.blue,
                onPressed: () => addBandToList(textController.text),
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
    }
    if (!Platform.isAndroid) {
      showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('New Band name: '),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => addBandToList(textController.text),
                child: const Text('Add'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context),
                child: const Text('Dismiss'),
              ),
            ],
          );
        },
      );
    }
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      //Podemos agregar
      bands.add(
        Band(
          id: DateTime.now().toString(),
          name: name,
          votes: 5,
        ),
      );
      //redibujamos
      setState(() {});
    }
    Navigator.pop(context);
  }
}
