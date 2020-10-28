import 'package:flutter/material.dart';

const env = "dev";

const apiBaseUrlDev = "http://192.168.0.41:5000/api";
const apiBaseUrlProd = "ToDo";

var apiBaseUrl = env == "dev" ? apiBaseUrlDev : apiBaseUrlProd;

var secondaryColor = Color(0xFF0F4B6C);
var secondaryColorDark = Color(0xFF093348);
var secondaryColorLight = Color(0xFF3281AE);
