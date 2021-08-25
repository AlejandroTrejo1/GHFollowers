//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Alejandro Trejo on 16/08/21.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: UserInfoVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissmisVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func getUserInfo() {
        NewtworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Algo salio mal", message: error.rawValue, buttonTitle: "Entendido")
                break
            }
        }
    }
    
    
    func configureUIElements(with user: User) {
        
        let followerButton = GFFollowerItemVC(user: user, delegate: self)
        
        let repoButton = GFRepoItemVC(user: user, delegate: self )
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoButton, to: self.itemViewOne)
        self.add(childVC: followerButton, to: self.itemViewTwo)
        self.dateLabel.text =  " En GitHub desde \(user.createdAt.convertToMonthYearFormat())"
    }
    
    
    func layoutUI() {
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func add(childVC: UIViewController, to containnerView: UIView) {
        addChild(childVC)
        containnerView.addSubview(childVC.view)
        childVC.view.frame = containnerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    @objc func dissmisVC() {
        dismiss(animated: true)
    }
    
}


extension UserInfoVC: GFRepoItemVCDelegate, GFFollowerItemVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Enlace Invalido", message: "El enlace de este usuario es invalida.", buttonTitle: "Entendido")
            return
        }
        presentSafariVC(with: url)
    }
    
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "Sin Seguidores", message: "Este usuario no tiene seguidores. Qué pena 😞", buttonTitle: "Qué triste")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismiss(animated: true)
    }
}




