
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:to_do_app/core/util/blocks/app/cubit.dart';
import 'package:to_do_app/core/util/blocks/app/states.dart';
import 'package:to_do_app/features/taskes/presentation/widgets/Schedule_widget.dart';
import 'package:to_do_app/features/taskes/presentation/widgets/task_item.dart';
import 'package:to_do_app/features/taskes/presentation/widgets/tasks_widget.dart';

class tabBar extends StatelessWidget {
   const tabBar({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context){
     return BlocConsumer<AppBloc, AppStates>(
         listener: (context, state) {},
         builder: (context, state) {
     return DefaultTabController(
       length: 4,
       child: Scaffold(
         appBar: AppBar(
           actions:[
             IconButton(
               icon: Icon(
                 Icons.schedule,
                 color: Colors.black,
               ),
               onPressed: () {
                 AppBloc.get(context).updateDay(DateTime.now());
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const scheduleWidget()));
               },
             )
           ],
           elevation: 0,
           foregroundColor: Colors.black,
           backgroundColor: Colors.white,
           bottom: const TabBar(
             labelColor: Colors.black,
             unselectedLabelColor: Colors.grey,
             tabs: [
               Tab(text: "All",),
               Tab(text: "Compeleted"),
               Tab(text: "Uncompleted"),
               Tab(text: "Favourites"),
             ],
           ),
           title: const Text('Board'),
         ),
         body:  TabBarView(
           children: [
             TasksWidget(Tasks: AppBloc.get(context).Tasks),
             TasksWidget(Tasks: AppBloc.get(context).compTasks),
             TasksWidget(Tasks: AppBloc.get(context).unTasks),
             TasksWidget(Tasks: AppBloc.get(context).favTasks),

           ],
         ),
       ),
     );});
   }}