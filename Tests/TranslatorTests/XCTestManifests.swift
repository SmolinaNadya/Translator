import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TestArgumentParser.allTests),
        testCase(TestUpdate.allTests),
        testCase(TestDelete.allTests),
        testCase(TestSearch.allTests),
    ]
}
#endif
