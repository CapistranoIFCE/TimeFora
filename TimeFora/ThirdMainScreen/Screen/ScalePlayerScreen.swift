import UIKit

class ScalePlayerScreen: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview()
        self.setUpContraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubview() {
        // self.addSubview(self.ScalePlayerVC)
    }

    private func setUpContraints() {
        NSLayoutConstraint.activate([

        ])
    }

}
