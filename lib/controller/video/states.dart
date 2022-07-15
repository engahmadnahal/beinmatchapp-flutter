abstract class VideoState{}

class InitVideoState extends VideoState{}
class LoadingVideoState extends VideoState{}
class SuccessVideoState extends VideoState{}
class ErrorVideoState extends VideoState{}
/// Send Like News StateSingleNewsState
class SendLikeMatchState extends VideoState {}
class LoadingLikeMatchState extends VideoState {}
class SuccessLikeMatchState extends VideoState {}
class ErrorLikeMatchState extends VideoState {}
/// States For Comments
class SendCommentMatchState extends VideoState {}
class LoadingCommentMatchState extends VideoState {}
class SuccessCommentMatchState extends VideoState {}
class ErrorCommentMatchState extends VideoState {}
/// States For Update Comment Match
class LoadingUpdateCommentMatchState extends VideoState {}
class SuccessUpdateCommentMatchState extends VideoState {}
class ErrorUpdateCommentMatchState extends VideoState {}
/// States For Send Comment Match
class LoadingSendCommentMatchState extends VideoState {}
class SuccessSendCommentMatchState extends VideoState {}
class ErrorSendCommentMatchState extends VideoState {}
/// States For Get All Comment Match
class LoadingGetCommentMatchState extends VideoState {}
class SuccessGetCommentMatchState extends VideoState {}
class ErrorGetCommentMatchState extends VideoState {}
/// States For Get All Comment Match
class LoadingDeleteCommentMatchState extends VideoState {}
class SuccessDeleteCommentMatchState extends VideoState {}
class ErrorDeleteCommentMatchState extends VideoState {}

