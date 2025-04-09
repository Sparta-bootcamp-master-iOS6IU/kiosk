//
//  PaymentCell.swift
//  Kiosk
//
//  Created by kingj on 4/9/25.
//

import UIKit

final class PaymentCell: UICollectionViewCell {
    
    // MARK: - Components
    
    let paymentLable = UILabel().then {
        $0.text = PaymentConstant.paymentLabel
        $0.font = Common.FontStyle.subTitle
        $0.textColor = .kioskWhite
    }

    let totalPaymentLabel = UILabel().then {
        $0.text = "₩230,000"
        $0.font = Common.FontStyle.subTitle
        $0.textColor = .kioskWhite
    }

    let hStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 20
    }

    let deleteButton = UIButton().then {
        $0.setTitle(PaymentConstant.delete, for: .normal)
        $0.setTitleColor(.kioskWhite, for: .normal)
        $0.titleLabel?.font = Common.FontStyle.buttonTitle
        $0.backgroundColor = .kioskRed
        $0.layer.cornerRadius = Common.Config.buttonCornerRadius
    }

    let payButton = UIButton().then {
        $0.setTitle(PaymentConstant.pay, for: .normal)
        $0.setTitleColor(.kioskWhite, for: .normal)
        $0.titleLabel?.font = Common.FontStyle.buttonTitle
        $0.backgroundColor = .kioskBlue
        $0.layer.cornerRadius = Common.Config.buttonCornerRadius
    }

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        configureAutoLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    
    private func configureSubview() {
        [paymentLable, totalPaymentLabel, hStackView]
            .forEach { addSubview($0) }

        [deleteButton, payButton]
            .forEach { hStackView.addArrangedSubview($0) }
    }

    private func configureAutoLayout() {
        paymentLable.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(Common.Config.defaultSpacing)
        }

        totalPaymentLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(Common.Config.defaultSpacing)
        }

        hStackView.snp.makeConstraints {
            $0.top.equalTo(paymentLable.snp.bottom).offset(25)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
