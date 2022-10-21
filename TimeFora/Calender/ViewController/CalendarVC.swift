//
//  CalenderVC.swift
//  TimeFora
//
//  Created by Davi Capistrano on 14/10/22.
//

import UIKit

class PostCell: UITableViewCell {

    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.backgroundColor = UIColor(red: 120/255, green: 26/255, blue: 208/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.tappedRegisterButton), for: .touchUpInside)
        return button
    }()

    private let customLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "placeholder"
        return label
    }()

    func configCell(with post: Post) {
        customLabel.text = post.name
    }

    @objc func tappedRegisterButton() {
        print("aqui")
    }

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //self.backgroundColor = .orange
        configContraints()
    }

    private func configContraints() {
        self.addSubview(confirmButton)
        self.addSubview(customLabel)

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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CalendarVC: UIViewController {

    var items: [Person]

    init(items: [Person]) {
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var calendar = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        self.tableView.backgroundColor = UIColor(red: 24/255, green: 177/255, blue: 104/255, alpha: 1.0)

        setUpContraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Api.makeRequest {
            self.calendar = $0
        }
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

extension CalendarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendar.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ScalePlayerVC(items: self.items), animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PostCell
        cell?.configCell(with: calendar[indexPath.row])

        return cell ?? UITableViewCell()
    }
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {

    }
}
