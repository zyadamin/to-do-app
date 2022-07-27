
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/util/blocks/app/cubit.dart';
import 'package:to_do_app/core/util/blocks/app/states.dart';
import 'package:to_do_app/features/taskes/presentation/pages/addTask_page.dart';
import 'package:to_do_app/features/taskes/presentation/widgets/button_item.dart';
import 'package:to_do_app/features/taskes/presentation/widgets/task_item.dart';

class TasksWidget extends StatelessWidget {

  final List Tasks;

  const TasksWidget({Key? key,
  required this.Tasks}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    AppBloc.get(context).getTasksData();
                  },
                  child: ListView.separated(
                    itemBuilder: (context, index) => TaskItem(
                     item: this.Tasks[index],
                    ),
                    separatorBuilder: (context, index) => Container(),
                    itemCount: this.Tasks.length,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ButtonItem(title: "Add a Task",onClick: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const addTaskPage()),
              );})
            ],
          ),
        );
      },
    );
  }

}
