//
//  LoginController.swift
//  C4QStudentBook
//
//  Created by Jason Wang on 11/18/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.bounces = false
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    var tourData = [Tour]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTourData()
    }

    func setupTourData() {
        let tour1 = Tour(imageStr: "c4q1", titleStr: "ABOUT US", descriptionStr: "We foster the Queens tech ecosystem to increase economic opportunity and transform the world’s most diverse community into a leading hub for innovation and entrepreneurship.")
        let tour2 = Tour(imageStr: "c4q2", titleStr: "Our Mission", descriptionStr: "Coalition for Queens (C4Q) increases economic opportunity through technology and transforms the world’s most diverse community into a leading hub for innovation and entrepreneurship.")
        let tour3 = Tour(imageStr: "c4q3", titleStr: "What is Access Code?", descriptionStr: "Access Code is a 10-month software development program that trains talented adults from underserved populations to become industry ready programmers and helps get them tech jobs at leading companies.")
        tourData = [tour1, tour2, tour3]
    }

    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(TourCell.self, forCellWithReuseIdentifier: TourCell.identifier)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: LoginCell.identifier)
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tourData.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == tourData.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginCell.identifier, for: indexPath) as! LoginCell
            return loginCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TourCell.identifier
            , for: indexPath) as! TourCell
        cell.tour = tourData[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }

}













