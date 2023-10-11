import UIKit
import PlaygroundSupport

var greeting = "Hello, playground"

PlaygroundPage.current.needsIndefiniteExecution = true

let urlString = "http://quotes.rest/qod.json?category=inspire"
let url = URL(string: urlString)
let request = URLRequest(url: url!)
let session = URLSession.shared
let task = session.dataTask(with: request) { data, response, error in
    if error != nil { // Handle error
        return
    }
    print(String(data: data!, encoding: .utf8)!)
}
task.resume()
