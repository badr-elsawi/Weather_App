import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathering_with_you/models/try.dart';
import 'package:weathering_with_you/pages/weather_page/weather_cubit/weather_cubit.dart';
import 'package:weathering_with_you/pages/weather_page/weather_cubit/weather_states.dart';
import 'package:weathering_with_you/shared/components/components.dart';

class DetailsScreen extends StatelessWidget {
  final Forecastday forecast;

  const DetailsScreen(this.forecast);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<WeatherCubit, WeatherStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = WeatherCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: CircleAvatar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor == Colors.black
                    ? Colors.grey[400]
                    : Colors.grey[800],
                child: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Theme.of(context).scaffoldBackgroundColor == Colors.black
                      ? Colors.black
                      : Colors.black,
                ),
              ),
            ),
            title: Text(
              '${dateConverter(forecast.date!)}',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width / 20, vertical: height / 70),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _todayWeatherLayout(context, forecast, width, height),
                    SizedBox(height: height / 60),
                    _hoursLayout(context, forecast, width, height)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //**************************************************************
//**************************************************************
// Today weather layout
  Widget _todayWeatherLayout(
      BuildContext context, Forecastday model, double w, double h) {
    return Container(
      height: h / 2.2,
      width: double.infinity,
      padding: EdgeInsetsDirectional.only(
          start: w / 20, end: w / 20, top: h / 50, bottom: h / 60),
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
          SizedBox(height: h / 40),
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
          SizedBox(height: h / 50),
          Container(
            height: 2,
            margin: EdgeInsets.symmetric(horizontal: w / 8),
            color: Colors.grey[700],
          ),
          SizedBox(height: h / 30),
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
    return Container(
      alignment: Alignment.center,
      height: h * 2 - h / 5.5,
      width: double.infinity,
      padding: EdgeInsetsDirectional.only(
          start: w / 30, end: w / 30, top: h / 90, bottom: h / 90),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) =>
            _hourItem(context, model.hour![index], w, h),
        separatorBuilder: (context, index) => SizedBox(height: h / 40),
        itemCount: model.hour!.length,
      ),
    );
  }

  Widget _hourItem(BuildContext context, Hour hour, double w, double h) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${clockConverter2(hour.time!.split(' ').last)}',
          style: Theme.of(context).textTheme.headline5,
        ),
        degree(
          text: '${hour.tempC!.toInt()}',
          style: Theme.of(context).textTheme.headline3!,
        ),
        Image(
          width: w / 10,
          height: h / 20,
          fit: BoxFit.contain,
          image: NetworkImage('http:${hour.condition!.icon}'),
        ),
        Row(
          children: [
            Icon(Icons.grain_rounded),
            SizedBox(width: w / 25),
            Text(
              '${hour.humidity!.toInt()}',
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.wb_sunny_outlined),
            SizedBox(width: w / 25),
            Text(
              '${hour.uv!.toInt()}',
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
      ],
    );
  }
}
