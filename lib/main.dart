import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shareed/cubit/cubit.dart';
import 'package:news_app/shareed/cubit/states.dart';
import 'package:news_app/shareed/network/local/cache_helper.dart';
import 'package:news_app/shareed/network/remote/dio_helper.dart';
import 'package:news_app/shareed/styles/themes.dart';
import 'bloc_observer.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/news_layout.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();

  //await Firebase.initializeApp();

  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');






  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        isDark: isDark,
      ));
    },
    blocObserver: MyBlocObserver(),
  );


}
class MyApp extends StatelessWidget
{

  final bool? isDark;

  MyApp({
    this.isDark,
  });


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> NewsCubit()..getBusiness(),),


      ],
      child: BlocProvider(
        create: (BuildContext context)=>AppCubit() ,
        child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state)
          {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme ,
              themeMode:AppCubit.get(context).isDark ? ThemeMode.dark :ThemeMode.light ,
              home: NewsLayout(),
            );
          },
        ),
      ),
    );
  }
}