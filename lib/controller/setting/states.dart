abstract class SettingState{}

/// Init State
class InitSettingState extends SettingState{}
class LoadingSettingState extends SettingState{}
class SuccessSettingState extends SettingState{}
class ErrorSettingState extends SettingState{}
/// State for remove all favorite
class LoadingRemoveFavoriteSettingState extends SettingState{}
class SuccessRemoveFavoriteSettingState extends SettingState{}
class ErrorRemoveFavoriteSettingState extends SettingState{}