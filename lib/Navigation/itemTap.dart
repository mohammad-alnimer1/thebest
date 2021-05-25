import 'package:flutter/material.dart';
import 'package:thebest/AppHelper/AppColors.dart';

class TabItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final Function onTap;

  const TabItem({Key key, this.text, this.icon, this.isSelected, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: isSelected ? Colors.white : AppColors.blackColor.withOpacity(.6),size: 25,),
            Text(text, style: TextStyle(
                color: isSelected ? Colors.white : AppColors.blackColor.withOpacity(.6),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 18
            ),)
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}