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

    enum Alert {
        static let title = "알림"
        static let increaseMessage = "최대 10장까지만 선택할 수 있어요!"
        static let decreaseMessage = "티켓을 삭제하시겠습니까?"
        static let confirm = "확인"
        static let remove = "티켓 삭제"
        static let cancel = "취소"
    }
}
