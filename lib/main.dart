import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathering_with_you/pages/search_page/search_page.dart';
import 'package:weathering_with_you/pages/weather_page/weather_cubit/weather_cubit.dart';
import 'package:weathering_with_you/pages/weather_page/weather_page.dart';
import 'package:weathering_with_you/shared/app_cubit/app_cubit.dart';
import 'package:weathering_with_you/shared/app_cubit/app_states.dart';
import 'package:weathering_with_you/shared/constants.dart';
import 'package:weathering_with_you/shared/network/local/cash_service.dart';
import 'package:weathering_with_you/shared/network/remote/dio_service.dart';
import 'package:weathering_with_you/shared/styles/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioService.init();
  await CashService.init();
  city = CashService.getCity();
  String? c = '';
  city != null ? c = city : c = '';
  runApp(MyApp(c!));
}

class MyApp extends StatelessWidget {
  final String cc;

  const MyApp(this.cc);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
        if (cc == '')
          BlocProvider(create: (BuildContext context) => WeatherCubit()),
        if (cc != '')
          BlocProvider(create: (BuildContext context) => WeatherCubit()..getData(town: cc)),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            title: 'weather app',
            home: cc == '' ? SearchPage() : Home(),
          );
        },
      ),
    );
  }
}
