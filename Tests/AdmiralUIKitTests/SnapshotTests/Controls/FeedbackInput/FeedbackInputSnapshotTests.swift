import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class FeedbackInputlSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Theme
    
    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()
    
    // MARK: - CustomSwitch

    func testFeedbackInputFiveState() {
        let feedbackInputControl = createFeedbackInput(cursorPosition: 0)
        checkControl(control: feedbackInputControl, named: "Zero", testName: "FeedbackInputControl")
    }
      
    func testFeedbackInputDefaultState() {
        let feedbackInputControl = createFeedbackInput(cursorPosition: 1)
        checkControl(control: feedbackInputControl, named: "One", testName: "FeedbackInputControl")
    }
    
    func testFeedbackInputOneState() {
        let feedbackInputControl = createFeedbackInput(cursorPosition: 2)
        checkControl(control: feedbackInputControl, named: "Two", testName: "FeedbackInputControl")
    }
    
    func testFeedbackInputTwoState() {
        let feedbackInputControl = createFeedbackInput(cursorPosition: 3)
        checkControl(control: feedbackInputControl, named: "Three", testName: "FeedbackInputControl")
    }
    
    func testFeedbackInputThreeState() {
        let feedbackInputControl = createFeedbackInput(cursorPosition: 4)
        checkControl(control: feedbackInputControl, named: "Four", testName: "FeedbackInputControl")
    }
    
    func testFeedbackInputFourState() {
        let feedbackInputControl = createFeedbackInput(cursorPosition: 5)
        checkControl(control: feedbackInputControl, named: "Five", testName: "FeedbackInputControl")
    }
   
    // MARK: - Private Methods
    
    private func createFeedbackInput(cursorPosition: Int) -> UIControl {
        let feedbackInputControl = FeedbackInputControl(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: 180.0, height: 32.0)))
        feedbackInputControl.cursorPosition = cursorPosition
        feedbackInputControl.apply(theme: theme)
        return feedbackInputControl
    }
    
    private func checkControl(control: UIControl, named: String, testName: String) {
        let result = verifySnapshot(
            matching: control,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}
