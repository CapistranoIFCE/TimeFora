import UIKit

class PlayersDetailTableViewCell: UITableViewCell {

    /*
     Deixar fixado em um só lugar o identificador da minha célula da tableView, ajuda na minha escala e manuntenção.
     */

    static let identifier: String = "PlayersDetailTableViewCell"

    lazy var userImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview()
        self.setUpContraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubview() {
        self.contentView.addSubview(self.userImageView)
        self.contentView.addSubview(self.nameLabel)
    }

    public func setUpCell(data: Person) {
        self.nameLabel.text = data.name
        if let image = data.image {

            // modelar persistencia para conseguir gerar UIImage para o person que está armazenado no parametro data aqui
        } else {
            self.userImageView.image = UIImage(named: "shirt")
        }
    }

    private func setUpContraints() {
        NSLayoutConstraint.activate([

            self.userImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.userImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.userImageView.heightAnchor.constraint(equalToConstant: 80),
            self.userImageView.widthAnchor.constraint(equalToConstant: 80),

            self.nameLabel.topAnchor.constraint(equalTo: self.userImageView.topAnchor),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.userImageView.leadingAnchor, constant: 115)

        ])
    }

}
