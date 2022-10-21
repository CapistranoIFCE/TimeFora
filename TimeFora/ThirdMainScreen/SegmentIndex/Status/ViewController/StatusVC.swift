import UIKit

class StatusCell: UITableViewCell {

    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.backgroundColor = UIColor(red: 120/255, green: 26/255, blue: 208/255, alpha: 1.0)
        return button
    }()

    private let customLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "placeholder"
        return label
    }()

    let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.value = 0
        stepper.backgroundColor = .black
        return stepper
    }()

    private func configContraints() {
        self.addSubview(confirmButton)
        self.addSubview(customLabel)
        self.addSubview(stepper)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configContraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

private func setUpContraints() {
        NSLayoutConstraint.activate([

            self.customLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            self.customLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -70),
            self.customLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.customLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),

            self.confirmButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            self.confirmButton.leadingAnchor.constraint(equalTo: customLabel.trailingAnchor, constant: 10),
            self.confirmButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10)

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
}
