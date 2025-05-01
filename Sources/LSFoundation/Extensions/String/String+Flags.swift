public extension String {
    static func emojiFlag(countryCode: String) -> String? {
        guard countryCode.count == 2 else {
          return nil
        }
        // https://en.wikipedia.org/wiki/Regional_indicator_symbol
        let regionalIndicatorStartIndex: UInt32 = 0x1F1E6
        let alphabetOffset = UnicodeScalar(unicodeScalarLiteral: "A").value
        return String(countryCode
          .uppercased()
          .unicodeScalars
          .compactMap { UnicodeScalar(
            regionalIndicatorStartIndex + ($0.value - alphabetOffset)
          )}
          .map { Character($0) }
        )
    }
    
    static func emojiFlag(subdivision: String) -> String? {
        let blackFlag = Unicode.Scalar(0x1F3F4)!
        let cancelTag = Unicode.Scalar(0xE007F)!
        // https://en.wikipedia.org/wiki/Tags_(Unicode_block)
        let tagLetterOffset: UInt32 = 0xE0061
        let alphabetOffset = UnicodeScalar(unicodeScalarLiteral: "a").value
        let characters = subdivision
            .lowercased()
            .unicodeScalars
            .compactMap { Unicode.Scalar(tagLetterOffset + ($0.value - alphabetOffset))}
            .map { Character($0) }
        return String(Character(blackFlag)) + String(characters) + String(Character(cancelTag))
    }
}
