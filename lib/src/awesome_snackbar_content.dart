part of '../awesome_snackbar_content.dart';

class AwesomeSnackbarContent extends StatefulWidget {
  /// `IMPORTANT NOTE` for SnackBar properties before putting this in `content`
  /// backgroundColor: Colors.transparent
  /// behavior: SnackBarBehavior.floating
  /// elevation: 0.0

  /// /// `IMPORTANT NOTE` for MaterialBanner properties before putting this in `content`
  /// backgroundColor: Colors.transparent
  /// forceActionsBelow: true,
  /// elevation: 0.0
  /// [inMaterialBanner = true]
  /// height of the widget
  final double? height;

  /// width of the widget
  final double? width;

  /// title is the header String that will show on top
  final String title;

  /// message String is the body message which shows only 2 lines at max
  final String message;

  /// `optional` color of the SnackBar/MaterialBanner body
  final Color? color;

  /// contentType will reflect the overall theme of SnackBar/MaterialBanner: failure, success, help, warning
  final SnackBarContentType contentType;

  /// if you want to use this in materialBanner
  final bool inMaterialBanner;

  /// if you want to customize the font style of the title
  final TextStyle? titleTextStyle;

  /// callback when close button is pressed
  final VoidCallback? onCloseButtonPressed;

  /// if you want to customize the font style of the message
  final TextStyle? messageTextStyle;

  ///message text align
  final TextAlign? messageTextAlign;

  ///message text direction
  final TextDirection? messageTextDirection;

  /// message max lines
  final int? messageMaxLines;
  const AwesomeSnackbarContent({
    super.key,
    this.messageTextAlign,
    this.messageTextDirection,
    this.messageMaxLines,
    this.color,
    this.titleTextStyle,
    this.messageTextStyle,
    this.onCloseButtonPressed,
    required this.title,
    required this.message,
    required this.contentType,
    this.height,
    this.width,
    this.inMaterialBanner = false,
  });

  @override
  State<AwesomeSnackbarContent> createState() => _AwesomeSnackbarContentState();
}

class _AwesomeSnackbarContentState extends State<AwesomeSnackbarContent> {
  double horizontalPadding = 10, leftSpace = 10, rightSpace = 10;

  bool isTablet = false, isMobile = true;

  void _setPadding(Size size) {
    if (isMobile) {
      horizontalPadding = size.width * 0.005;
      leftSpace = size.width * 0.06;
      rightSpace = size.width * 0.05;
    } else if (isTablet) {
      leftSpace = size.width * 0.05;
      horizontalPadding = size.width * 0.2;
    } else {
      leftSpace = size.width * 0.05;
      horizontalPadding = size.width * 0.3;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == TextDirection.rtl;
    var size = MediaQuery.of(context).size;

    // screen dimensions
    isMobile = size.width <= 768;
    isTablet = size.width > 768 && size.width <= 992;

    /// for reflecting different color shades in the SnackBar
    final hsl = HSLColor.fromColor(widget.color ?? widget.contentType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));
    // double horizontalPadding = 0.0;
    // double leftSpace = size.width * 0.12;
    // double rightSpace = size.width * 0.12;

    _setPadding(size);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      padding: const EdgeInsets.all(10),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          /// background container
          Container(
            width: widget.width ?? size.width,
            height: widget.height ?? size.height * 0.125,
            decoration: BoxDecoration(
              color: widget.color ?? widget.contentType.color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          /// Splash SVG asset
          Positioned(
            bottom: 0,
            left: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
              child: SvgPicture.asset(
                AssetsPath.bubbles,
                height: size.height * 0.05,
                width: size.width * 0.05,
                package: "awesome_snackbar_content",
                colorFilter: _getColorFilter(hslDark.toColor(), ui.BlendMode.srcIn),
                // package: 'awesome_snackbar_content',
              ),
            ),
          ),

          // Bubble Icon
          Positioned(
            top: -size.height * 0.025,
            left: !isRTL ? leftSpace - 20 : null,
            right: isRTL ? rightSpace - 20 : null,
            // left: !isRTL ? leftSpace - 8 - (isMobile ? size.width * 0.075 : size.width * 0.035) : null,
            // right: isRTL ? rightSpace - 8 - (isMobile ? size.width * 0.075 : size.width * 0.035) : null,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  AssetsPath.back,
                  package: "awesome_snackbar_content",

                  height: size.height * 0.06,
                  colorFilter: _getColorFilter(hslDark.toColor(), ui.BlendMode.srcIn),
                  // package: 'awesome_snackbar_content',
                ),
                Positioned(
                  top: size.height * 0.015,
                  child: SvgPicture.asset(
                    assetSVG(widget.contentType),
                    package: "awesome_snackbar_content",

                    height: size.height * 0.022,
                    // package: 'awesome_snackbar_content',
                  ),
                )
              ],
            ),
          ),

          /// content
          Positioned.fill(
            left: isRTL ? size.width * 0.03 : leftSpace,
            right: isRTL ? rightSpace : size.width * 0.03,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// `title` parameter
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: leftSpace, vertical: 8),
                        child: CustomText(
                          widget.title,
                          textOverflow: TextOverflow.visible,
                          textStyle: widget.titleTextStyle ??
                              TextStyle(
                                fontSize: (!isMobile ? size.height * 0.03 : size.height * 0.025),
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (widget.onCloseButtonPressed != null) {
                          widget.onCloseButtonPressed!();
                          return;
                        }
                        if (widget.inMaterialBanner) {
                          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                          return;
                        }
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: size.height * 0.022,
                      ),
                    ),
                  ],
                ),

                /// `message` body text parameter
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding: EdgeInsets.symmetric(horizontal: leftSpace, vertical: 3),
                    child: CustomText(
                      widget.message,
                      textOverflow: TextOverflow.visible,
                      textAlign: widget.messageTextAlign,
                      textDirection: widget.messageTextDirection,
                      maxLines: widget.messageMaxLines,
                      textStyle: widget.messageTextStyle ??
                          TextStyle(
                            fontSize: size.height * 0.016,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Reflecting proper icon based on the contentType
  String assetSVG(SnackBarContentType contentType) {
    switch (contentType) {
      case SnackBarContentType.failure:

        /// failure will show `CROSS`
        return AssetsPath.failure;
      case SnackBarContentType.success:

        /// success will show `CHECK`
        return AssetsPath.success;
      case SnackBarContentType.warning:

        /// warning will show `EXCLAMATION`
        return AssetsPath.warning;
      case SnackBarContentType.help:

        /// help will show `QUESTION MARK`
        return AssetsPath.help;
      default:
        return AssetsPath.failure;
    }
  }

  ColorFilter? _getColorFilter(ui.Color? color, ui.BlendMode colorBlendMode) => color == null ? null : ui.ColorFilter.mode(color, colorBlendMode);
}
