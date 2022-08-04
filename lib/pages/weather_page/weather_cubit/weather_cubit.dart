import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathering_with_you/models/error_model.dart';
import 'package:weathering_with_you/models/try.dart';
import 'package:weathering_with_you/pages/weather_page/weather_cubit/weather_states.dart';
import 'package:weathering_with_you/shared/constants.dart';
import 'package:weathering_with_you/shared/network/remote/dio_service.dart';
import 'package:weathering_with_you/shared/network/remote/end_points.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit() : super(WeatherInitialState());

  static WeatherCubit get(context) => BlocProvider.of(context);

//***************************************************************
  List<String> towns = [
    'Cairo',
    'Fayoum',
    'Alexandria',
    'Gizeh',
    'Suez',
    'Luxor',
    'Asyut',
    'Ismailia',
    'Aswan',
    'al-Minya',
    'Damietta',
    'Beni Suef',
    'Qena',
    'Sohag',
    'Hurghada',
    '6th of October City',
    'Banha',
    'Kafr el-Sheikh',
    'Marsa Matruh',
  ];

  void selectCity(String town) {
    city = town;
    emit(SelectTownState());
  }

//get weather data
//**********************************************************
  WeatherModelTry? weather;
  ErrorModel? error;

  void getData({
    required String town,
  }) async {
    emit(GetDataLoadingState());
    DioService.getData(
      url: EndPoints.forecast,
      query: {
        'key': '9486d52002e349febb780206222207',
        'days': '3',
        'q': town,
      },
    ).then(
      (value) {
        weather = WeatherModelTry.fromJson(value.data);
        print('*****************************************');
        print('*****************************************');
        print('${weather!.location!.name}');
        print('${weather!.forecast!.forecastday![0].day!.avgtempC}');
        print('${weather!.forecast!.forecastday![0].day!.condition!.text}');
        print('*****************************************');
        print('*****************************************');
        emit(GetDataSuccessState());
      },
    ).catchError(
      (error) {
        print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
        print(error.toString());
      },
    );
  }
//*********************************************************************************
}
