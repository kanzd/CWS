import 'package:image_picker/image_picker.dart';
import 'dart:io';
export 'dart:io';

class Image_Service {
  String selecttype = 'gallery';
  var picker = ImagePicker();
  Image_Service({this.selecttype});
  image() async {
    var file;
    if (selecttype == 'gallery') {
      file = await picker.getImage(source: ImageSource.gallery);
    } else if (selecttype == 'camera') {
      file = await picker.getImage(source: ImageSource.camera);
    } else {
      return null;
    }
    return File(file.path);
  }

  video() async {
    print(this.selecttype);
    var file;
    if (selecttype == 'gallery') {
      file = await picker.getVideo(source: ImageSource.gallery);
    } else if (selecttype == 'camera') {
      file = await picker.getVideo(source: ImageSource.camera);
    } else {
      return null;
    }
    return File(file.path);
  }
}
