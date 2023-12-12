part of 'all_reservasi_bloc.dart';

@immutable
sealed class AllReservasiState {}

final class AllReservasiInitial extends AllReservasiState {}

final class AllReservasiLoading extends AllReservasiState {}

final class AllReservasiSuccess extends AllReservasiState {
  final List<AllReservasiData> reservasi;

  AllReservasiSuccess({required this.reservasi});
}

final class AllReservasiFailed extends AllReservasiState {
  final String errorMessage;

  AllReservasiFailed({required this.errorMessage});
}
