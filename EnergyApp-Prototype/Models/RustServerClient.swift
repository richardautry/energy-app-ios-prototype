//
//  RustServer.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 9/5/23.
//

import Foundation

// TODO: Create calls to Rust Server here for automation starts using timer and grid sync

let RUST_SERVER_URL: String = "http://my_instance._energy_sync._tcp.local.";

struct RustCLient {

}

func hitRustServer(_ completion: @escaping (Data) -> Void) {
    let url = URL(string: RUST_SERVER_URL)!
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("error")
            return
        }
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print("wrong status code")
            return
        }
        if let mimeType = httpResponse.mimeType, mimeType == "application/json", let data = data {
                completion(data)
        }
    }
    task.resume()
}
