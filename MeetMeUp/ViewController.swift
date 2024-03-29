//
//  ViewController.swift
//  MeetMeUp
//
//  Created by Peter Hitchcock on 12/3/14.
//  Copyright (c) 2014 Peter Hitchcock. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var events = [Event]()
    let loadURL = "http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/33/open_events.json"

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = events[indexPath.row].name
        cell.detailTextLabel?.text = events[indexPath.row].address
        return cell
    }

    func getData() {
        let request = NSURLRequest(URL: NSURL(string: loadURL)!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            if error != nil {
                println(error.localizedDescription)
            }

            self.events = self.parseData(data)

            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        })
        task.resume()
    }

    func parseData(data: NSData) -> [Event] {
        var events = [Event]()
        var error: NSError?

        let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as? NSDictionary

        if error != nil {
            println(error?.localizedDescription)
        }

        let jsonEvents = jsonResult?["results"] as [AnyObject]
        for jsonEvent in jsonEvents {
            let event = Event()
            event.name = jsonEvent["name"] as String
            event.description = jsonEvent["description"] as String
            event.eventURL = jsonEvent["event_url"] as String

            if let venue = jsonEvent["venue"] as? [String: AnyObject] {
                event.address = venue["address_1"] as String
            }
            events.append(event)
        }
        return events
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSegue" {
            if let row = tableView.indexPathForSelectedRow()?.row {
                let destinationViewController = segue.destinationViewController as ShowViewController
                destinationViewController.event = events[row]
            }
        }
    }
}

