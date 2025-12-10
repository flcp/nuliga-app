import 'package:flutter/material.dart';

List<T> getDataOrEmptyList<T>(AsyncSnapshot<List<T>> snapshot) {
  if (snapshot.hasError) {
    return [];
  }

  if (snapshot.data == null) {
    return [];
  }

  if (snapshot.data!.isEmpty) {
    return [];
  }

  return snapshot.data!;
}

T getDataOrDefault<T>(AsyncSnapshot<T> snapshot, T defaultValue) {
  if (snapshot.hasError) {
    return defaultValue;
  }

  if (snapshot.data == null) {
    return defaultValue;
  }

  return snapshot.data as T;
}
