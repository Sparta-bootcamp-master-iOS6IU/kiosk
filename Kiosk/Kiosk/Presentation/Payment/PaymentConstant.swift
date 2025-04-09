//
//  PaymentConstant.swift
//  Kiosk
//
//  Created by kingj on 4/9/25.
//

import Foundation

typealias Payment = PaymentConstant

enum PaymentConstant {
    enum Text {
        static let paymentLabel: String = "결제 금액"
        static let delete: String = "전체 삭제"
        static let pay: String = "결제"
    }

    enum DeleteAlert {
        static let alertTitle: String = "장바구니 전체 삭제"
        static let alertMsg: String = "장바구니의 모든 항목을 삭제합니다"
        static let cancel: String = "취소"
        static let deleteAll: String = "전체 삭제"
    }

    enum PayAlert {
        static let alertTitle: String = "결제하기"
        static let alertMsg: String = "장바구니의 모든 항목을 결제합니다"
        static let cancel: String = "취소"
        static let deleteAll: String = "결제하기"
    }

    enum Config {
        static let stackViewSpacing: CGFloat = 20
        static let stackViewTop: CGFloat = 25
        static let stackViewHeight: CGFloat = 50
    }
}
