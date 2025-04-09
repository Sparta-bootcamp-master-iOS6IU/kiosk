import SnapKit
import UIKit

final class SectionHeaderView: UICollectionReusableView, ReuseIdentifying {
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        titleLabel.font = Common.FontStyle.header
        titleLabel.textColor = .kioskWhite

        addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.bottom.equalToSuperview().inset(Common.Config.defaultSpacing)
        }
    }

    func update(title: String) {
        titleLabel.text = title
    }
}
