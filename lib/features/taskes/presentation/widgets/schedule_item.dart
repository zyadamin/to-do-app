
import 'package:flutter/material.dart';
import 'package:to_do_app/features/taskes/presentation/widgets/get_Colors.dart';

class ScheduleItem extends StatelessWidget {
  final Map item;

  const ScheduleItem({Key? key,
    required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: getColors.getColor(item['color']),
            ),
            height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(this.item['starttime'],
                  style: TextStyle(fontSize: 20,color: Colors.white,
                      fontWeight: FontWeight.bold),),
                  Text(this.item['title'], style: TextStyle(fontSize: 20,color: Colors.white,))
                ],
              ),
            ),
           this.item['completed']==1 ?  Icon(Icons.check_circle_outline) :Icon(Icons.circle_outlined)
          ],
        ),

      ),
    );
  }
}
