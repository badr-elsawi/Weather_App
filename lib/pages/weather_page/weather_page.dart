import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weathering_with_you/models/try.dart';
import 'package:weathering_with_you/pages/details_screen/details_screen.dart';
import 'package:weathering_with_you/pages/weather_page/weather_cubit/weather_cubit.dart';
import 'package:weathering_with_you/pages/weather_page/weather_cubit/weather_states.dart';
import 'package:weathering_with_you/shared/components/components.dart';
import 'package:weathering_with_you/shared/constants.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<WeatherCubit, WeatherStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = WeatherCubit.get(context);
        //List<String> date = cubit.weather!.location!.localtime!.split(' ');
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 20, vertical: height / 70),
              child: ConditionalBuilder(
                condition: cubit.weather != null,
                builder: (BuildContext context) =>
                    _weatherBuilder(context, cubit.weather!, width, height),
                fallback: (BuildContext context) => Center(
                  child: CupertinoActivityIndicator(
                    radius: 20,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _weatherBuilder(
      BuildContext context, WeatherModelTry weather, double w, double h) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
// Location layout
          _locationWeatherLayout(context, weather, w, h),
          SizedBox(height: h / 80),
// Current weather layout
          _currentWeatherLayout(context, weather, w, h),
          SizedBox(height: h / 80),
// Today weather layout
          _todayWeatherLayout(context, weather.forecast!.forecastday![0], w, h),
          SizedBox(height: h / 80),
// hours layout
          _hoursLayout(context, weather.forecast!.forecastday![0], w, h),
          SizedBox(height: h / 80),
// days layout
          _daysLayout(context, weather.forecast!, w, h),
        ],
      ),
    );
  }

//**************************************************************
//**************************************************************
// Location layout
  Widget _locationWeatherLayout(
      BuildContext context, WeatherModelTry weather, double w, double h) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${weather.location!.name}',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: h / 100),
              Text(
                '${weather.location!.region} , ${weather.location!.country}',
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: h / 100),
              Text(
                '${dateConverter(weather.location!.localtime!.split(' ').first)}',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                '${clockConverter(weather.location!.localtime!.split(' ').last)}',
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
        Image(
          width: w / 5,
          height: h / 9,
          fit: BoxFit.contain,
          image: weather.current!.isDay == 1
              ? AssetImage('assets/images/sun.png')
              : AssetImage('assets/images/moon.png'),
        ),
      ],
    );
  }

//**************************************************************
//**************************************************************
// Current weather layout
  Widget _currentWeatherLayout(
      BuildContext context, WeatherModelTry weather, double w, double h) {
    return Container(
      height: h / 4.5,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: w / 20, vertical: h / 60),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  degree(
                    text: '${weather.current!.tempC!.toInt()}',
                    style: Theme.of(context).textTheme.headline4!,
                  ),
                  Text(
                    '${weather.current!.condition!.text}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(height: h / 80),
                  Text(
                    'Feels like : ${weather.current!.feelslikeC!.toInt()}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
              Spacer(),
              Image(
                width: w / 4,
                height: h / 8,
                fit: BoxFit.contain,
                image: NetworkImage('http:${weather.current!.condition!.icon}'),
              ),
            ],
          ),
          SizedBox(height: h / 80),
          Row(
            children: [
              Icon(Icons.wb_sunny_outlined),
              SizedBox(width: w / 40),
              Text(
                'UV : ',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(width: w / 40),
              Text(
                '${weather.current!.uv!.toInt()}',
                style: Theme.of(context).textTheme.headline3,
              ),
              Spacer(),
              Icon(Icons.grain_rounded),
              SizedBox(width: w / 40),
              Text(
                'Humidity : ',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(width: w / 40),
              Text(
                '${weather.current!.humidity!.toInt()}',
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ],
      ),
    );
  }

//**************************************************************
//**************************************************************
// Today weather layout
  Widget _todayWeatherLayout(
      BuildContext context, Forecastday model, double w, double h) {
    return Container(
      height: h / 2.35,
      width: double.infinity,
      padding: EdgeInsetsDirectional.only(
          start: w / 20, end: w / 20, top: h / 100, bottom: h / 60),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Icon(Icons.wb_sunny_outlined),
                  SizedBox(height: h / 60),
                  Text(
                    '${model.day!.uv!.toInt()}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Today',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    '${dateConverter(model.date!)}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Image(
                    width: w / 4,
                    height: h / 10,
                    fit: BoxFit.contain,
                    image: NetworkImage('http:${model.day!.condition!.icon}'),
                  ),
                  Text(
                    '${model.day!.condition!.text}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.grain_rounded),
                  SizedBox(height: h / 60),
                  Text(
                    '${model.day!.avghumidity!.toInt()}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: h / 70),
          //temperature min max avg
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'max : ',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(width: w / 60),
                  degree(
                    text: '${model.day!.maxtempC!.toInt()}',
                    style: Theme.of(context).textTheme.headline3!,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'avg : ',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(width: w / 60),
                  degree(
                    text: '${model.day!.avghumidity!.toInt()}',
                    style: Theme.of(context).textTheme.headline3!,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'min : ',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(width: w / 60),
                  degree(
                    text: '${model.day!.mintempC!.toInt()}',
                    style: Theme.of(context).textTheme.headline3!,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: h / 70),
          Container(
            height: 2,
            margin: EdgeInsets.symmetric(horizontal: w / 8),
            color: Colors.grey[700],
          ),
          SizedBox(height: h / 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Sunrise',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Image(
                    color: Color(0xffFEA400),
                    width: w / 6,
                    height: h / 13,
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/sunrise.png'),
                  ),
                  Text(
                    '${model.astro!.sunrise}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Sunset',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Image(
                    color: Color(0xff0D85BA),
                    width: w / 6,
                    height: h / 13,
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/sunrise.png'),
                  ),
                  Text(
                    '${model.astro!.sunset}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

//*********************************************************
//*********************************************************
// hours layout
  Widget _hoursLayout(
      BuildContext context, Forecastday model, double w, double h) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              child: DetailsScreen(model),
              type: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 500),
            ),
          );
        },
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          alignment: Alignment.center,
          height: h / 6.2,
          width: double.infinity,
          padding: EdgeInsetsDirectional.only(
              start: w / 20, end: w / 20, top: h / 90, bottom: h / 90),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                _hourItem(context, model.hour![index], w, h),
            separatorBuilder: (context, index) => SizedBox(width: w / 15),
            itemCount: model.hour!.length,
          ),
        ),
      ),
    );
  }

  Widget _hourItem(BuildContext context, Hour hour, double w, double h) {
    return Column(
      children: [
        Text(
          '${clockConverter2(hour.time!.split(' ').last)}',
          style: Theme.of(context).textTheme.headline5,
        ),
        Image(
          width: w / 10,
          height: h / 20,
          fit: BoxFit.contain,
          image: NetworkImage('http:${hour.condition!.icon}'),
        ),
        degree(
          text: '${hour.tempC!.toInt()}',
          style: Theme.of(context).textTheme.headline3!,
        ),
        Text(
          '${hour.condition!.text}',
          style: Theme.of(context).textTheme.headline3,
        ),
      ],
    );
  }

//*********************************************************
//*********************************************************
// days layout

  Widget _daysLayout(BuildContext context, Forecast model, double w, double h) {
    return Container(
      height: h / 3.5,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => index == 0
            ? SizedBox(
                height: 0,
                width: 0,
              )
            : _dayItem(context, model.forecastday![index], w, h),
        separatorBuilder: (context, index) => SizedBox(width: w / 8),
        itemCount: model.forecastday!.length,
      ),
    );
  }

  Widget _dayItem(
      BuildContext context, Forecastday forecast, double w, double h) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              child: DetailsScreen(forecast),
              type: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 500),
            ),
          );
        },
        child: Container(
          height: h / 5,
          width: w / 2,
          padding: EdgeInsetsDirectional.only(
              start: w / 20, end: w / 20, top: h / 60, bottom: h / 60),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                '${dateConverter(forecast.date!)}',
                style: Theme.of(context).textTheme.headline5,
              ),
              Image(
                width: w / 4,
                height: h / 10,
                fit: BoxFit.contain,
                image: NetworkImage('http:${forecast.day!.condition!.icon}'),
              ),
              Text(
                '${forecast.day!.condition!.text}',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: h / 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  degree(
                    text: '${forecast.day!.maxtempC!.toInt()}',
                    style: Theme.of(context).textTheme.headline3!,
                  ),
                  degree(
                    text: '${forecast.day!.mintempC!.toInt()}',
                    style: Theme.of(context).textTheme.headline3!,
                  ),
                ],
              ),
              SizedBox(height: h / 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.wb_sunny_outlined),
                      SizedBox(width: w / 25),
                      Text(
                        '${forecast.day!.uv!.toInt()}',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.grain_rounded),
                      SizedBox(width: w / 25),
                      Text(
                        '${forecast.day!.avghumidity!.toInt()}',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
