import Foundation

enum PriceFormatHelper {
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: CommonConstant.Identifier.localeKR)
        return formatter
    }()

    static func format(_ price: Int) -> String {
        let formatted = formatter.string(from: NSNumber(value: price)) ?? "\(price)"

        return "\(CommonConstant.Text.wonSymbol)\(formatted)"
    }
}
