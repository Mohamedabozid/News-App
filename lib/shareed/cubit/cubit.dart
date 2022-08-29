import 'package:bloc/bloc.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shareed/cubit/states.dart';
import 'package:sqflite/sqflite.dart';


import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() :super(AppInitialState());


  static AppCubit get(context)=> BlocProvider.of(context);
  int currentIndex = 0;



  void changeIndex(int index)
  {
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }

  Database? database;
  List<Map> tasks =[];


















  bool isDark =false;

  void changeAppMode()
  {
    isDark =!isDark;

    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
    {
      emit(AppChangeModeState());

    });
  }

}

