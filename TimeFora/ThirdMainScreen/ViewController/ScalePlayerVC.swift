import UIKit

class ScalePlayerVC: UIViewController {

    var items: [Person]

    init(items: [Person]) {
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let lineup: LineUpVC = {
        let lineup = LineUpVC()
        lineup.view.translatesAutoresizingMaskIntoConstraints = false
        return lineup
    }()

    private lazy var status: StatusVC = {
        let status = StatusVC(items: self.items)
        status.view.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()

    private let card: AllStars = {
        let stars = AllStars()
        stars.view.translatesAutoresizingMaskIntoConstraints = false
        return stars
    }()

    lazy var returnButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "return"), for: .normal)
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()

    lazy var mySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Escalação", "Status", "All Stars"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.isSelected = true
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = UIColor.orange
        segmentedControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 24/255, green: 177/255, blue: 104/255, alpha: 1.0)
        self.view.addSubview(mySegmentedControl)
//        addChild(lineup)
//        addChild(status)
//        addChild(card)
        view.addSubview(lineup.view)
        view.addSubview(status.view)
        view.addSubview(card.view)
        view.addSubview(returnButton)
        self.setUpContraints()
    }

    @objc func tappedBackButton() {
        //self.delegate?.actionReturnButton()
    }

    // Para cada segmento, pode ser uma viewcontroller
    // root fixa, muda

    @objc func segmentedValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.lineup.view.isHidden = false
            self.card.view.isHidden = true
            self.status.view.isHidden = true

        }

        if sender.selectedSegmentIndex == 1 {
            self.status.view.isHidden = false
            self.lineup.view.isHidden = true
            self.card.view.isHidden = true

        }

        if sender.selectedSegmentIndex == 2 {
            self.card.view.isHidden = false
            self.lineup.view.isHidden = true
            self.status.view.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setUpContraints() {
        NSLayoutConstraint.activate([

            self.returnButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            self.returnButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),

            self.mySegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.mySegmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            self.mySegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            self.lineup.view.topAnchor.constraint(equalTo: self.mySegmentedControl.bottomAnchor),
            self.lineup.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            self.lineup.view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.6),

            self.status.view.topAnchor.constraint(equalTo: self.mySegmentedControl.bottomAnchor),
            self.status.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            self.status.view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.6),

            self.card.view.topAnchor.constraint(equalTo: self.mySegmentedControl.bottomAnchor),
            self.card.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            self.card.view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.6)

        ])
    }

}
