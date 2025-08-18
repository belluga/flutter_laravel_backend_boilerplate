import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:unifast_portal/infrastructure/services/courses_backend_contract.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/course/category_dto.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/course/course_item_dto.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/course/course_item_summary_dto.dart';
import 'package:unifast_portal/infrastructure/services/dal/dto/external_course_dto.dart';
import 'package:unifast_portal/infrastructure/services/dal/dao/mock_backend/mock_functions.dart';

class MockCoursesBackend extends CoursesBackendContract with MockFunctions {
  @override
  Future<List<ExternalCourseDTO>> getExternalCourses() {
    final _externalCourses =
        (_externalCoursesResponse['data'] as List<Map<String, dynamic>>)
            .map((item) => ExternalCourseDTO.fromJson(item))
            .toList();

    return Future.value(_externalCourses);
  }

  @override
  Future<List<CourseItemSummaryDTO>> getMyCourses() async {
    final _myCoursesList = await _myCourses();
    final _courses = _myCoursesList
        .map((item) => CourseItemSummaryDTO.fromJson(item))
        .toList();

    return Future.value(_courses);
  }

  @override
  Future<List<CourseItemSummaryDTO>> getUnifastTracks() async {
    final _unifastTracksList = await _unifastTracks();
    final _courses = _unifastTracksList
        .map((item) => CourseItemSummaryDTO.fromJson(item))
        .toList();

    return Future.value(_courses);
  }

  @override
  Future<List<CourseItemSummaryDTO>> getLastFastTrackCourses() async {
    final _unifastTracksList = await _unifastTracks();
    _unifastTracksList.sublist(0, 3);
    final _courses = _unifastTracksList
        .map((item) => CourseItemSummaryDTO.fromJson(item))
        .toList();

    return Future.value(_courses);
  }

  @override
  Future<CourseItemDetailsDTO> courseItemGetDetails(String courseId) async {
    await Future.delayed(Duration(seconds: 1));

    final _myCoursesList = await _courseItemListDetails();

    final _courseItemDetailsRaw =
        _myCoursesList.firstWhere((item) => item['id'] == courseId);

    final CourseItemDetailsDTO _courseItemDetails =
        CourseItemDetailsDTO.fromJson(_courseItemDetailsRaw);

    return _courseItemDetails;
  }

  @override
  Future<List<CategoryDTO>> getFastTracksCategories() {
    final _courses = _fastTracksCategories
        .map((item) => CategoryDTO.fromJson(item))
        .toList();

    return Future.value(_courses);
  }

  final List<Map<String, dynamic>> _fastTracksCategories = [
    {
      "id": "668ed5a2c589a1b2c3d4e5f3",
      "name": "Soft Skills",
      "slug": "soft-skills",
      "color_hex": "4A90E2",
    },
    {
      "id": "668ed5a2c589a1b2c3d4e5f4",
      "name": "Liderança",
      "slug": "lideranca",
      "color_hex": "#50E3C2",
    },
    {
      "id": "668ed5a2c589a1b2c3d4e5f5",
      "name": "Inteligência Emocional",
      "slug": "inteligencia-emocional",
      "color_hex": "#F5A623",
    },
    {
      "id": "668ed5a2c589a1b2c3d4e5f6",
      "name": "Experiência do Cliente",
      "slug": "experiencia-do-cliente",
      "color_hex": "#D0021B",
    },
    {
      "id": "668ed5a2c589a1b2c3d4e5f7",
      "name": "Inteligência Artificial",
      "slug": "inteligencia-artificial",
      "color_hex": "#9013FE",
    },
    {
      "id": "668ed5a2c589a1b2c3d4e5f8",
      "name": "Gestão Financeira",
      "slug": "gestao-financeira",
      "color_hex": "#4A4A4A",
    },
  ];

  Future<List<Map<String, dynamic>>> _courseItemListDetails() async {
    // if (kDebugMode) {
    final lessonsJson =
        await rootBundle.loadString('assets/mock/aulasTotal.json');
    final List<dynamic> lessonsJsonList = json.decode(lessonsJson);
    final lessons = lessonsJsonList.cast<Map<String, dynamic>>();

    final fastTrackLessonsJson = await rootBundle.loadString(
      'assets/mock/aulasFastTracks.json',
    );
    final List<dynamic> fastTrackLessonsJsonList = json.decode(
      fastTrackLessonsJson,
    );
    final fastTracklessons =
        fastTrackLessonsJsonList.cast<Map<String, dynamic>>();

    final disciplinesJson = await rootBundle.loadString(
      'assets/mock/disciplinasTotal.json',
    );
    final List<dynamic> disciplinesJsonList = json.decode(disciplinesJson);
    final disciplines = disciplinesJsonList.cast<Map<String, dynamic>>();

    final List<Map<String, dynamic>> _courseItems = [];

    _courseItems.addAll(lessons);
    _courseItems.addAll(fastTracklessons);
    _courseItems.addAll(disciplines);
    return _courseItems;
    // } else {
    //   return [];
    // }
  }

  Future<List<Map<String, dynamic>>> _unifastTracks() async {
    // if (kDebugMode) {
    final fastTracksJson =
        await rootBundle.loadString('assets/mock/fastTrack.json');
    final List<dynamic> fastTrackJsonList = json.decode(fastTracksJson);
    final fastTracks = fastTrackJsonList.cast<Map<String, dynamic>>();

    return fastTracks;
    // } else {
    //   return [];
    // }
  }

  Future<List<Map<String, dynamic>>> _myCourses() async {
    // if (kDebugMode) {
    final myCoursesJson =
        await rootBundle.loadString('assets/mock/myCourses.json');
    final List<dynamic> myCoursesJsonList = json.decode(myCoursesJson);
    final myCoursesTracks = myCoursesJsonList.cast<Map<String, dynamic>>();

    return myCoursesTracks;
    // } else {
    //   return [];
    // }
  }

  //TODO: Retrieve partner name and logo to place on the Course.
  Map<String, dynamic> get _externalCoursesResponse => {
        "total": 2,
        "data": [
          {
            "id": fakeMongoId,
            "title": "Graduação em Matemática",
            "description": "Curso de graduação em matemática.",
            "thumb": {
              "type": "image",
              "data": {"url": "https://picsum.photos/id/30/200/300"},
            },
            "platform_url": "https://example.com/course1.png",
            "initial_password": "765432e1",
          },
          {
            "id": "6864f4415a115a9591257e2d",
            "title": "Graduação em Belas Artes",
            "description": "Curso de graduação em Belas Artes.",
            "thumb": {
              "type": "image",
              "data": {"url": "https://picsum.photos/id/30/200/300"},
            },
            "platform_url": "https://example.com/course1.png",
            "initial_password": "765432e1",
          },
        ],
      };
}
