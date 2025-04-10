import UIKit

extension MainViewController: PaymentCellDelegate {
    func deleteAllButtonDidTap() {
        removeAllTickets()
    }

    func payButtonDidTap() {
        removeAllTickets()
    }

    func showAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }

    private func removeAllTickets() {
        mainViewModel.removeTicketList()
        reloadCartSection()
    }
}
