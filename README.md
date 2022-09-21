# noctua

A new Flutter project.


# Web & Deploy

cd /home/catalunha/myapp/noctua && flutter build web && cd /home/catalunha/myapp/noctua/b4a/noctua && b4a deploy

# Campos de person

Nome
Apelido
Mãe
Data de Nascimento

Pai
Crimes Já Praticados
Observações
Fotos


# DateTime
```Dart
extension DateTimeExtension on DateTime? {
  
  bool? isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isAfter(dateTime);
    }
    return null;
  }

  bool? isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isBefore(dateTime);
    }
    return null;
  }

  bool? isBetween(
    DateTime fromDateTime,
    DateTime toDateTime,
  ) {
    final date = this;
    if (date != null) {
      final isAfter = date.isAfterOrEqualTo(fromDateTime) ?? false;
      final isBefore = date.isBeforeOrEqualTo(toDateTime) ?? false;
      return isAfter && isBefore;
    }
    return null;
  }

}
```


# mocks
https://jsonplaceholder.typicode.com/photos
https://www.mockaroo.com/


# Operações

