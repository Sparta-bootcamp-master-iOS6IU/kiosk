import SnapKit
import Then
import UIKit

class MainViewController: UIViewController {
    private let titleLabel = UILabel().then {
        $0.text = Common.Text.title
        $0.textColor = .kioskWhite
        $0.font = Common.FontStyle.title
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSubview()
        configureAutoLayout()
    }

    private func configureSubview() {
        [titleLabel]
            .forEach { view.addSubview($0) }
    }

    private func configureAutoLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Common.Config.verticalSpacing)
            $0.leading.equalToSuperview().offset(Common.Config.defaultSpacing)
        }
    }
}
