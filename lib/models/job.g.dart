// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobAdapter extends TypeAdapter<Job> {
  @override
  final typeId = 5;

  @override
  Job read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Job(
      id: fields[0] as String?,
      customerId: fields[1] as String,
      vehicleId: fields[2] as String?,
      customerNameSnapshot: fields[7] as String,
      vehicleNameSnapshot: fields[8] as String?,
      status: fields[3] == null ? JobStatus.open : fields[3] as JobStatus,
      createdAt: fields[4] as DateTime?,
      closedAt: fields[5] as DateTime?,
      totalBill: fields[9] == null ? 0.0 : (fields[9] as num).toDouble(),
      transactions: (fields[6] as List?)?.cast<Transaction>(),
      title: fields[10] as String,
      isAdvancePayment: fields[11] == null ? false : fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Job obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.customerId)
      ..writeByte(2)
      ..write(obj.vehicleId)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.closedAt)
      ..writeByte(6)
      ..write(obj.transactions)
      ..writeByte(7)
      ..write(obj.customerNameSnapshot)
      ..writeByte(8)
      ..write(obj.vehicleNameSnapshot)
      ..writeByte(9)
      ..write(obj.totalBill)
      ..writeByte(10)
      ..write(obj.title)
      ..writeByte(11)
      ..write(obj.isAdvancePayment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class JobStatusAdapter extends TypeAdapter<JobStatus> {
  @override
  final typeId = 6;

  @override
  JobStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return JobStatus.open;
      case 1:
        return JobStatus.closed;
      case 2:
        return JobStatus.pending;
      default:
        return JobStatus.open;
    }
  }

  @override
  void write(BinaryWriter writer, JobStatus obj) {
    switch (obj) {
      case JobStatus.open:
        writer.writeByte(0);
      case JobStatus.closed:
        writer.writeByte(1);
      case JobStatus.pending:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
