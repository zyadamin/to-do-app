
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/core/util/blocks/app/states.dart';
import 'package:path/path.dart' as p;
import 'package:to_do_app/features/taskes/presentation/widgets/get_Colors.dart';


class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(AppInitialState());

  static AppBloc get(context) => BlocProvider.of<AppBloc>(context);

  late Database database;
  DateTime day=DateTime.now();
  late String time;


  void initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'task.db');

    debugPrint('AppDatabaseInitialized');

    openAppDatabase(
      path: path,
    );

    emit(AppDatabaseInitialized());
  }

  void openAppDatabase({
    required String path,
  }) async {
    openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE task (id INTEGER PRIMARY KEY, title TEXT,date TEXT,starttime TEXT, endtime TEXT, remind TEXT,'
              'completed INTEGER,fav INTEGER, color INTEGER)',
        );

        debugPrint('Table Created');
      },
      onOpen: (Database db) {
        debugPrint('AppDatabaseOpened');
        database = db;

        getTasksData();
      },
    );
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController remindController = TextEditingController();


  void insertTaskData() {

    Random random = new Random();
    int randomNumber = random.nextInt(getColors.colors.length);

    database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO task(title,date,starttime,endtime,remind,completed,fav,color) VALUES("${titleController.text}","${dateController.text}",'
              '"${startController.text}","${endController.text}","${remindController.text}","0","0",${randomNumber})');
    }).then((value) {
      debugPrint('User Data Inserted');
      createNotifaction(titleController.text);
      titleController.clear();
      dateController.clear();
      startController.clear();
      endController.clear();
      remindController.clear();
      getTasksData();

      emit(AppDatabaseUserCreated());
    });
  }

  List<Map> Tasks = [];
  List<Map> compTasks = [];
  List<Map> unTasks = [];
  List<Map> favTasks = [];
  List<Map> selectedDay=[];

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  void getTasksData() async {

    emit(AppDatabaseLoading());

    database.rawQuery('SELECT * FROM task').then((value) {
      debugPrint('Users Data Fetched');
      Tasks = value;
      compTasks = Tasks.where((h1) =>h1['completed']== 1).toList();
      unTasks = Tasks.where((h1) =>h1['completed']==0).toList();
      favTasks = Tasks.where((h1) =>h1['fav']== 1).toList();
      selectedDay=Tasks.where((h1) =>h1['date']==formatter.format(day) ).toList();
      debugPrint(Tasks.toString());
      emit(AppDatabaseUsers());
    });

  }

  void completeTask(int id){

    database.rawUpdate(
        'UPDATE task SET completed = ? WHERE id = ${id}', [
      ("1"),
    ]).then((value) {
      debugPrint('task completed');
      getTasksData();
    });


  }


  void unCompleteTask(int id){

    database.rawUpdate(
        'UPDATE task SET completed = ? WHERE id = ${id}', [
      ("0"),
    ]).then((value) {
      debugPrint('task UnCompleted');
      getTasksData();
    });


  }

  void favTask(int id){

    database.rawUpdate(
        'UPDATE task SET fav = ? WHERE id = ${id}', [
      ("1"),
    ]).then((value) {
      debugPrint('task fav');
      getTasksData();
    });


  }



  void deleteTask(int id){

    database.rawDelete(
    'DELETE FROM task WHERE id = ${id}').then((value) {
      debugPrint('task delete');
      getTasksData();
    });


  }



  void mangeTask(int state,int id){

    if(state==1){

      completeTask(id);
    }
    else if(state==2){

      unCompleteTask(id);

    }
    else if(state==3){
      favTask(id);
    }

    else{
      deleteTask(id);
    }

  }

  void updateDay(DateTime date){

    selectedDay=Tasks.where((h1) =>h1['date']==formatter.format(date)).toList();
    day=date;
    emit(updateSelctedDay());

  }

 void createNotifaction(String title) async{
    await AwesomeNotifications().createNotification(
       content: NotificationContent(
           id: 10,
           channelKey: 'basic_channel',
           title: 'Reminder',
           body: title
       ),
        schedule: NotificationCalendar.fromDate(date: DateTime.parse(dateController.text+" "+time+":00"))
   );

  //  AwesomeNotifications().cancel(1);

  }


}
