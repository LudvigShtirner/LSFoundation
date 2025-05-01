/**
 Protocol of localization resource
 
 Provide common implementation of localization
 >Warning:
 Must inherits from parent class because program searchs current Bundle for automatic linking .strings file
 */
public protocol LocalizationResource: AnyObject {
    /// Search phrase by key and translate to current locale
    ///
    /// if translation for key not found in current  ".strings" localization file , then searching will continue in common ".strings" localization file
    /// - Important: Common implementation provided by extension. Don't define method with same name until another behavior is expected
    /// - Parameter key: localization key
    /// - Returns: Translated value or key, if value doesn't found
    static func localize(for key: String) -> String
    
    /// Bundle and specific localization filename
    ///
    /// Filename and Bundle expected for searching process
    /// - Important: Common implementation provided by extension when localization filename is identical for classname extended by protocol
    static var specificTable: (bundle: Bundle, tableName: String) { get }
    
    /// Bundle and name of .strings file with common localization
    ///
    /// The file name with common localization keys, like "Ok", "Cancel", etc
    /// - Important: Example of usage.
    /// Create extension file in your project
    /// ```
    /// extension LocalizationResource {
    ///     var commonTable: (bundle: Bundle, tableName: String) {
    ///         return (Bundle.main, "Localizable")
    ///     }
    /// }
    /// ```
    /// where **"Localizable"** is your common localization file name
    static var commonTable: (bundle: Bundle, tableName: String) { get }
}

public extension LocalizationResource {
    static func localize(for key: String) -> String {
        let result = specificTable.bundle.localizedString(forKey: key,
                                                          value: nil,
                                                          table: specificTable.tableName)
        if result != key {
            return result
        }
        return commonTable.bundle.localizedString(forKey: key,
                                                  value: nil,
                                                  table: commonTable.tableName)
    }
    
    static var specificTable: (bundle: Bundle, tableName: String) {
        (Bundle(for: Self.self), String(describing: Self.self))
    }
}
