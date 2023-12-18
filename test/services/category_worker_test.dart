import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:money_tracker/DataCentral/financial_category_model.dart';
import 'package:money_tracker/repositories/category_repository_abstract.dart';
import 'package:money_tracker/services/category_worker.dart';

import '../mocks/category.dart';
import 'category_worker_test.mocks.dart';

@GenerateMocks([FinancialCategoryRepository, FinancialCategory])
void main() {
  late CategoryWorker _sut;
  late FinancialCategoryRepository _mockCategoryRepo;

  setUp(() {
    _mockCategoryRepo = MockFinancialCategoryRepository();
    _sut = CategoryWorker(_mockCategoryRepo);
  });

  test("create category", () async {
    String categoryName = "category1";
    int success = 1;
    when(_mockCategoryRepo.createCategory(categoryName))
        .thenAnswer((realInvocation) async => success);

    int result = await _sut.createCategory(categoryName);
    expect(result, success);
  });

  test("create category fails", () async {
    String categoryName = "category1";
    int success = -1;
    when(_mockCategoryRepo.createCategory(categoryName))
        .thenAnswer((realInvocation) async => success);

    int result = await _sut.createCategory(categoryName);
    expect(result, success);
  });

  test("update category name", () async {
    FinancialCategory mockCategory = FinancialCategory(1, "category2");
    int success = 1;
    when(_mockCategoryRepo.updateCategoryByName(
            mockCategory.tag, mockCategory.name))
        .thenAnswer((realInvocation) async => success);

    FinancialCategory result =
        await _sut.updateCategory(mockCategory.tag, mockCategory.name);
    expect(result.name, mockCategory.name);
    expect(result.tag, mockCategory.tag);
  });

  test("update category name fails", () async {
    FinancialCategory mockCategory = FinancialCategory(1, "category2");
    int success = -1;
    when(_mockCategoryRepo.updateCategoryByName(
            mockCategory.tag, mockCategory.name))
        .thenAnswer((realInvocation) async => success);

    expect(() => _sut.updateCategory(mockCategory.tag, mockCategory.name),
        throwsA(isA<Error>()));
  });

  test("remove category", () async {
    FinancialCategory mockCategory = FinancialCategory(1, "category1");
    int success = 1;
    when(_mockCategoryRepo.removeCategory(mockCategory))
    .thenAnswer((realInvocation) async => success);

    FinancialCategory result = await _sut.removeCategory(mockCategory);

    expect(result, mockCategory);
  });

  test("remove category fails", () async {
    FinancialCategory mockCategory = FinancialCategory(1, "category1");
    int success = -1;
    when(_mockCategoryRepo.removeCategory(mockCategory))
    .thenAnswer((realInvocation) async => success);

        expect(() => _sut.removeCategory(mockCategory),
        throwsA(isA<Error>()));
  });

  test("get all categories", () async {
    List<FinancialCategory> mockList = sampleCategories();
    when(_mockCategoryRepo.getAllCategories())
    .thenAnswer((realInvocation) async => mockList);

    List<FinancialCategory> result = await _sut.getAllCategories();

    expect(result, mockList);
  });
}
