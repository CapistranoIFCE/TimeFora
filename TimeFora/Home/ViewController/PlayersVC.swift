import UIKit
import CoreData

class PlayersVC: UIViewController {

    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    var playersScreen: PlayersScreen?
    var items: [Person] = [] {
        didSet {
            playersScreen?.tableView.reloadData()
        }
    }

    override func loadView() {
        self.playersScreen = PlayersScreen()
        self.view = playersScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "JOGADORES"
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(
            image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapMenuButton))
        self.playersScreen?.configTableViewProtocols(delegate: self, dataSource: self)
        self.playersScreen?.configTextFieldDelegate(delegate: self)
        self.playersScreen?.delegate(delegate: self)
        do {
            self.items = try context?.fetch(Person.fetchRequest()) ?? []
        } catch {
            print(error)
        }

    }
    @objc func didTapMenuButton() {

    }
}

/* Para modo de organização do meu protocolo, vou criar um extesion
 Pois futuramente, para manuntencao, vou saber parte a parte do meu
 código, que este método é respectivo do meu protocolo.
 */

extension PlayersVC: PlayersScreenProtocol {
    func actionLoginButton() {
        let vc:CalendarVC = CalendarVC(items: self.items)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func actionReturnButton() {
        let vc:PlayersVC = PlayersVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func didRegisterNewPlayer() {
        do {
            self.items = try context?.fetch(Person.fetchRequest()) ?? []
            self.playersScreen?.setupAnimationView()
            self.playersScreen?.animationView.play(completion: {
                play in
                if play == true {
                    self.playersScreen?.animationView.removeFromSuperview()
                }
            })
        } catch {
            print(error)
        }
    }
    func actionRegisterButton(personName: String) {

    }
}
extension PlayersVC: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.playersScreen?.validaTextField()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension PlayersVC: UITableViewDelegate, UITableViewDataSource {

    /* Dois metodos (numberOfRowsInSection) e (cellForRowAt)  obrigatorios, quando estavamos fazendo config da table view
     */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlayersDetailTableViewCell? = tableView.dequeueReusableCell(
            withIdentifier: PlayersDetailTableViewCell.identifier,
            for: indexPath
        ) as? PlayersDetailTableViewCell
        cell?.setUpCell(data: self.items[indexPath.row])
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            let personToRemove = self.items[indexPath.row]
            self.context!.delete(personToRemove)
            do {
                try self.context!.save()
            } catch {

            }

            tableView.performBatchUpdates {
                items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }

        }
    }

}
