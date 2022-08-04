import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weathering_with_you/pages/weather_page/weather_cubit/weather_cubit.dart';
import 'package:weathering_with_you/pages/weather_page/weather_cubit/weather_states.dart';
import 'package:weathering_with_you/pages/weather_page/weather_page.dart';
import 'package:weathering_with_you/shared/constants.dart';
import 'package:weathering_with_you/shared/network/local/cash_service.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherStates>(
      listener: (context, state) {
        if (state is GetDataSuccessState) {
          String? cc = '';
          city == null ? cc = '' : cc = city;
          CashService.saveCity(city: cc!);
          Navigator.pushReplacement(
            context,
            PageTransition(
              duration: Duration(milliseconds: 500),
              child: Home(),
              type: PageTransitionType.leftToRight,
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = WeatherCubit.get(context);
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return Scaffold(
          //extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              'Where are you ?',
              style: Theme.of(context).textTheme.headline5,
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: width / 10,
                vertical: height / 10,
              ),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  cubit.selectCity(cubit.towns[index]);
                  print(city);
                },
                child: AnimatedContainer(
                  height: height / 15,
                  width: double.infinity,
                  duration: Duration(milliseconds: 500),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: width / 20,
                    vertical: height / 100,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      width: 3,
                      color: cubit.towns[index] == city
                          ? Theme.of(context).accentColor
                          : Colors.transparent,
                    ),
                  ),
                  child: Text(
                    '${cubit.towns[index]}',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline3!.color,
                      fontSize: 20,
                      fontWeight:
                          Theme.of(context).textTheme.headline3!.fontWeight,
                      fontFamily:
                          Theme.of(context).textTheme.headline3!.fontFamily,
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: height / 50),
              itemCount: cubit.towns.length,
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if(city != null){
                String? c = '';
                c = city;
                cubit.getData(town: c!);
              }
            },
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor:
                Theme.of(context).scaffoldBackgroundColor == Colors.black
                    ? Colors.white
                    : Colors.black,
            icon: Icon(
              Icons.arrow_forward_ios,
              //color: Theme.of(context).backgroundColor,
            ),
            label: Text(
              'get',
              style: TextStyle(
                //color: Theme.of(context).backgroundColor,
                fontSize: 20,
                fontFamily: 'Montserrat-Bold',
                fontWeight: FontWeight.w600,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: Theme.of(context).accentColor,
                width: 2,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
        );
      },
    );
  }
}
