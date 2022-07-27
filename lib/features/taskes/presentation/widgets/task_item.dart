
import 'package:flutter/material.dart';
import 'package:to_do_app/core/util/blocks/app/cubit.dart';
import 'package:to_do_app/features/taskes/presentation/widgets/get_Colors.dart';

class TaskItem extends StatefulWidget {
  final Map item;
   TaskItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool? value;

  @override
  Widget build(BuildContext context) {

    if(widget.item['completed']==0){
      this.value=false;
    }
    else{
      this.value=true;
    }

    return Container(
      height: 60,
      child: Row(
        children: [
          Checkbox(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
            ),
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: this.value,
            onChanged: (value) {
              if(value==true){
                AppBloc.get(context).mangeTask(1, widget.item['id']);

              }
              else if(value==false){
                AppBloc.get(context).mangeTask(2, widget.item['id']);
              }

            },
          ),
          Text( '${widget.item['title']}',
            style: TextStyle(fontSize: 17.0),
          ), //Text
          Expanded(child: Container()),
          PopupMenuButton(
            onSelected: (int value){
             AppBloc.get(context).mangeTask(value,widget.item['id'] );
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Complete task"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("unComplete task"),
                value: 2,
              ),
              PopupMenuItem(
                child: Text("Add to favorites"),
                value: 3,
              ),
              PopupMenuItem(
                child: Text("Remove task"),
                value: 4,
              )
            ],
            icon: Icon(Icons.more_horiz) ,
          ),
          ],
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    return getColors.getColor(widget.item['color']);
  }
}