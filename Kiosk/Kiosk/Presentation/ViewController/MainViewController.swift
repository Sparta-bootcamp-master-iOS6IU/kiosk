
import SnapKit
import Then
import UIKit

class MainViewController: UIViewController {
    // MARK: - Properties

    weak var delegate: PaymentDelegate?
    private let paymentCell = PaymentCell()
    private let paymentViewModel = MainViewModel()

    // MARK: - Components

    private let titleLabel = UILabel().then {
        $0.text = Common.Text.title
        $0.textColor = .kioskWhite
        $0.font = Common.FontStyle.title
    }

    private let segmentedControl = SortSegControl(items: [
        Sort.Option.papularity,
        Sort.Option.releaseDate,
        Sort.Option.title,
    ])

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubview()
        configureAutoLayout()
        showAlert()
        showPaymentCompleteAlert()
    }

    // MARK: - Methods
    
    private func showPaymentCompleteAlert() {
        paymentViewModel.showPaymentCompleteAlert = { [weak self] in
            guard let self else { return }
            let alert = UIAlertController(
                title: Payment.CompleteAlert.alertTitle,
                message: Payment.CompleteAlert.alertMsg,
                preferredStyle: .alert
            )
            let confirm = UIAlertAction(title: Payment.CompleteAlert.confirm, style: .cancel)
            alert.addAction(confirm)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func showAlert() {
        delegate = paymentViewModel
        paymentCell.deleteButton.addAction(
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
        
        paymentCell.payButton.addAction(
            makeAlertAction(
                title: Payment.PayAlert.alertTitle,
                message: Payment.PayAlert.alertMsg,
                actionTitle1: Payment.PayAlert.cancel,
                style1: .default,
                actionTitle2: Payment.PayAlert.deleteAll,
                style2: .default,
                actionHandler: { [weak self] in
                    self?.delegate?.payButtonDidTap()
                }
            ), for: .touchUpInside
        )
    }

    private func configureSubview() {
        [titleLabel, segmentedControl]
            .forEach { view.addSubview($0) }
    }

    private func configureAutoLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Common.Config.verticalSpacing)
            $0.leading.equalToSuperview().offset(Common.Config.defaultSpacing)
        }

        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Common.Config.defaultSpacing)
            $0.leading.equalToSuperview().offset(Common.Config.defaultSpacing)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Sort.Config.height)
        }
    }
}

extension MainViewController {
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
            self.present(alert, animated: true, completion: nil)
        }
    }
}
