import 'package:beinmatch/main/States.dart';
import 'package:bloc/bloc.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit() : super(InitState());
}