import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Todo {
  String title;
  String id;
  String description;
  bool done;

  Todo({this.description, this.done, this.id, this.title});

  Todo.fromMap(Map<String, dynamic> data) {
    this.title = data['title'];
    this.id = data['id'];
    this.description = data['description'];
    this.done = data['done'] == 1;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? 'id',
      'title': title ?? 'title',
      'description': description ?? 'desc',
      'done': done ? 1 : 0,
    };
  }
}

class TodoScreen extends StatefulWidget {
  static const routeName = '/todo-screen';
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Todo> pending = [
    Todo(
        title: 'Title',
        description: 'description',
        id: '${DateTime.now().millisecondsSinceEpoch}',
        done: false),
  ];
  List<Todo> completed = [
    Todo(
        title: 'Title',
        description: 'description',
        id: '${DateTime.now().millisecondsSinceEpoch}',
        done: true),
  ];

  Database db;

  initDb() async {
    // get location of DB using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');

    // opening  database
    db = await openDatabase(path, version: 1,
        // if DB doesn't exist
        onCreate: (Database db, int version) async {
      // while creating the db, create the Todo table
      await db.execute("""
           CREATE TABLE Todo(
           id TEXT PRIMARY KEY, 
           title TEXT,
           done INTEGER,
           description TEXT
          )""");
    });

    var tempTodos = await getTodos();
    var tempCompletedTodos = await getCompletedTodos();
    setState(() {
      if (tempCompletedTodos != null && tempCompletedTodos.length > 0) {
        completed = tempCompletedTodos;
      }
      if (tempTodos != null && tempTodos.length > 0) {
        pending = tempTodos;
      }
    });
  }

  Future<List<Todo>> getTodos() async {
    List<Map> maps = await db.query('Todo',
        columns: ['id', 'done', 'title', 'description'],
        where: 'done = ?',
        whereArgs: [0]);
    // checking if the item exist
    if (maps.length > 0) {
      List<Todo> todos = [];
      for (var map in maps) {
        print(map);
        todos.add(Todo.fromMap(map));
      }
      return todos;
    }
    // if doesn't exist return null
    return null;
  }

  Future<List<Todo>> getCompletedTodos() async {
    List<Map> maps = await db.rawQuery('SELECT * FROM Todo WHERE done=1');

    // checking if the item exist
    if (maps.length > 0) {
      List<Todo> todos = [];
      for (var map in maps) {
        print(map);
        todos.add(Todo.fromMap(map));
      }
      return todos;
    }
    // if doesn't exist return null
    return null;
  }

  Future<void> addTodo(Todo todo) async {
    // inserting a Todo
    print(todo.toMap());
    await db.insert('Todo', todo.toMap());
  }

  Future<int> update(Todo todo) async {
    // returns how many rows were updated
    return await db.update(
      'Todo',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> delete(String id) async {
    // returns how many rows deleted
    return await db.delete(
      'Todo', // table name
      where: 'id = ?', // where clause
      whereArgs: [id], // args
    );
  }

  Future<void> close() async => await db.close();

  @override
  void initState() {
    initDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                'ADD',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.blueAccent),
              ),
              buildAdd(height),
              Text(
                'TODO',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.deepPurpleAccent),
              ),
              buildTodo(height),
              Text(
                'DONE',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.green),
              ),
              buildDone(height),
            ],
          ),
        ),
      ),
    );
  }

  Container buildAdd(double height) {
    var titleController = TextEditingController();
    var descriptionController = TextEditingController();
    return Container(
      height: 0.26 * height,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: titleController,
            decoration:
                InputDecoration(labelText: 'Title', hintText: 'Enter a Todo'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: descriptionController,
            decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter more details about Todo'),
          ),
        ),
        FlatButton.icon(
          label: Text('Todo'),
          textColor: Colors.blue,
          icon: Icon(
            Icons.add,
            color: Colors.blue,
          ),
          onPressed: () async {
            final todo = Todo(
                description: descriptionController.text,
                title: titleController.text,
                id: '${DateTime.now().millisecondsSinceEpoch}',
                done: false);
            await addTodo(todo);

            setState(() {
              pending.add(todo);
            });
          },
        ),
      ]),
    );
  }

  Container buildDone(double height) {
    return Container(
      height: 0.3 * height,
      child: ListView.builder(
        itemCount: completed.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(completed[index].title),
            subtitle: Text(completed[index].description),
            leading: Icon(
              Icons.done,
              color: Colors.green,
            ),
            trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () async {
                  int i = await delete(completed[index].id);
                  print('$i rows deleted');
                  setState(() {
                    completed.removeAt(index);
                  });
                }),
            onLongPress: () async {
              final todo = Todo(
                  description: completed[index].description,
                  title: completed[index].title,
                  id: completed[index].id,
                  done: false);
              int i = await update(todo);
              print('$i rows affected');
              setState(() {
                completed.removeAt(index);
                pending.add(todo);
              });
            },
          );
        },
      ),
    );
  }

  Container buildTodo(double height) {
    return Container(
      height: 0.3 * height,
      child: ListView.builder(
        itemCount: pending.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(pending[index].title),
            subtitle: Text(pending[index].description),
            trailing: Checkbox(
                value: pending[index].done,
                onChanged: (val) async {
                  int i = await update(Todo(
                      description: pending[index].description,
                      title: pending[index].title,
                      id: pending[index].id,
                      done: val));
                  print('$i rows affected');
                  setState(() {
                    completed.add(pending[index]);
                    pending.removeAt(index);
                  });
                }),
          );
        },
      ),
    );
  }
}
