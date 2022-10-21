//  File.swift
//  TimeFora
//
//  Created by Davi Capistrano on 14/10/22.
//

import UIKit

class Api {

    static func makeRequest(completion: @escaping ([Post]) -> Void) {
        let url = URL(string: "https://brasilapi.com.br/api/feriados/v1/2022")!

        // data -> É o objeto em bytes que vamos transformar para conseguirmos ler
        // response -> As informações do header
        // erro - > Se der algum erro, ele vai ser preenchido ou vai ser nulo

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in

            //            print("response \(String(describing: response))")
            //            print("error: \(String(describing: error))")

            guard let responseData = data else {return}

            do {
                let posts = try JSONDecoder().decode([Post].self, from: responseData)
                // print("obects posts: \(posts)")
                completion(posts)

            } catch let error {
                print("error: \(error)")
            }

        }
        task.resume()
    }
}
