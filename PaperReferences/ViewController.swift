//
//  ViewController.swift
//  PaperReferences
//
//  Created by Mudit Verma on 8/22/20.
//  Copyright © 2020 Mudit Verma. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var tableData : TableData?
    var tableItems: [Paper]?
    
    @IBOutlet weak var paperNameField: NSTextField!
    @IBOutlet weak var paperLabel: NSTextField!
    //  @IBOutlet weak var tableView: NSScrollView!  --> this is the scroll view... drag the Table View under Clip View to get tableView NSTableView.
    
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // print ("viewdidload fun")
        tableData = TableData(jsonPath: "dummyPath")
        reloadTableList()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        // print ("representedObject fun")
            tableData = TableData(jsonPath: "dummyPath")
            reloadTableList()
        }
    }

    @IBAction func sayButtonClicked(_ sender: Any) {
        var name = paperNameField.stringValue
        
        if name.isEmpty{
            name = "World"
        }
        
        let greeting = "Added \(name)!"
        paperLabel.stringValue = greeting
        
        
        let url = URL(string: "http://export.arxiv.org/api/query?search_query=all:electron&start=0&max_results=1")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
            var xmlval = XMLParser(data: data)
            
            print (xmlval)
        }
        task.resume()
        
    }

    
    func reloadTableList() {
        // directoryItems = directory?.contentsOrderedBy(sortOrder, ascending: sortAscending)
      tableItems = tableData?.getData()
      tableView.reloadData()
    }
    
}


// =====================================================================================
// ==================================== TABLE STUFF ====================================
// =====================================================================================
extension ViewController: NSTableViewDataSource {
  
  func numberOfRows(in tableView: NSTableView) -> Int {
    print ("Getting table items")
    print(tableItems?.count)
    
    return tableItems?.count ?? 0
  }

}

extension ViewController: NSTableViewDelegate {
    
  fileprivate enum CellIdentifiers {
    static let PaperInfoCell = "paperInfoCell"
    static let AuthorsCell = "authorsCell"
    static let DateCell = "dateCell"
  }

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

    var image: NSImage?
    var text: String = ""
    var cellIdentifier: String = ""

    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .long
    
    // 1
    guard let item = tableItems?[row] else {
      return nil
    }

    // 2
    if tableColumn == tableView.tableColumns[0] {
//        text = dateFormatter.string(from: item.date)
        text = item.date
        cellIdentifier = CellIdentifiers.DateCell
    }
    
    else if tableColumn == tableView.tableColumns[1] {
        text = item.title
        cellIdentifier = CellIdentifiers.PaperInfoCell
    }
    
    else if tableColumn == tableView.tableColumns[2] {
        text = item.authors.joined(separator: ", ")
        cellIdentifier = CellIdentifiers.AuthorsCell
    }


    // 3
    if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
      cell.textField?.stringValue = text
      cell.imageView?.image = image ?? nil
      return cell
    }
    return nil
  }

}

