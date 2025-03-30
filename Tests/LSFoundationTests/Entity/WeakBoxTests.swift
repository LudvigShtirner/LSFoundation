// SPM
import LSFoundation
// Apple
import XCTest

final class WeakBoxTests: XCTestCase {
    func test_weakBox_storesValue() {
        // Given
        let object = NSObject()
        // When
        let box = WeakBox(object)
        // Then
        XCTAssertEqual(box.unbox, object)
    }
    
    func test_weakBox_releasesValue() {
        // Given
        var object: NSObject? = NSObject()
        // When
        let box = WeakBox(object!)
        object = nil
        // Then
        XCTAssertEqual(box.unbox, nil)
    }
}
