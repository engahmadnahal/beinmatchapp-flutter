abstract class SearchState{}

/// Init State
class InitSearchState extends SearchState{}
class LoadingSearchState extends SearchState{}
class SuccessSearchState extends SearchState{}
class ErrorSearchState extends SearchState{}
/// Get Club
class LoadingGetClubSearchState extends SearchState{}
class SuccessGetClubSearchState extends SearchState{}
class ErrorGetClubSearchState extends SearchState{}
/// Get News
class LoadingGetNewsSearchState extends SearchState{}
class SuccessGetNewsSearchState extends SearchState{}
class ErrorGetNewsSearchState extends SearchState{}