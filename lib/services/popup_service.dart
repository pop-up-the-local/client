import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pop_up_the_local/services/image_service.dart';

Future<dynamic> createPopup() async {
  String? baseUrl = dotenv.env['BASE_URL'];

  final _imagepickerService = ImagePickerService();

  List<XFile> images = await _imagepickerService.pickImage();

  Dio dio = Dio();

  FormData _formData;

  if (images.isNotEmpty) {
    final List<MultipartFile> multipartImageList = images
        .map((XFile image) =>
            MultipartFile.fromFileSync(image.path as String)) // File
        .toList();

    dio.options.headers['content-Type'] = 'multipart/form-data';

    _formData = FormData.fromMap({
      'title': 'test',
      'description': 'test',
      'startDate': '2021-09-01',
      'endDate': '2021-09-30',
      'images': multipartImageList,
      'address': FormData.fromMap({
        'city': 'test',
        'street': "test street",
        'zipCode': "12345",
      }),
      'category': 'ART'
    });

    dio.post('$baseUrl/api/popups', data: _formData).then((response) {
      print(response);
    });
  }
}
