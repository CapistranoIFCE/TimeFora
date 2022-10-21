import UIKit
import Lottie

protocol PlayersScreenProtocol: class {
    func didRegisterNewPlayer()
    func actionReturnButton()
    func actionLoginButton()
    func actionRegisterButton(personName: String)
}
class PlayersScreen: UIView {

    var animationView: AnimationView!

    weak var delegate: PlayersScreenProtocol?
    func delegate(delegate: PlayersScreenProtocol?) {
        self.delegate = delegate
    }

    lazy var addPhotoView: UIImageView = {
        let addPhoto = UIImageView()
        addPhoto.translatesAutoresizingMaskIntoConstraints = false
        addPhoto.image = UIImage(named: "addphoto1")
        addPhoto.contentMode = .scaleAspectFit
        return addPhoto
    }()
    lazy var nameTextField: UITextField = {
        let nametf = UITextField()
        nametf.translatesAutoresizingMaskIntoConstraints = false
        nametf.autocorrectionType = .no
        nametf.backgroundColor = .white
        nametf.borderStyle = .roundedRect
        nametf.placeholder = "Novo Jogador"
        nametf.keyboardType = .namePhonePad
        return nametf
    }()
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.tappedRegisterButton), for: .touchUpInside)
        return button
    }()
    lazy var createRacha: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar Racha", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.backgroundColor = UIColor(red: 160/255, green: 0/255, blue: 170/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.tappedPlayersButton), for: .touchUpInside)
        return button
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(
            PlayersDetailTableViewCell.self,
            forCellReuseIdentifier: PlayersDetailTableViewCell.identifier
        )
        return tableView
    }()

    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.addSubview()
        self.configButtonEnable(false)
        self.setUpContraints()
    }

    // Meu delegate está assinando dentro do meu próprio parametro
    // Quem vai assinar, é meu PlayersVC(Player View Controller)

    public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource

        fetchPeople()
    }

    func fetchPeople() {
        //        // Fetch the data from core data to display in the tableView
        do {

            delegate?.didRegisterNewPlayer()

//            self.items = try context?.fetch(Person.fetchRequest())

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print(error)
        }
    }

    private func configBackGround() {
        self.backgroundColor = UIColor(red: 24/255, green: 177/255, blue: 104/255, alpha: 1.0)
    }

    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        self.nameTextField.delegate = delegate
    }
    @objc func tappedPlayersButton(){
        self.delegate?.actionLoginButton()
    }
    @objc func tappedRegisterButton() {
        let personName = Person(context: self.context!)
        personName.name = nameTextField.text
        self.delegate?.actionRegisterButton(personName: personName.name ?? "")

        do {
            try self.context!.save()
        } catch {

        }
        self.fetchPeople()
    }

    public func validaTextField() {
        let namePlayer: String = self.nameTextField.text ?? ""
        if !namePlayer.isEmpty {
            self.configButtonEnable(true)
        } else {
            self.configButtonEnable(false)
        }
    }
    func configButtonEnable(_ enable: Bool) {
        if enable {
            self.confirmButton.setTitleColor(.white, for: .normal)
            self.confirmButton.isEnabled = true
        } else {
            self.confirmButton.setTitleColor(.lightGray, for: .normal)
            self.confirmButton.isEnabled = false
        }
    }

    func setupAnimationView() {
        animationView = .init(name: "57137-success-tick")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1.0
        addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    func addSubview() {
        self.addSubview(self.addPhotoView)
        self.addSubview(self.nameTextField)
        self.addSubview(self.confirmButton)
        self.addSubview(self.tableView)
        self.addSubview(self.createRacha)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpContraints() {
        NSLayoutConstraint.activate([

            self.addPhotoView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.addPhotoView.heightAnchor.constraint(equalToConstant: 55),
            self.addPhotoView.widthAnchor.constraint(equalTo: self.addPhotoView.heightAnchor),

            self.nameTextField.topAnchor.constraint(equalTo: self.addPhotoView.topAnchor, constant: 15),
            self.nameTextField.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -100),
            self.nameTextField.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 70),
            self.nameTextField.heightAnchor.constraint(equalToConstant: 30),

            self.confirmButton.topAnchor.constraint(equalTo: self.addPhotoView.topAnchor, constant: 15),
            self.confirmButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -10),
            self.confirmButton.leftAnchor.constraint(equalTo: self.nameTextField.rightAnchor, constant: 10),
            self.confirmButton.heightAnchor.constraint(equalToConstant: 30),

            self.tableView.topAnchor.constraint(equalTo: self.addPhotoView.bottomAnchor, constant: 10),
            self.tableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.tableView.heightAnchor.constraint(equalToConstant: 580),

            self.createRacha.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20),
            self.createRacha.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.createRacha.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.createRacha.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 5)

        ])
    }

}
