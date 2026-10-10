import 'package:flutter/widgets.dart';

/// 스크롤 위치 혹은 속도에 따른 로딩 지연 없이 이미지를 요청하고 표시합니다.
class ImmediateImage extends StatefulWidget {
  const new({
    super.key,
    required this.provider,
    required this.width,
    required this.height,
    required this.fit,
    this.builder,
  });

  final ImageProvider provider;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget Function(Widget child, bool loaded, bool synchronous)? builder;

  @override
  State<ImmediateImage> createState() => _State();
}

class _State extends State<ImmediateImage> {
  ImageStream? _stream;
  ImageInfo? _info;
  bool _synchronous = false;

  /// 이미지 수신과 로딩 오류를 처리하는 리스너.
  late final listener = ImageStreamListener(setImage, onError: onError);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resolve();
  }

  @override
  void didUpdateWidget(ImmediateImage oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 이미지 제공자 또는 크기가 변경되었는지 확인.
    final $1 = oldWidget.provider != widget.provider;
    final $2 = oldWidget.width != widget.width;
    final $3 = oldWidget.height != widget.height;

    if ($1 || $2 || $3) resolve();
  }

  /// 이미지를 요청하고, 스트림이 변경되면 리스너를 교체합니다.
  void resolve() {
    final stream = widget.provider.resolve(
      createLocalImageConfiguration(context, size: .new(widget.width, widget.height)),
    );

    if (_stream?.key == stream.key) return;

    _stream?.removeListener(listener);
    _info?.dispose();
    _info = null;
    _synchronous = false;
    _stream = stream;
    stream.addListener(listener);
  }

  /// 이미지 로딩 오류가 발생하면 호출되며 이를 플러터 오류로 전달합니다.
  static void onError(Object error, StackTrace? stack) {
    return FlutterError.reportError(
      .new(
        exception: error,
        stack: stack,
        library: 'gds_flutter',
      ),
    );
  }

  /// 이전 이미지 정보를 해제하고, 수신한 이미지와 동기 로딩 여부를 반영합니다.
  void setImage(ImageInfo info, bool synchronous) {
    setState(() {
      _info?.dispose();
      _info = info;
      _synchronous = _synchronous || synchronous;
    });
  }

  @override
  void dispose() {
    _stream?.removeListener(listener);
    _info?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = Semantics(
      image: true,
      child: RawImage(
        image: _info?.image,
        scale: _info?.scale ?? 1,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      ),
    );

    return widget.builder?.call(child, _info != null, _synchronous) ?? child;
  }
}
