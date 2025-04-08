import UIKit

typealias Common = CommonConstant

enum CommonConstant {
    enum Identifier {
        static let cartSection = "CartSection"
    }

    enum Text {
        static let title = "편한예매"
    }

    enum Config {
        static let defaultSpacing: CGFloat = 16
        static let verticalSpacing: CGFloat = 32
        static let buttonCornerRadius: CGFloat = 10
        static let defaultCornerRadius: CGFloat = 20
    }

    enum FontStyle {
        static let title = UIFont.systemFont(ofSize: 36, weight: .black)
        static let subTitle = UIFont.systemFont(ofSize: 26, weight: .bold)
        static let header = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let buttonTitle = UIFont.systemFont(ofSize: 22, weight: .bold)
        static let contentTitle = UIFont.systemFont(ofSize: 20, weight: .black)
        static let content1 = UIFont.systemFont(ofSize: 24, weight: .regular)
        static let content2 = UIFont.systemFont(ofSize: 20, weight: .regular)
        static let content3 = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
}
