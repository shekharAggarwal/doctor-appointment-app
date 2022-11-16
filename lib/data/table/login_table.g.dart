// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginTableAdapter extends TypeAdapter<LoginTable> {
  @override
  final int typeId = 0;

  @override
  LoginTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginTable(
      id: fields[0] as int,
      email: fields[1] as String,
      password: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LoginTable obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
