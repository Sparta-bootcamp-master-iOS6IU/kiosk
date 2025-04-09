import UIKit

final class TitlePriceStackView: UIStackView {
    private typealias CartSpacing = CartConstant.Spacing
    private typealias CartLabel = CartConstant.Label

    private let titleLabel = UILabel()
    private let originalPriceLabel = UILabel()
    private let discountedPriceLabel = UILabel()
    private let benefitOptionLabel = UILabel()
    private let discountStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        configureLabels()
        configureStackViews()
        configureSubviews()
    }

    private func configureLabels() {
        titleLabel.textColor = .kioskWhite
        titleLabel.font = Common.FontStyle.header
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = CartLabel.numberOfLines

        originalPriceLabel.textColor = .kioskGray2
        originalPriceLabel.font = Common.FontStyle.content3

        discountedPriceLabel.font = Common.FontStyle.content1

        benefitOptionLabel.textColor = .kioskGray2
        benefitOptionLabel.font = Common.FontStyle.content3
    }

    private func configureStackViews() {
        discountStackView.axis = .horizontal
        discountStackView.distribution = .equalSpacing

        axis = .vertical
    }

    private func configureSubviews() {
        [discountedPriceLabel, benefitOptionLabel]
            .forEach { discountStackView.addArrangedSubview($0) }

        [titleLabel, originalPriceLabel, discountStackView]
            .forEach { addArrangedSubview($0) }
    }

    func updateUI(
        title: String,
        originalPrice: String,
        discountedPrice: String?,
        benefitOption: BenefitOption?
    ) {
        titleLabel.text = title
        benefitOptionLabel.text = benefitOption?.rawValue

        if benefitOption == .none {
            discountedPriceLabel.text = originalPrice
            discountedPriceLabel.textColor = .kioskWhite

            spacing = CartSpacing.withoutBenefitOption

            return
        }

        originalPriceLabel.attributedText = NSAttributedString(
            string: originalPrice,
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        discountedPriceLabel.text = discountedPrice
        discountedPriceLabel.textColor = .kioskRed

        spacing = CartSpacing.withBenefitOption
    }
}
