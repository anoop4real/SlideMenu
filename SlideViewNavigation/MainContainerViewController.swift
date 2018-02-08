//
//  MainContainerViewController.swift
//  SlideViewNavigation
//
//  Created by anoop mohanan on 24/07/17.
//  Copyright © 2017 anoop. All rights reserved.
//

import UIKit

protocol MenuDelegate: class {
    func openCloseMenu()
}

protocol MenuItemActionDelegate: class {
    func selectedMenuWith(item: MenuItem)
}
class MainContainerViewController: UIViewController, SegueHandlerType {

    var detailedViewNavigationController: UINavigationController!
    var menuViewNavigationController: UINavigationController!

    @IBOutlet weak var menuContainerConstraint: NSLayoutConstraint!
    var isMenuOpen = false

    enum SegueIdentifier: String {
        case DetailsSegue
        case MenuSegue
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //menuContainerConstraint.constant = 240
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segueIdentifierForSegue(segue: segue) {
        case .DetailsSegue:
            self.detailedViewNavigationController = segue.destination as! UINavigationController
            guard let vc = self.detailedViewNavigationController.topViewController! as? BaseViewController else {
                showAlertWith(message: Constants.ErrorMessage.ErrorMessageLoadPage)
                return
            }
            vc.menuDelegate = self
        case .MenuSegue:
            self.menuViewNavigationController = segue.destination as! UINavigationController
            guard let vc = self.menuViewNavigationController.topViewController! as? MenuViewController else {
                showAlertWith(message: Constants.ErrorMessage.ErrorMessageLoadPage)
                return
            }
            vc.menuItemActionDelegate = self
        }
    }

    func showAlertWith(message: String) {

        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in

        }
        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)

    }

}

extension MainContainerViewController: MenuDelegate {
    func openCloseMenu() {
        if isMenuOpen {
            self.menuContainerConstraint.constant = 0
            isMenuOpen = false
        } else {
            self.menuContainerConstraint.constant = 240
            isMenuOpen = true
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in

        }

    }
}

extension MainContainerViewController: MenuItemActionDelegate {
    func selectedMenuWith(item: MenuItem) {
        self.openCloseMenu()
        switch item.resourceId {
        case Constants.ViewInfo.ViewInfoHome:
            guard let vc = MenuControllerViewFactory().viewControllerFor(menuItem: item) as? HomeViewController else {
                showAlertWith(message: Constants.ErrorMessage.ErrorMessageLoadPage)
                return
            }
            vc.menuDelegate = self
            vc.configViewWith(item: item)
            self.detailedViewNavigationController.viewControllers = [vc]
        case Constants.ViewInfo.ViewInfoProducts:
            guard let vc = MenuControllerViewFactory().viewControllerFor(menuItem: item) as? ProductViewController else {
                showAlertWith(message: Constants.ErrorMessage.ErrorMessageLoadPage)
                return
            }
            vc.menuDelegate = self
            vc.configViewWith(item: item)
            self.detailedViewNavigationController.viewControllers = [vc]
        case Constants.ViewInfo.ViewInfoWeb:
            guard let vc = MenuControllerViewFactory().viewControllerFor(menuItem: item) as? WebViewController else {
                showAlertWith(message: Constants.ErrorMessage.ErrorMessageLoadPage)
                return
            }
            vc.menuDelegate = self
            vc.setUpWebControllerWith(url: item.url)
            vc.configViewWith(item: item)
            self.detailedViewNavigationController.viewControllers = [vc]
        default:
            showAlertWith(message: Constants.ErrorMessage.ErrorMessageLoadPage)
            break
        }
    }

}
