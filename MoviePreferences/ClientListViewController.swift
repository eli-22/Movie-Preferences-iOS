//
//  ClientListViewController.swift
//  Elise
//
//  Created by Elise on 9/29/22.
//

import UIKit

class ClientListViewController: UIViewController {

    var clientList: [Client]!
    
    // Filter switches
    @IBOutlet weak var actionSwitch: UISwitch!
    @IBOutlet weak var comedySwitch: UISwitch!
    @IBOutlet weak var dramaSwitch: UISwitch!
    
    // Display Client List here.
    @IBOutlet weak var displayClientsLabel: UILabel!
    
    @IBOutlet weak var showFilteredListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayUsers()
        actionSwitch.isOn = false
        comedySwitch.isOn = false
        dramaSwitch.isOn = false
    }
    
    func displayUsers() {
        sortByEmail(clientList)
        displayClientsLabel.text = clientList.description
        var displayString = ""
        for client in clientList {
            displayString += "\n\(client.description)"
        }
        displayClientsLabel.text = displayString
    }
    
    @IBAction func showFilteredList(_ sender: Any) {
        var filteredClients: [Client] = []
        
        if actionSwitch.isOn {
            for client in clientList {
                if client.preferredGenres.contains(.action) {
                    filteredClients.append(client)
                }
            }
        }
            if comedySwitch.isOn {
                for client in clientList {
                    if !filteredClients.contains(client) {
                        if client.preferredGenres.contains(.comedy) {
                            filteredClients.append(client)
                        }
                    }
                }
            }
            
            if dramaSwitch.isOn {
                for client in clientList {
                    if !filteredClients.contains(client) {
                        if client.preferredGenres.contains(.drama) {
                            filteredClients.append(client)
                        }
                    }
                }
            }
        var displayString = ""
        for client in filteredClients {
            displayString += "\n\(client.description)"
        }
        displayClientsLabel.text = displayString
    }
    
    func sortByEmail (_ list: [Client]) {
        let sortedByEmail = list.sorted(by: <)
        clientList = sortedByEmail
    }
}
