import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:max_moments/max_moments.dart';
import 'package:max_moments/utils/view/view_utils.dart';

class CommentBox extends StatefulWidget {
  String? avatar;
  String? replyTo;
  bool isReply;
  Function(String)? onTapComment, onTapReply;
  Function()? onTapCloseReply;
  CommentBox({
    this.isReply = false,
    this.replyTo,
    this.avatar,
    this.onTapCloseReply,
    this.onTapComment,
    this.onTapReply,
    super.key,
  });

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  var controller = TextEditingController();
  bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isReply)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade600,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Balas ke ${widget.replyTo}',
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                  onTap: widget.onTapCloseReply,
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        else
          Divider(
            color: Colors.grey.shade200,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              netWorkImage(widget.avatar ?? '',
                  isCircle: true, height: 40, width: 40),
              sizeW(10),
              Flexible(
                child: TextField(
                  autofocus: false,
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  onChanged: (v) {
                    isEmpty = v.isEmpty;
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: ('Masukan komentarmu ...'),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      // fontSize: Dimens.size12,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (widget.isReply!) {
                    widget.onTapReply!(controller.text);
                  } else {
                    widget.onTapComment!(controller.text);
                  }
                  controller.clear();
                  setState(() {});
                },
                child: SvgPicture.asset(
                  isEmpty
                      ? ImageConstants.sendchatInactive
                      : ImageConstants.sendchat,
                  package: 'max_moments',
                  height: 35,
                  width: 35,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CommentBoxData {
  bool? isReply;
  String? targetId, replyTo;
  int? indexComment;
  CommentBoxData(
      {this.isReply = false, this.targetId, this.replyTo, this.indexComment});
}
