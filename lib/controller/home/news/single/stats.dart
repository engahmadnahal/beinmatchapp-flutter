abstract class SingleNewsState{}

class InitSingleNewsStates extends SingleNewsState{}

// Send Like News StateSingleNewsState
class SendLikeNewsState extends SingleNewsState {}
class LoadingLikeNewsState extends SingleNewsState {}
class SuccessLikeNewsState extends SingleNewsState {}
class ErrorLikeNewsState extends SingleNewsState {}
// Get Statuses User
class GetUserLikeNewsState extends SingleNewsState {}
class LoadingGetUserLikeNewsState extends SingleNewsState {}
class SuccessGetUserLikeNewsState extends SingleNewsState {}
class ErrorGetUserLikeNewsState extends SingleNewsState {}
/**
 * States For Comments 
 */
class SendCommentNewsState extends SingleNewsState {}
class LoadingCommentNewsState extends SingleNewsState {}
class SuccessCommentNewsState extends SingleNewsState {}
class ErrorCommentNewsState extends SingleNewsState {}
