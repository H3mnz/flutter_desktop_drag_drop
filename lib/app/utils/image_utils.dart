import 'package:mime/mime.dart';

enum ImageMimeType { jpg, png, gif, other }

class ImageUtils {
  //
  static ImageMimeType checkMimeType(String path) {
    final mime = lookupMimeType(path)!;

    if (mime == 'image/gif') {
      return ImageMimeType.gif;
    }
    if (mime == 'image/png') {
      return ImageMimeType.png;
    }
    if (mime == 'image/jpeg') {
      return ImageMimeType.jpg;
    }
    return ImageMimeType.other;
  }

  static String imgeByMimeType(String path) {
    final mimeType = checkMimeType(path);
    if (mimeType == ImageMimeType.gif) {
      return 'images/gif.png';
    }
    if (mimeType == ImageMimeType.png) {
      return 'images/png.png';
    }

    return 'images/jpg.png';
  }
}
