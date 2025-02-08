part of 'splash_bloc.dart';

abstract class SplashEvent {}

class SplashGetUserEvent extends SplashEvent {}

class SplashLoadOtherEvent extends SplashEvent {}

class SplashAuthenticatedEvent extends SplashEvent {}
