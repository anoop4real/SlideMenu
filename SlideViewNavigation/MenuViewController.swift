//
//  MenuViewController.swift
//  SlideViewNavigation
//
//  Created by anoop mohanan on 05/09/17.
//  Copyright © 2017 anoop. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    weak var menuItemActionDelegate: MenuItemActionDelegate!
    var dataStore = DataStore.sharedStore()
    var testing = "Hello"
    override func viewDidLoad() {
        super.viewDidLoad()

        //let vc = MenuControllerViewFactory().viewControllerFor(menuItem: dataStore.itemAt(row: 0)!)! as! MenuViewController

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {

        return dataStore.sectionCount()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataStore.rowsCountIn(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell

        if let menuItem = dataStore.itemAt(row: indexPath.row) {
            cell.titleLbl.text = menuItem.title
            cell.menuIcon.image = UIImage(named: menuItem.imageName)
        }

     return cell
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let menuItem = dataStore.itemAt(row: indexPath.row) {
            menuItemActionDelegate?.selectedMenuWith(item: menuItem)
        }
    }

    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */

    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
