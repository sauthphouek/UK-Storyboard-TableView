//
//  ViewController.swift
//  tableView
//
//  Created by Sauth.P on 4/5/24.
//

import UIKit

// model Note



class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // 5 notes
    var notes: [NoteModel] = [
        // Cook food
        NoteModel(id: 1, title: "Cook food", content: "Cook food for dinner", image: ""),
        // Buy groceries
        NoteModel(id: 2, title: "Buy groceries", content: "Buy groceries for the week", image: "note.text"),
        // Walk dog
        NoteModel(id: 3, title: "Walk dog", content: "Walk the dog around the park", image: ""),
        // Clean room
        NoteModel(id: 4, title: "Clean room", content: "Clean the room and make the bed", image: "note.text"),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Notes"
        tableView.delegate = self
        tableView.dataSource = self
        
        // add button to navigation bar
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addNote() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "addNoteVC")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let note = notes[indexPath.row]
        // set title
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.content
        cell.imageView?.image = UIImage(systemName: note.image.isEmpty ? "note.text" : note.image)
        // set subtitle color
        cell.detailTextLabel?.textColor = .gray
        
        return  cell
        
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
        tableView.deselectRow(at: indexPath, animated: true)
        
        // present
        let note = notes[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "addNoteVC") as! AddNoteViewController
        vc.note = note
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            // show the alert
            self.present(self.alertConfirmationBox(indexPath: indexPath), animated: true)
            completion(true)
        }
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { action, view, completion in
            // edit note
            
        let note = self.notes[indexPath.row]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "addNoteVC") as! AddNoteViewController
            vc.note = note
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            completion(true)
        }
        
        let config = UISwipeActionsConfiguration(actions: [delete, edit])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    
    func alertConfirmationBox(indexPath:  IndexPath) -> UIAlertController {
        // alert confirmation
        let alert = UIAlertController(title: "Delete Note", message: "Are you sure you want to delete this note?", preferredStyle: .alert)
        
        // add delete action
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.notes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }))
        // add cancel action
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        return alert
    

    }
}

