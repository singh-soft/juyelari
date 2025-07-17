import 'package:get_storage/get_storage.dart';

var box=GetStorage();

token(){
    return box.read('access_token')?? '';
  }

  deviceToken(){
    return box.read('device_token') ?? '';
  }

  deviceName(){
    return box.read('platform_type') ?? '';
  }

  userId(){
    return box.read('id') ?? '';
  }
  