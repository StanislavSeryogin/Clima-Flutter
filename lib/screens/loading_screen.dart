import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../blocs/blocs.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GeolocationBloc, GeolocationState>(
          builder: (context, state) {
            if (state is GeolocationLoading) {
              
            } else if (state is GeolocationLoaded) {
              return Text('');
            } else {}
            return SpinKitPulse(
                color: Colors.white,
                size: 100.0,
              );
          },
        ),
      ),
    );
  }
}
