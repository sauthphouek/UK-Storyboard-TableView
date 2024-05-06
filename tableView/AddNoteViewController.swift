//
//  AddNoteViewController.swift
//  tableView
//
//  Created by Sauth.P on 4/5/24.
//

import UIKit

class AddNoteViewController: UIViewController {
    @IBOutlet weak var title: UITextField!
    
    @IBOutlet weak var subtitle: UITextField!
    
    var note: NoteModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "Add New Note"
        
        // add hieght to myTitle
        myTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        subtitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
       if (note != nil) {
            myTitle.text = note.title
            subtitle.text = note.content
        }
        
        // add save button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
        
    }
    
    @objc func saveNote() {
        if (note == nil) {
            note = NoteModel(id: 0, title: myTitle.text!, content: subtitle.text!, image: "")
        } else {
            note.title = myTitle.text!
            note.content = subtitle.text!
        }
        
        navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigatio

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
