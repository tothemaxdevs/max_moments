import 'package:flutter/material.dart';

enum PageMode { loading, loaded, error, empty, failed, notFound }

class MyPageView extends StatefulWidget {
  PageMode mode;
  Widget? view;
  Widget? customLoading, customError, customEmpty, customFailed, customNotfound;
  MyPageView(
      {Key? key,
      this.view,
      this.mode = PageMode.loading,
      this.customEmpty,
      this.customError,
      this.customFailed,
      this.customLoading,
      this.customNotfound})
      : super(key: key);

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildView(widget.mode);
  }

  Widget _buildView(PageMode view) {
    switch (view) {
      case PageMode.loading:
        return widget.customLoading ??
            const Center(child: CircularProgressIndicator());
      case PageMode.loaded:
        return widget.view ?? const Center(child: CircularProgressIndicator());
      case PageMode.error:
        return widget.customError ?? text('Gagal memuat');
      case PageMode.empty:
        return widget.customEmpty ?? text('Kosong');
      case PageMode.failed:
        return widget.customFailed ?? text('Gagal memuat');
      case PageMode.notFound:
        return widget.customNotfound ?? text('Tidak ditemukan');
      default:
        return Container();
    }
  }

  Widget text(String v) {
    return Center(
        child: Text(
      v,
      style:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade800),
    ));
  }
}
