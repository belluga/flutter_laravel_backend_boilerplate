import 'dart:convert';
import 'package:flutter/material.dart';

abstract class AppDataLocalCacheContract {
  

  Future<String?> getCachedData();

  Future<void> save(Map<String, dynamic> data);

  Future<void> delete();

  @protected
  final String key = 'tenantBrandingData';


  Future<Map<String, dynamic>?> get() async {
    final cachedDataString = await getCachedData();
    if (cachedDataString != null) {
      try {
        return jsonDecode(cachedDataString) as Map<String, dynamic>;
      } catch (e) {
        await delete();
        return null;
      }
    }
    return null;
  }
  
}