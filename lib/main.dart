import 'package:flutter/material.dart';
import 'package:hello_flutter/tasks.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Flutter',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color.fromARGB(255, 17, 35, 54)),
      debugShowCheckedModeBanner: false,
      home:  const MyHomePage(title: 'Запланированные задачи'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController taskController = TextEditingController();
  List<Tasks> tasks = List.empty(growable: true);

  int selectedIndex = -1;

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 32, 53),
        elevation: 3.0,
        title: const Text (
          ' Запланированные задачи',),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
                Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  ),
            FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color(0xff1E213D),
                      title: const Text("Напишите задачу"),
                      content: TextFormField(
                        controller: taskController,
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text("Добавить"),
                          onPressed: () {
                            String task = taskController.text.trim();
                            if (task.isNotEmpty) {
                              setState(() {
                                taskController.text = '';
                                tasks.add(Tasks(task: task));
                              });
                            }
                          },
                        )
                      ],
                    );
                  },
                );
              },
              child: const Text("+"),
            ),
          ]
        ),
      ),
    );
  }
    Widget getRow(int index) {
    return Card(
      color:  const Color(0xffBA7800),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tasks[index].task,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 20,
          child:
              InkWell(
                  onTap: (() {
                    setState(() {
                      tasks.removeAt(index);
                    });
                  }),
                  child: const Icon(Icons.delete)),
        ),
      ),
    );
  }
}

