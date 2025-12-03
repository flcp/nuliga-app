import 'package:flutter/material.dart';

List<T> getDataOrEmptyList<T>(AsyncSnapshot<List<T> > snapshot,
) {
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