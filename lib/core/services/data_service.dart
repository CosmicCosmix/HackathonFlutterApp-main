import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/scheme_model.dart';
import '../models/match_model.dart';
import '../models/business_model.dart';
import '../models/dashboard_category_model.dart';

class DataService {
  static DataService? _instance;
  
  DataService._internal();
  
  factory DataService() {
    _instance ??= DataService._internal();
    return _instance!;
  }

  /// Load schemes data for Discover screen
  Future<Map<String, List<SchemeModel>>> loadDiscoverSchemes() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/discover_schemes.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      final List<SchemeModel> carouselItems = (jsonData['carouselItems'] as List)
          .map((item) => SchemeModel.fromJson(item))
          .toList();

      final List<SchemeModel> recommendedItems =
          (jsonData['recommendedItems'] as List)
              .map((item) => SchemeModel.fromJson(item))
              .toList();

      return {
        'carousel': carouselItems,
        'recommended': recommendedItems,
      };
    } catch (e) {
      print('Error loading discover schemes: $e');
      return {'carousel': <SchemeModel>[], 'recommended': <SchemeModel>[]};
    }
  }

  /// Load matches data for Initial Results Teaser screen
  Future<List<MatchModel>> loadMatches() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/matches.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      final List<MatchModel> matches = (jsonData['matches'] as List)
          .map((item) => MatchModel.fromJson(item))
          .toList();

      return matches;
    } catch (e) {
      print('Error loading matches: $e');
      return <MatchModel>[];
    }
  }

  /// Get match by ID
  Future<MatchModel?> getMatchById(String id) async {
    final matches = await loadMatches();
    try {
      return matches.firstWhere((match) => match.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Load businesses data for Finding Businesses screen
  Future<List<BusinessModel>> loadFindingBusinesses() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/finding_businesses.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      final List<BusinessModel> businesses = (jsonData['businesses'] as List)
          .map((item) => BusinessModel.fromJson(item))
          .toList();

      return businesses;
    } catch (e) {
      print('Error loading finding businesses: $e');
      return <BusinessModel>[];
    }
  }

  /// Load dashboard categories data for Results Dashboard screen
  Future<List<DashboardCategoryModel>> loadDashboardCategories() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/results_dashboard.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      final List<DashboardCategoryModel> categories =
          (jsonData['categories'] as List)
              .map((item) => DashboardCategoryModel.fromJson(item))
              .toList();

      return categories;
    } catch (e) {
      print('Error loading dashboard categories: $e');
      return <DashboardCategoryModel>[];
    }
  }
}

