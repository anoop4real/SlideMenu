//
//  BaseViewController.swift
//  SlideViewNavigation
//
//  Created by anoop mohanan on 06/02/18.
//  Copyright © 2018 anoop. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    weak var menuDelegate: MenuDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMenuButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configViewWith(item: MenuItem) {

        self.title = item.title
    }
    private func setUpMenuButton() {
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtn.setImage(UIImage(named: "menuIcon"), for: .normal)
        menuBtn.addTarget(self, action: #selector(BaseViewController.onMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let width = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        width?.isActive = true
        let height = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        height?.isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
    }

    @objc func onMenuButtonPressed(_ sender: UIButton) {

        menuDelegate?.openCloseMenu()
    }

}
