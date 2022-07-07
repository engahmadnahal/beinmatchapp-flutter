abstract class AppState{}

class InitState extends AppState{}
class LoadingState extends AppState{}
class SuccessState extends AppState{}
class ErrorState extends AppState{}

// State For News Page
class InitNewsState extends AppState {}
class LoadingNewsState extends AppState {}
class SuccessNewsState extends AppState {}
class ErrorNewsState extends AppState {}

// State For Single Page For News
class InitSingleNewsStates extends AppState {}
// Send Like News StateSingleNewsState
class SendLikeNewsState extends AppState {}
class LoadingLikeNewsState extends AppState {}
class SuccessLikeNewsState extends AppState {}
class ErrorLikeNewsState extends AppState {}

// Get Statuses User
class GetUserLikeNewsState extends AppState {}
class LoadingGetUserLikeNewsState extends AppState {}
class SuccessGetUserLikeNewsState extends AppState {}
class ErrorGetUserLikeNewsState extends AppState {}
// States For Comments
class SendCommentNewsState extends AppState {}
class LoadingCommentNewsState extends AppState {}
class SuccessCommentNewsState extends AppState {}
class ErrorCommentNewsState extends AppState {}
// States For Drawer Bar
class LoadingMainLayoutDrawerState extends AppState {}
class SuccessMainLayoutDrawerState extends AppState {}
class ErrorMainLayoutDrawerState extends AppState {}