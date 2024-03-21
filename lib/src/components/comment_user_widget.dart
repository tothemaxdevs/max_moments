import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:max_moments/max_moments.dart';
import 'package:max_moments/utils/view/view_utils.dart';

class UserCommentWidget extends StatelessWidget {
  Widget? replySection;
  String name, avatar, comment, passedTime;
  bool withLike, isMerchant, loadingReply;
  int? replyCount;
  Function()? onTapReply, onTapViewReply;
  UserCommentWidget({
    this.replySection,
    required this.avatar,
    required this.comment,
    required this.name,
    required this.passedTime,
    this.withLike = false,
    this.isMerchant = false,
    this.replyCount = 0,
    this.onTapReply,
    this.onTapViewReply,
    this.loadingReply = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          netWorkImage(avatar, isCircle: true, height: 40, width: 40),
          sizeW(10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(name),
                              if (isMerchant) sizeW(4),
                              if (isMerchant)
                                SvgPicture.asset(
                                  ImageConstants.isMerchant,
                                  package: 'max_moments',
                                  width: 20,
                                  height: 20,
                                ),
                              sizeW(10),
                              Text(passedTime,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12)),
                            ],
                          ),
                          sizeH(8),
                          coloredText(comment),
                          sizeH(8),
                          GestureDetector(
                            onTap: onTapReply,
                            child: const Text(
                              'Reply',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (withLike) sizeW(16),
                    if (withLike)
                      SvgPicture.asset(
                        ImageConstants.like,
                        package: 'max_moments',
                        width: 18,
                        height: 18,
                      ),
                  ],
                ),
                replySection ?? const SizedBox(),
                if (replyCount! > 0)
                  TextButton(
                      onPressed: onTapViewReply,
                      child: Text(
                        'Lihat $replyCount balasan lainnya',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.black),
                      ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
