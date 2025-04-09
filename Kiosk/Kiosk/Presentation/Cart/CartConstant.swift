import Foundation

enum CartConstant {
    enum View {
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 20
    }

    enum Spacing {
        static let withBenefitOption: CGFloat = 0
        static let withoutBenefitOption: CGFloat = 4
    }

    enum Label {
        static let numberOfLines = 2
    }

    enum Button {
        static let buttonWidth = 60
        static let symbolSize: CGFloat = 30
        static let plus = "plus"
        static let minus = "minus"
        static let positiveDelta = +1
        static let negativeDelta = -1
    }

    enum Layer {
        static let lineDashPattern: [NSNumber] = [2, 2]
    }

    enum Constraints {
        static let inset = 16
        static let offset = 16
    }
}
