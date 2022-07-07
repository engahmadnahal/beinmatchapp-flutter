abstract class MainLayoutStates {}

class InitMainLayoutState extends MainLayoutStates {}
class LoadingMainLayoutState extends MainLayoutStates {}
class SuccessMainLayoutState extends MainLayoutStates {}
class ErrorMainLayoutState extends MainLayoutStates {}
// States For Drawer Bar
class LoadingMainLayoutDrawerState extends MainLayoutStates {}
class SuccessMainLayoutDrawerState extends MainLayoutStates {}
class ErrorMainLayoutDrawerState extends MainLayoutStates {}

// // State For News Page
// class InitNewsState extends MainLayoutStates {}
// class LoadingNewsState extends MainLayoutStates {}
// class SuccessNewsState extends MainLayoutStates {}
// class ErrorNewsState extends MainLayoutStates {}

// State For Single Page For News
class InitSingleNewsStates extends MainLayoutStates {}
// Send Like News StateSingleNewsState
class SendLikeNewsState extends MainLayoutStates {}
class LoadingLikeNewsState extends MainLayoutStates {}
class SuccessLikeNewsState extends MainLayoutStates {}
class ErrorLikeNewsState extends MainLayoutStates {}

// Get Statuses User
class GetUserLikeNewsState extends MainLayoutStates {}
class LoadingGetUserLikeNewsState extends MainLayoutStates {}
class SuccessGetUserLikeNewsState extends MainLayoutStates {}
class ErrorGetUserLikeNewsState extends MainLayoutStates {}
// States For Comments
class SendCommentNewsState extends MainLayoutStates {}
class LoadingCommentNewsState extends MainLayoutStates {}
class SuccessCommentNewsState extends MainLayoutStates {}
class ErrorCommentNewsState extends MainLayoutStates {}
