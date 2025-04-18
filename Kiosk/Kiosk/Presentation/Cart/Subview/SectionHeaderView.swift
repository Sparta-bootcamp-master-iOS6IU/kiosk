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
            $0.edges.equalToSuperview()
        }
    }

    func updateTitle(totalCount: Int) {
        titleLabel.text = String(format: CartConstant.Header.totalCountFormat, totalCount)
    }
}
