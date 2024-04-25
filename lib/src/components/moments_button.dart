import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:max_moments/utils/view/view_utils.dart';

class MomentsButton extends StatelessWidget {
  final String? icon;
  final Function()? onTap;
  final String? count;
  final bool? withText;
  const MomentsButton(
      {super.key, this.count, this.icon, this.onTap, this.withText = true});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Container(
                color: Colors.transparent,
                child: SvgPicture.asset(
                  icon!,
                  package: 'max_moments',
                  height: 25,
                  width: 25,
                )),
            if (withText!) sizeH(6),
            if (withText!)
              Text(
                count ?? '',
                style: const TextStyle(color: Colors.white),
              ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      onPressed: onTap,
    );
  }
}
