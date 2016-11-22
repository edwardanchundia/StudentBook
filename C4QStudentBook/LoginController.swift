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
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()

    lazy var pageController: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = .red
        pc.numberOfPages = self.tourData.count + 1
        return pc
    }()

    var tourData = [Tour]()
    var pageControllerBottomAnchor: NSLayoutConstraint?

    lazy var nextButton: UIButton = {
        let nb = UIButton(type: .system)
        nb.translatesAutoresizingMaskIntoConstraints = false
        nb.setTitle("Next", for: .normal)
        nb.backgroundColor = UIColor(red: 0.3725, green: 0.8784, blue: 0.0588, alpha: 1)
        nb.setTitleColor(.white, for: .normal)
        nb.layer.cornerRadius = 15
        nb.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return nb
    }()
    let skipButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.setTitle("Skip", for: .normal)
        sb.backgroundColor = .lightGray
        sb.setTitleColor(.white, for: .normal)
        sb.alpha = 0.5
        sb.layer.cornerRadius = 15
        return sb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTourData()
        setupCollectionView()
        setupPageController()
        setupNextSkipButton()
        setupKeyboardNotification()
    }

    func handleNext() {
        if pageController.currentPage == tourData.count {
            return
        }
        // 1 = 0 + 1
        let nextPage = pageController.currentPage + 1
        let nextIndexPath = IndexPath(item: nextPage, section: 0)
        collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        // current page is still 0
        // we have to add 1 to update our current page
        pageController.currentPage = nextPage
    }

    func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
    }

    lazy var yValue: CGFloat = {
        return self.view.frame.origin.y
    }()
    func keyboardShow() {
        view.frame = CGRect(x: view.frame.origin.x, y: yValue - 20, width: view.frame.size.width, height: view.frame.size.height)
    }
    func keyboardHide() {
        view.frame = CGRect(x: view.frame.origin.x, y: yValue, width: view.frame.size.width, height: view.frame.size.height)
    }


    var nextButtonBottomAnchor: NSLayoutConstraint?
    var skipButtonBottomAnchor: NSLayoutConstraint?

    func setupNextSkipButton() {
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        let buttonWidth = (view.bounds.size.width / 2) - 10

        nextButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        nextButtonBottomAnchor = nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        nextButtonBottomAnchor?.isActive = true

        skipButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        skipButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        skipButtonBottomAnchor = skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        skipButtonBottomAnchor?.isActive = true
    }


    func setupPageController() {
        view.addSubview(pageController)
        pageControllerBottomAnchor = pageController.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        pageControllerBottomAnchor?.isActive = true
        pageController.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        pageController.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
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


    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentPage = Int(targetContentOffset.pointee.x / view.frame.width)
        pageController.currentPage = currentPage
        if currentPage == tourData.count {
            // we are at the last page
            pageControllerBottomAnchor?.constant = 40
            skipButtonBottomAnchor?.constant = 90
            nextButtonBottomAnchor?.constant = 90
        } else {
            pageControllerBottomAnchor?.constant = 0
            skipButtonBottomAnchor?.constant = -40
            nextButtonBottomAnchor?.constant = -40
        }

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)

    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }

}
