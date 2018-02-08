//
//  MenuControllerViewFactory.swift
//  SlideViewNavigation
//
//  Created by anoop mohanan on 03/12/17.
//  Copyright © 2017 anoop. All rights reserved.
//

import Foundation
import UIKit

class MenuControllerViewFactory {

    func viewControllerFor<T: UIViewController>(menuItem: MenuItem) -> T? {

        guard let viewInfo = fetchViewControllerInfoFor(menuItem: menuItem), let storyBoardName = viewInfo["storyboard"], let viewControllerName = viewInfo["viewController"] else { return nil }

        let storyBoard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: viewControllerName)
        return vc as? T
    }

    private func fetchViewControllerInfoFor(menuItem: MenuItem) -> [String: String]? {

        // Get the path of the plist.
        if let url = Bundle.main.url(forResource: "ScreenMappings", withExtension: "plist") {
            do {
                let mappingData = try Data(contentsOf: url)
                if let mappingInfoDict = try PropertyListSerialization.propertyList(from: mappingData, options: [], format: nil) as? [String: [String: String]] {
                    return mappingInfoDict[menuItem.resourceId]
                }
            } catch let error {
                print(error.localizedDescription)
                return nil
            }
        } else {

            return nil
        }
        return nil
    }
}
