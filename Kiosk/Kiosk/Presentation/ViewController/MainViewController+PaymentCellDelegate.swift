import UIKit

extension MainViewController: PaymentCellDelegate {
    func deleteAllButtonDidTap() {
        mainViewModel.removeTicketList()
    }

    func payButtonDidTap() {
        mainViewModel.removeTicketList()
    }

    func showAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
}
