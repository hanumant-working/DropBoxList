//
//  Connection.swift
//  DropBoxList
//
//  Created by Hanumant S on 29/01/18.
//  Copyright © 2018 Hanumant S. All rights reserved.
//

import Foundation



class DataParser {

    // Read json file from local bundle
    private func parseData(fileName jsonFileName: String, completion:([String: Any])-> Void ) {
        do {
            if let path = Bundle.main.path(forResource: jsonFileName, ofType: "json") {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: AnyObject] {
                    // json is a dictionary
                    completion(object)
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    // Parse json and create data model array
    func getFactsData(fileName: String, completion:([DataFactModel], String)-> Void) {
        parseData(fileName: fileName) { (jsonData) in
            var dataFactArray = [DataFactModel]()

            var screenTitle = "FactsList" // Set default screen title
            if let title = jsonData["title"] as? String {
                screenTitle = title // Set screen title from JSON
            }
            
            if let rows = jsonData["rows"] as? [[String:AnyObject]] {
                for object in rows {
                    let modelObj = DataFactModel(title: object["title"] as? String,
                                                 description: object["description"] as? String, imageURL: object["imageHref"] as? String)
                    dataFactArray.append(modelObj)
                }
            }
            
            completion(dataFactArray, screenTitle)
        }
    }
    
    
    // Read data from URL using URLSession
    func getDataFromURL(requestURL: String, completion: ()-> Void) {
        var request = URLRequest(url: URL(string: requestURL)!)
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { (respData, response, error) in
            print("data::\(String(describing: String(data: respData!, encoding: String.Encoding.utf8)))")
            print("error:\(String(describing: error))")
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: (\(httpResponse.statusCode))")
                if httpResponse.statusCode == 200{
                    do{
                        let json = try JSONSerialization.jsonObject(with: respData!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                        print("serviceResponse: \(String(describing: json))")
                    }catch let exception {
                        print(exception.localizedDescription)
                    }
                }
            }
            }.resume()
    }
    
}
