//
//  ViewController.swift
//  Elise
//
//  Created by Elise on 9/29/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // Input Text Fields
    @IBOutlet weak var clientNumberTextField: UITextField!
    @IBOutlet weak var clientEmailTextField: UITextField!
    
    // Client preference switches
    @IBOutlet weak var setActionSwitch: UISwitch!
    @IBOutlet weak var setComedySwitch: UISwitch!
    @IBOutlet weak var setDramaSwitch: UISwitch!
    
    // CRUD buttons
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
    // Show Client List
    @IBOutlet weak var showClientsButton: UIButton!
    
    var clientArray = [Client]()
    
    func initializeClientArray(){
        let elise = Client(
            clientNumber: 1,
            clientEmail: "elise@gmail.com",
            preferredGenres: [.comedy, .drama])
        clientArray = [elise]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeClientArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetUI()
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    }
    
    @IBAction func clearTextFields(_ sender: UIButton) {
        clientNumberTextField.text = ""
        clientEmailTextField.text = ""
    }
    
    func resetUI() {
        clientNumberTextField.text = ""
        clientEmailTextField.text = ""
        setActionSwitch.isOn = false
        setComedySwitch.isOn = false
        setDramaSwitch.isOn = false
    }
    
    @IBAction func createClient(_ sender: UIButton) {
        var newClientGenres: [Genre] = []
        guard let newClientNumber = Int(clientNumberTextField.text!), let newClientEmail = clientEmailTextField.text else {
            return
        }
        if setActionSwitch.isOn {
            newClientGenres.append(.action)
        }
        if setComedySwitch.isOn {
            newClientGenres.append(.comedy)
        }
        if setDramaSwitch.isOn {
            newClientGenres.append(.drama)
        }
        
        let newClient = Client(clientNumber: newClientNumber, clientEmail: newClientEmail, preferredGenres: newClientGenres)
        
        addClient(to: clientArray, client: newClient)
        let alert = UIAlertController (
            title: "Success!",
            message: "Client has been added to the list.",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addClient (to clientList: [Client], client: Client) {
        var clientList = clientList
        if !isDuplicateClient(client) {
            clientList.append(client)
            clientArray = clientList
        }
    }
    
    func isDuplicateClient (_ newClient: Client) -> Bool {
        for i in 0..<clientArray.count {
            if clientArray[i].clientNumber == newClient.clientNumber {
                let alert = UIAlertController (
                    title: "Duplicate Client Number",
                    message: "Client number already exists.",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(alert, animated: true, completion: nil)
                return true
            } else if clientArray[i].clientEmail == newClient.clientEmail {
                let alert = UIAlertController (
                    title: "Duplicate Client Email",
                    message: "Client email already exists.",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(alert, animated: true, completion: nil)
                return true
            }
        }
        return false
    }
    
    @IBAction func deleteClient(_ sender: UIButton) {
        guard let clientNumberToDelete = Int(clientNumberTextField.text!) else {
            return
        }
        deleteByClientNumber(from: clientArray, clientNumber: clientNumberToDelete)
    }
    
    func deleteByClientNumber (from clientList: [Client], clientNumber: Int) {
        var clientList = clientList
        for i in 0..<clientList.count {
            if clientList[i].clientNumber == clientNumber {
                let alert = UIAlertController (
                    title: "Client Removed",
                    message: "The client has been deleted.",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(alert, animated: true, completion: nil)
                
                clientList.remove(at: i)
                break
            }
        }
        clientArray = clientList
    }
    
    
    @IBAction func updateClientInfo(_ sender: UIButton) {
        guard let clientNumberToUpdate = Int(clientNumberTextField.text!),
              let updatedEmail = clientEmailTextField.text
        else {
            return
        }
        updateEmailByClientNumber(find: clientNumberToUpdate, in: clientArray, newEmail: updatedEmail)
    }
    
    func updateEmailByClientNumber(find clientNumber: Int, in clientList: [Client], newEmail: String) {
        var clientList = clientList
        for i in 0..<clientList.count {
            if clientList[i].clientNumber == clientNumber {
                clientList[i].clientEmail = newEmail
                let alert = UIAlertController (
                    title: "Success!",
                    message: "The email address has been updated successfully.",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
        clientArray = clientList
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToClientList" {
            let clientListVC = segue.destination as! ClientListViewController
            clientListVC.clientList = clientArray
        }
    }
    
    @IBAction func segueToClientList(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToClientList", sender: nil)
    }
}

