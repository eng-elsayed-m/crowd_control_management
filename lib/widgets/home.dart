import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
            minRadius: 130,
            backgroundColor: Colors.red[900],
            child: Column(
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.amber,
                  size: 50,
                ),
                Text(
                  " انت غير مصرح لك بالتجوال",
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  " عليك بطلب تصريح",
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Card(
              elevation: 8,
              color: Colors.cyan[100],
              child: ListTile(
                leading: ElevatedButton(
                    onPressed: () {}, child: Text("عرض النتائج")),
                title: Text("عنوان المنزل"),
                trailing: Icon(Icons.home),
                minLeadingWidth: 180,
              )),
        ),
      ],
    );
  }
}
