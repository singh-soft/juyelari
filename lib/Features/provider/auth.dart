import 'package:get_storage/get_storage.dart';

var box=GetStorage();

token(){
    return box.read('access_token')?? '';
  }
  