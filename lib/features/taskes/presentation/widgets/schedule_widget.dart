
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/util/blocks/app/cubit.dart';
import 'package:to_do_app/core/util/blocks/app/states.dart';
import 'package:to_do_app/features/taskes/presentation/widgets/schedule_item.dart';
import 'package:to_do_app/features/taskes/presentation/widgets/task_item.dart';

class scheduleWidget extends StatelessWidget {
  const scheduleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(

            backgroundColor: Colors.white,
            appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      title: Text("Schedule"),
                  ),
            body: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey
                              )
                          ),
                          child: DatePicker(
                                monthTextStyle: TextStyle(
                                color: Colors.white
                            ),
                            DateTime.now(
                          ),
                            width: 65,
                            height: 80,
                            initialSelectedDate: DateTime.now(),
                            selectionColor: Colors.green,
                            selectedTextColor: Colors.white,
                            dateTextStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                        ),
                            onDateChange: (date){
                                  AppBloc.get(context).updateDay(date);
                                  print(date);
                                  },
                          )
                      ),
                        Container(
                          padding: EdgeInsets.all(15),
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(DateFormat.EEEE().format(AppBloc.get(context).day),
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                              Text(DateFormat.yMMMd().format(AppBloc.get(context).day),
                              style: TextStyle(fontSize: 16),),
                            ],
                          ),

                        ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            AppBloc.get(context).getTasksData();
                          },
                          child: ListView.separated(
                            itemBuilder: (context, index) => ScheduleItem(
                              item: AppBloc.get(context).selectedDay[index],
                            ),
                            separatorBuilder: (context, index) => Container(),
                            itemCount: AppBloc.get(context).selectedDay.length,
                          ),
                        ),
                      )
                    ],
            ),
          );});
  }
}
