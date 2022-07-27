

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/util/blocks/app/cubit.dart';
import 'package:to_do_app/features/taskes/presentation/widgets/button_item.dart';

class addTaskPage extends StatefulWidget {
   const addTaskPage({Key? key}) : super(key: key);

  @override
  State<addTaskPage> createState() => _addTaskPageState();
}

class _addTaskPageState extends State<addTaskPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();



  @override
   Widget build(BuildContext context) {
     return Scaffold(
         resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
                title: Text('Add Task'),
            ),

        body: Padding(
              padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 25,
                  child: Text("Title",style:
                  TextStyle(fontWeight: FontWeight.bold,fontSize: 17) )
              ),
              TextFormField(
                controller: AppBloc.get(context).titleController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius:  BorderRadius.all(Radius.circular(7))
                    ),
                  )

              ),
              SizedBox(height: 20,),
              Container(
                  height: 25,
                  child: Text("Deadline",style:
                  TextStyle(fontWeight: FontWeight.bold,fontSize: 17) )
              ),
              TextFormField(
                readOnly: true,
                controller: AppBloc.get(context).dateController,
                decoration: InputDecoration(
                  suffixIcon: TextButton(
                    onPressed: () {
                      selectTheDate(context);
                    },
                    child: Icon(Icons.arrow_drop_down)
                  ),
                  border: const OutlineInputBorder(
                      borderRadius:  BorderRadius.all(Radius.circular(7))
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                            Container(
                                height: 25,
                                child: Text("Start time",style:
                                TextStyle(fontWeight: FontWeight.bold,fontSize: 17) )
                            ),
                            Container(
                              child: TextFormField(
                                readOnly: true,
                                controller: AppBloc.get(context).startController,
                                decoration: InputDecoration(
                                  suffixIcon: TextButton(
                                      onPressed: () {
                                        selectStartTime(context);
                                      },
                                      child: Icon(Icons.access_time_sharp)
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius:  BorderRadius.all(Radius.circular(7))

                                  ),
                                ),
                              ),
                            ),

                          ],

                      ),

                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 25,
                              child: Text("End time",style:
                              TextStyle(fontWeight: FontWeight.bold,fontSize: 17) )
                          ),
                          Container(
                            child: TextFormField(
                              readOnly: true,
                              controller: AppBloc.get(context).endController,
                              decoration: InputDecoration(
                                suffixIcon: TextButton(
                                    onPressed: () {
                                      selectEndTime(context);
                                    },
                                    child: Icon(Icons.access_time_sharp)
                                ),
                                border: const OutlineInputBorder(
                                    borderRadius:  BorderRadius.all(Radius.circular(7))
                                ),
                              ),
                            ),
                          ),

                        ],

                      ),

                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Container(
                  height: 25,
                  child: Text("Remind",style:
                  TextStyle(fontWeight: FontWeight.bold,fontSize: 17) )
              ),
              TextFormField(
                readOnly: true,
                controller: AppBloc.get(context).remindController,
                decoration: InputDecoration(
                  suffixIcon: PopupMenuButton(
                    onSelected: (value){
                      AppBloc.get(context).remindController.text=value.toString();
                    },
                    itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("1 day"),
                      value: "1 day",
                    ),
                    PopupMenuItem(
                      child: Text("1 hour"),
                      value: "1 hour",
                    ),
                    PopupMenuItem(
                      child: Text("30 min"),
                      value: "30 min",
                    ),
                    PopupMenuItem(
                      child: Text("10 min"),
                      value: "10 min",
                    )
                  ],
                    icon: Icon(Icons.arrow_drop_down) ,
                  ),
                  border: const OutlineInputBorder(
                      borderRadius:  BorderRadius.all(Radius.circular(7))
                  ),
                ),
              ),
                Expanded(child: Container()),
              ButtonItem(title: "Create a Task",onClick: (){
                AppBloc.get(context).insertTaskData();
                Navigator.pop(context);
              }),
            ],
          ),
        ),

     );
   }

  selectTheDate(BuildContext context) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)

        selectedDate = selected;
        AppBloc.get(context).dateController.text=formatter.format(selectedDate);
  }

  selectStartTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      AppBloc.get(context).startController.text=timeOfDay.format(context);
      String x=timeOfDay.toString().replaceAll(new  RegExp('[A-Za-z()]'),'');
      AppBloc.get(context).time=x;
      print(x);
    }
  }


  selectEndTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      AppBloc.get(context).endController.text=timeOfDay.format(context);

    }
  }


}

