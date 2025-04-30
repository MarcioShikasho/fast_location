import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../modules/home/model/address_model.dart';

class AppStorage {
  static const String addressBoxName = 'addressBox';
  
  static Future<void> init() async {
    final appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);
    Hive.registerAdapter(AddressModelAdapter());
    await Hive.openBox<AddressModel>(addressBoxName);
  }
  
  static Box<AddressModel> getAddressBox() {
    return Hive.box<AddressModel>(addressBoxName);
  }
}