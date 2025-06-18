import 'package:equatable/equatable.dart';

abstract class ChatsListEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class GetChatsList extends ChatsListEvents {}

class LoadMoreChatsList extends ChatsListEvents {}
