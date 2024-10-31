abstract class DetailsEvent {}

class FetchInfoByIdEvent extends DetailsEvent {
  final String id;

  FetchInfoByIdEvent(this.id);
}
