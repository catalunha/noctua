import 'package:noctua/app/domain/models/law_model.dart';

abstract class LawUseCase {
  Future<List<LawModel>> list();
}
