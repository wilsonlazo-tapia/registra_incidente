import 'dart:convert';
import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:qrreaderapp/src/model/RegistroIncidenteModel.dart';

class RegistrarProvider {
  final String _url = 'http://smartcityhyo.tk/api/Incidente';

  Future<bool> crearProducto(RegistroIncidenteModel registrar) async {
    final url = '$_url//Insertar_Incidente.php';

    final resp = await http.post(url, body: registroIncidenteToJson(registrar));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<String> subirImage(File imagen) async {
    final url = Uri.parse('$_url/Insertar_Incidente.php');
    final mimeType = mime(imagen.path).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
        'incidente_image', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('');
      print(resp.body);
      return null;
    }
    final respData = json.decode(resp.body);
    print(respData);
    return respData['ind_Fotografia'];
  }
}
