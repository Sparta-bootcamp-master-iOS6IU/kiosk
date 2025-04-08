import SnapKit
import UIKit

final class CartCell: UIView {
    private typealias CartView = CartConstant.View
    private typealias CartSpacing = CartConstant.Spacing
    private typealias CartLabel = CartConstant.Label
    private typealias CartButton = CartConstant.Button
    private typealias CartConstraints = CartConstant.Constraints

    private let countLabel = UILabel()
    private let titlePriceStackView = TitlePriceStackView()
    private let dashedLineView = DashedLineView()
    private let countButtonStackView = CountButtonStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        layer.borderColor = UIColor.kioskGray2.cgColor
        layer.borderWidth = CartView.borderWidth
        layer.cornerRadius = CartView.cornerRadius
        layer.masksToBounds = true

        countLabel.textColor = .kioskWhite
        countLabel.font = Common.FontStyle.header
        countLabel.setContentHuggingPriority(.required, for: .horizontal)
        countLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        [titlePriceStackView, dashedLineView, countLabel, countButtonStackView]
            .forEach { addSubview($0) }

        titlePriceStackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(CartConstraints.inset)
            $0.leading.equalToSuperview().inset(CartConstraints.inset)
        }

        dashedLineView.snp.makeConstraints {
            $0.width.equalTo(CartView.borderWidth)
            $0.verticalEdges.equalToSuperview().inset(CartConstraints.inset)
            $0.leading.equalTo(titlePriceStackView.snp.trailing).offset(CartConstraints.offset)
        }

        countLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(CartConstraints.inset)
            $0.leading.equalTo(dashedLineView.snp.trailing).offset(CartConstraints.offset)
        }

        countButtonStackView.snp.makeConstraints {
            $0.width.equalTo(CartButton.buttonWidth)
            $0.verticalEdges.trailing.equalToSuperview()
            $0.leading.equalTo(countLabel.snp.trailing).offset(CartConstraints.offset)
        }
    }

    func updateCell(
        title: String,
        originalPrice: String,
        discountedPrice: String?,
        benefitOption: String?,
        count: String
    ) {
        titlePriceStackView.updateUI(
            title: title,
            originalPrice: originalPrice,
            discountedPrice: discountedPrice,
            benefitOption: benefitOption
        )

        countLabel.text = count
    }
}
