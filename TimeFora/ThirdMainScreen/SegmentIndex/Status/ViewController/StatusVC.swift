import UIKit

class StatusCell: UITableViewCell {
    var person: String? = nil {
        didSet {
            self.customLabel.text = person ?? "empty"
        }
    }

    private let customLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.value = 0
        stepper.backgroundColor = .red
        return stepper
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configHierarchy()
        setUpContraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configHierarchy() {
        self.addSubview(customLabel)
    }

    private func setUpContraints() {
        NSLayoutConstraint.activate([
            customLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            customLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])

    }
}

class StatusVC: UIViewController {

    var items: [Person]

    init(items: [Person]) {
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StatusCell.self,
                           forCellReuseIdentifier: PlayersDetailTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white

            view.addSubview(tableView)
            self.setUpContraints()
            //view.addSubview(stepper)
            //stepper.center = view.center
        }

    func setUpContraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension StatusVC: UITableViewDelegate, UITableViewDataSource {

    /* Dois metodos (numberOfRowsInSection) e (cellForRowAt)  obrigatorios, quando estavamos fazendo config da table view
     */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StatusCell? = tableView.dequeueReusableCell(
            withIdentifier: PlayersDetailTableViewCell.identifier,
            for: indexPath
        ) as? StatusCell
        cell?.person = self.items[indexPath.row].name
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
