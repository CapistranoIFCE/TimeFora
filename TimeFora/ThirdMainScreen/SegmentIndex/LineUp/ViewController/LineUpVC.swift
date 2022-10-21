//
//  LineUpVC.swift
//  TimeFora
//
//  Created by Davi Capistrano on 13/10/22.
//

import UIKit

class LineUpVC: UIViewController {

    lazy var mapImageView: UIImageView = {
        let soccerfield = UIImageView()
        soccerfield.translatesAutoresizingMaskIntoConstraints = false
        soccerfield.image = UIImage(named: "campo")
        soccerfield.contentMode = .scaleAspectFit
        return soccerfield
    }()

    lazy var playerOneImageView: UIImageView = {
        let playerOne = UIImageView()
        playerOne.translatesAutoresizingMaskIntoConstraints = false
        playerOne.image = UIImage(named: "addphoto")
        playerOne.contentMode = .scaleAspectFit
        return playerOne
    }()

    lazy var playerTwoImageView: UIImageView = {
        let playerTwo = UIImageView()
        playerTwo.translatesAutoresizingMaskIntoConstraints = false
        playerTwo.image = UIImage(named: "addphoto")
        playerTwo.contentMode = .scaleAspectFit
        return playerTwo
    }()

    lazy var playerThreeImageView: UIImageView = {
        let playerThree = UIImageView()
        playerThree.translatesAutoresizingMaskIntoConstraints = false
        playerThree.image = UIImage(named: "addphoto")
        playerThree.contentMode = .scaleAspectFit
        return playerThree
    }()

    lazy var playerFourImageView: UIImageView = {
        let playerFour = UIImageView()
        playerFour.translatesAutoresizingMaskIntoConstraints = false
        playerFour.image = UIImage(named: "addphoto")
        playerFour.contentMode = .scaleAspectFit
        return playerFour
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapImageView.addSubview(playerOneImageView)
        self.mapImageView.addSubview(playerTwoImageView)
        self.mapImageView.addSubview(playerThreeImageView)
        self.mapImageView.addSubview(playerFourImageView)
        self.view.addSubview(mapImageView)
        self.view.backgroundColor = .white
        self.setUpContraints()

    }

    private func setUpContraints() {
        NSLayoutConstraint.activate([

            self.mapImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            self.mapImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            self.mapImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),

            self.playerOneImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 270),
            self.playerOneImageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            self.playerOneImageView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            self.playerOneImageView.heightAnchor.constraint(equalToConstant: 50),

            self.playerTwoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 350),
            self.playerTwoImageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            self.playerTwoImageView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            self.playerTwoImageView.heightAnchor.constraint(equalToConstant: 50),

            self.playerThreeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            self.playerThreeImageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.playerThreeImageView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -130),
            self.playerThreeImageView.heightAnchor.constraint(equalToConstant: 50),

            self.playerFourImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            self.playerFourImageView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 130),
            self.playerFourImageView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.playerFourImageView.heightAnchor.constraint(equalToConstant: 50)
            ])
        }

}
