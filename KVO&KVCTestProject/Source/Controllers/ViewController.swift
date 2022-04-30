//
//  ViewController.swift
//  KVO&KVCTestProject
//
//  Created by Евгений Ганусенко on 4/30/22.
//

import UIKit

class Person: NSObject {
    @objc dynamic var name = String()
}

class ViewController: UIViewController {

    @IBOutlet weak var texField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!

    @objc let alex = Person()
    
    @objc dynamic var inputText: String?

    var nameObservation: NSKeyValueObservation?
    var inputTextObservation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()

        nameObservation = observe(\ViewController.alex.name, options: [.new, .old, .initial, .prior]) { vc, change in
            guard let updateName = change.newValue else { return }
            self.nameLabel.text = updateName
           // print("Изменили старое значение \(change.oldValue ?? "") на \(change.newValue ?? "")")
        }

        inputTextObservation = observe(\ViewController.inputText, options: .new) { (vc, change) in
            guard let updatedInputText = change.newValue as? String else { return }
            vc.textLabel.text = updatedInputText
        }
    }

    @IBAction func buttonTapped(_ sender: Any) {
        alex.name = "Alex"
    }


    @IBAction func textFieldEditingChange(_ sender: Any) {
        inputText = texField.text
    }
}

