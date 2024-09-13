//
//  MessageTVC.swift
//  Online Exchange
//
//  Created by Kumar Chandu on 9/10/24.
//

import UIKit

class MessageTVC: UITableViewController {

    var messages = ["Welcome to Online Exchange!", "Here you can find all your messages.", "Manage your communication with ease."]
       
       override func viewDidLoad() {
           super.viewDidLoad()
           self.view.backgroundColor = UIColor.systemGray6
           
           // Set up background gradient
          // setBackground()
           
           // Register a basic UITableViewCell
           self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "messageCell")
       }
       
       // MARK: - Table view data source
       
       override func numberOfSections(in tableView: UITableView) -> Int {
           return 1 // Single section for messages
       }
       
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return messages.count // Number of messages
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
           cell.textLabel?.text = messages[indexPath.row] // Set the message text
           return cell
       }
//    private func setBackground() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.systemPurple.cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
//        gradientLayer.frame = self.view.bounds
//        self.view.layer.insertSublayer(gradientLayer, at: 0)
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            messages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        // Handle rearranging of messages if needed
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return true if rows should be reorderable
        return true
    }
    
    // MARK: - Navigation
    
    // Prepare for navigation if needed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


