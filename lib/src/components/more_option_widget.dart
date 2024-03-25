import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:max_moments/src/constant/image_constants.dart';
import 'package:max_moments/src/models/moment_list_result/moment.dart';

class MoreOptionWidget extends StatefulWidget {
  Moment moment;
  Function(Moment)? onTapEdit, onTapDelete;
  MoreOptionWidget(
      {super.key, required this.moment, this.onTapEdit, this.onTapDelete});

  @override
  State<MoreOptionWidget> createState() => _MoreOptionWidgetState();
}

class _MoreOptionWidgetState extends State<MoreOptionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            ListTile(
              leading: SvgPicture.asset(
                ImageConstants.edit,
                package: 'max_moments',
              ),
              title: const Text('Edit'),
              onTap: () {
                widget.onTapEdit!(widget.moment);
              },
            ),
            ListTile(
                leading: SvgPicture.asset(ImageConstants.delete,
                    color: Colors.red, package: 'max_moments'),
                title: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  widget.onTapDelete!(widget.moment);
                })
          ],
        ));
  }
}
