import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
import '../../screens/navigation_bottom.dart';

import 'package:flutterfirebase/screens/chitiet.dart';

final _firestore = FirebaseFirestore.instance;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const String id = 'home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final nameTextController = TextEditingController();
  final noteTextController = TextEditingController();

  // String? imageUrl;
  String? name;
  String? note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("KeepNote"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 6,
          ),
          Container(
            height: 64,
            margin: const EdgeInsets.only(bottom: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  // Text(
                  //   'Danh sách công việc',
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 25,
                  //     color: Colors.purple,
                  //   ),
                  // ),
                  SizedBox(width: 12),
                ]),
          ),
          const HienThi(),
          

        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Thêm công việc'),
            content: SizedBox(
              height: 250,
              child: Column(
                children: [
                  TextField(
                    controller: nameTextController,
                    decoration: const InputDecoration(
                      label: Text('Nhập tên công việc'),
                    ),
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  TextField(
                    controller: noteTextController,
                    decoration: const InputDecoration(
                      label: Text('Nhập ghi chú cho công việc'),
                    ),
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      note = value;
                    },
                  ),
                  
                  //Checkbox(value: value, onChanged: onChanged)
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  nameTextController.clear();
                  noteTextController.clear();
                  _firestore.collection('products').add({
                    'name': name,
                    'note': note,
                    'timestamp': DateTime.now(),
                    'date':
                        "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}, ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  });
                  Navigator.pop(context, 'OK');
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HienThi extends StatelessWidget {
  const HienThi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            _firestore.collection('products').orderBy('timestamp').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final products = snapshot.data!.docs.reversed;

          List<Cardcongviec> messageBubbles = [];

          for (var product in products) {
            final name = product.get('name');
            final note = product.get('note');
            final date = product.get('date');
            final messageBubble = Cardcongviec(
              name: name,
              note: note,
              id: product.id,
              date: date,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: GridView.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              primary: false,
              crossAxisCount: 2,
              children: messageBubbles,
            ),
          );
        });
  }
}

class Cardcongviec extends StatelessWidget {
  Cardcongviec({this.name, this.note, this.id, this.date});

  final String? name;
  final String? note;
  final String? id;
  final String? date;

  CollectionReference del = _firestore.collection("products");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => Chitiet(
                        id: id!,
                        note: note!,
                        name: name!,
                        date: date!,
                      )));
        },
        child: Card(
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                height: 6,
              ),
              Column(
                children: [
                  Text(
                    name!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    note!,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                // style: ButtonStyle(
                //
                // ),
                child: const Text("Xong"),
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(

                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Thông báo')
                      ],
                    ),
                    content:

                        const Text('Bạn đã làm xong công việc, có muốn xóa?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          del.doc(id).delete();
                          Navigator.pop(context, 'OK');
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                  //del.doc(id).delete();
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
