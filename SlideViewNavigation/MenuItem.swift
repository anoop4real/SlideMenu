//
//  MenuItem.swift
//  SlideViewNavigation
//
//  Created by anoop mohanan on 04/09/17.
//  Copyright © 2017 anoop. All rights reserved.
//

import Foundation

struct MenuItem {

    let title: String!
    let menuId: String!
    let resourceId: String!
    let imageName: String!
    let url: String!

    init?(with dictionary: [String: Any]) {

        guard let title = dictionary["title"] as? String, let menuIdVal = dictionary["menuId"] as? String, let resourceIdVal = dictionary["resourceId"] as? String, let imageNameVal = dictionary["imageName"] as? String, let urlVal = dictionary["url"] as? String else {
            return nil
        }

        self.title = title
        self.menuId = menuIdVal
        self.resourceId = resourceIdVal
        self.imageName = imageNameVal
        self.url = urlVal

    }
}
