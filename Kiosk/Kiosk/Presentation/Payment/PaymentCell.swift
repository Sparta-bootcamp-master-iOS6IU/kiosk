//
//  PaymentCell.swift
//  Kiosk
//
//  Created by kingj on 4/9/25.
//

import UIKit

final class PaymentCell: UICollectionViewCell, ReuseIdentifying {
    weak var delegate: PaymentCellDelegate?

    let paymentLable = UILabel().then {
        $0.text = PaymentConstant.Text.paymentLabel
        $0.font = Common.FontStyle.subTitle
        $0.textColor = .kioskWhite
    }

    let totalPriceLabel = UILabel().then {
        $0.font = Common.FontStyle.subTitle
        $0.textColor = .kioskWhite
    }

    let hStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = PaymentConstant.Config.stackViewSpacing
    }

    let deleteButton = UIButton().then {
        $0.setTitle(PaymentConstant.Text.delete, for: .normal)
        $0.setTitleColor(.kioskWhite, for: .normal)
        $0.titleLabel?.font = Common.FontStyle.buttonTitle
        $0.backgroundColor = .kioskRed
        $0.layer.cornerRadius = Common.Config.buttonCornerRadius
    }

    let payButton = UIButton().then {
        $0.setTitle(PaymentConstant.Text.pay, for: .normal)
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

    func configureTotalPrice(totalPrice: Int) {
        totalPriceLabel.text = PriceFormatHelper.format(totalPrice)
    }

    func showAlertAction() {
        deleteButton.addAction(
            makeAlertAction(
                title: Payment.DeleteAlert.alertTitle,
                message: Payment.DeleteAlert.alertMsg,
                actionTitle1: Payment.DeleteAlert.cancel,
                style1: .cancel,
                actionTitle2: Payment.DeleteAlert.deleteAll,
                style2: .destructive,
                actionHandler: { [weak self] in
                    self?.delegate?.deleteAllButtonDidTap()
                }
            ), for: .touchUpInside
        )

        payButton.addAction(
            makeAlertAction(
                title: Payment.PayAlert.alertTitle,
                message: Payment.PayAlert.alertMsg,
                actionTitle1: Payment.PayAlert.cancel,
                style1: .default,
                actionTitle2: Payment.PayAlert.deleteAll,
                style2: .default,
                actionHandler: { [weak self] in
                    self?.showPaymentCompleteAlert()
                }
            ), for: .touchUpInside
        )
    }

    func showPaymentCompleteAlert() {
        DispatchQueue.main.asyncAfter(deadline: Payment.CompleteAlert.delayTime) { [weak self] in
            let alert = UIAlertController(
                title: Payment.CompleteAlert.alertTitle,
                message: Payment.CompleteAlert.alertMsg,
                preferredStyle: .alert
            )
            let confirm = UIAlertAction(title: Payment.CompleteAlert.confirm, style: .cancel)
            alert.addAction(confirm)
            self?.delegate?.showAlert(alert: alert)
            self?.delegate?.payButtonDidTap()
        }
    }

    private func configureSubview() {
        [paymentLable, totalPriceLabel, hStackView]
            .forEach { addSubview($0) }

        [deleteButton, payButton]
            .forEach { hStackView.addArrangedSubview($0) }
    }

    private func configureAutoLayout() {
        paymentLable.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(Common.Config.defaultSpacing)
        }

        totalPriceLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Common.Config.defaultSpacing)
        }

        hStackView.snp.makeConstraints {
            $0.top.equalTo(paymentLable.snp.bottom).offset(PaymentConstant.Config.stackViewTop)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(PaymentConstant.Config.stackViewHeight)
        }
    }

    private func makeAlertAction(
        title: String,
        message: String,
        actionTitle1: String,
        style1: UIAlertAction.Style,
        actionTitle2: String? = nil,
        style2: UIAlertAction.Style? = nil,
        actionHandler: (() -> Void)? = nil
    ) -> UIAction {
        return UIAction { [weak self] _ in
            guard let self else { return }
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            let action1 = UIAlertAction(title: actionTitle1, style: style1)
            alert.addAction(action1)

            if let actionTitle2, let style2 {
                let action2 = UIAlertAction(title: actionTitle2, style: style2) { _ in
                    actionHandler?()
                }
                alert.addAction(action2)
            }
            delegate?.showAlert(alert: alert)
        }
    }
}
