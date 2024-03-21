import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MomentsButton extends StatelessWidget {
  final String? icon;
  final Function()? onTap;
  final int? count;
  const MomentsButton({super.key, this.count, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onTap,
                child: Container(
                    color: Colors.transparent,
                    child: SvgPicture.asset(
                      icon!,
                      package: 'max_moments',
                      height: 25,
                      width: 25,
                    )),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${count ?? ''}',
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
