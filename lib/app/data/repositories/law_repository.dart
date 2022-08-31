import 'package:noctua/app/domain/models/law_model.dart';

abstract class LawRepository {
  Future<List<LawModel>> list();
}
