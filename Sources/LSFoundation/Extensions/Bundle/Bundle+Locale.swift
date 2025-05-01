public extension Bundle {
    /// Check that Russian language is selected by system
    var isRussian: Bool {
        guard let selectedLocalization = preferredLocalizations.first else {
            return false
        }
        return selectedLocalization == "ru"
    }
}
