//
//  AmondoSDK.swift
//  AmondoSDK
//
//  Created by Amondo on 7/24/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import AVKit

public class AmondoSDK: NSObject {
    
    override init() {}
    
    public class func initialise(appID:String,secretKey:String){
        
        loadFont("DIN_Pro_Condensed_Bold")
        loadFont("Inter-Bold")
        loadFont("Inter-Regular")
        loadFont("SF-Pro-Text-Regular")
        loadFont("SF-Pro-Text-Bold")
        loadFont("SF-Pro-Text-Semibold")
        
        if AMDUser.currentUser() != nil {
            if AMDUser.currentUser()!.username == appID {
                print("AMONDO_SDK: SDK already initialised")
                return;
            }
        }
        
        print("AMONDO_SDK: SDK initialising in background")
        Network.shared.configure()
        Network.shared.apollo!.perform(mutation: LoginMutation(email: appID, password: secretKey)) { result in
            switch result {
            case .success(let _):
                guard let data = try? result.get().data else { return }
                AMDUser.currentUser()?.token = data!.loginUser.token
                print("AMONDO_SDK: SDK successfully initialised")
            case .failure(let error):
                print("AMONDO_SDK: Error initialising -"+error.localizedDescription )
            }
        }
    }
    
    public class func deinitialise(){
        AMDUser.logOut()
    }
    
    public class func sharedInstance() -> AmondoSDK? {
        
        if AMDUser.currentUser() == nil {
            print("AMONDO_SDK: No initialised sdk")
            return nil
        }
        
        return AmondoSDK()
    }
    
    public func presentImprint(item: AMDImprintItem, animated:Bool, owner:UIViewController, gridStyle: ImprintGridStyle?, completionDone: @escaping ()->()){
        
        item.owner = owner
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, options: .duckOthers)
            try audioSession.setActive(true)
        } catch {
            
        }
        

        IMPRINTVC = nil
        curatedAssets = item.items
        IMPRINTVC?.view.removeFromSuperview()
        IMPRINTVC = nil
        
        let imprintStoryboard = UIStoryboard(name: "Imprint", bundle: Bundle(for: AmondoSDK.self))
        IMPRINTVCNAV = imprintStoryboard.instantiateInitialViewController() as? UINavigationController
        IMPRINTVC = IMPRINTVCNAV?.viewControllers.first as? ImprintGridViewController
        
        IMPRINTVC!.imprint = item
        if gridStyle != nil {
            IMPRINTVC!.gridStyle = gridStyle!
        }
        IMPRINTVCNAV?.modalTransitionStyle = .crossDissolve
        
        item.owner.present(IMPRINTVCNAV!, animated: animated) {
            completionDone()
        }
    }
    
    public func loadSingleImprint(id:Int, completion:@escaping (_ error:Error?,_ imprint:AMDImprintItem?)->()){
        
        Network.shared.apollo!.fetch(query: GetImprintsByIdQuery(ids: [String(id)])) { result in
            switch result {
            case .success(let graphQLResult):
                do {
                    let imprint = graphQLResult.data!.imprints[0].resultMap.jsonValue
                    let jsonData = try JSONSerialization.data(withJSONObject: imprint, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let deserializedObject = try decoder.decode(AMDImprintItem.self, from: jsonData)
                    completion(nil, deserializedObject)
                    return
                } catch {
                    print("AMONDO_SDK: ERROR WHILE PARSING IMPRINT DATA")
                    completion(nil, nil)
                    return
                }
            case .failure(_):
                print("AMONDO_SDK: ERROR WHILE FETCHING IMPRINT DATA")
                completion(nil, nil)
                return
            }
        }
    }
    
    public func loadAllImprints(completion:@escaping (_ error:Error?,_ imprints:[AMDImprintItem]?)->()){
        Network.shared.apollo!.fetch(query: GetImprintsQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                do {
                    var imprints: [AMDImprintItem] = []
                    for imprint in graphQLResult.data!.imprints {
                        let imprintData = imprint.resultMap.jsonValue
                        let jsonData = try JSONSerialization.data(withJSONObject: imprintData, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        let deserializedObject = try decoder.decode(AMDImprintItem.self, from: jsonData)
                        imprints.append(deserializedObject)
                    }
                    completion(nil, imprints)
                    return
                } catch {
                    print("AMONDO_SDK: ERROR WHILE PARSING IMPRINT DATA")
                    completion(nil, nil)
                    return
                }
            case .failure(_):
                print("AMONDO_SDK: ERROR WHILE FETCHING IMPRINT DATA")
                completion(nil, nil)
                return
            }
        }
        
    }
    
    public func loadImprintsWithIds(ids: [Int], completion:@escaping (_ error:Error?,_ imprints:[AMDImprintItem]?)->()){
        Network.shared.apollo!.fetch(query: GetImprintsByIdQuery(ids: ids.map{String($0)})) { result in
            switch result {
            case .success(let graphQLResult):
                do {
                    var imprints: [AMDImprintItem] = []
                    for imprint in graphQLResult.data!.imprints {
                        let imprintData = imprint.resultMap.jsonValue
                        let jsonData = try JSONSerialization.data(withJSONObject: imprintData, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        let deserializedObject = try decoder.decode(AMDImprintItem.self, from: jsonData)
                        imprints.append(deserializedObject)
                    }
                    completion(nil, imprints)
                    return
                } catch {
                    print("AMONDO_SDK: ERROR WHILE PARSING IMPRINT DATA")
                    completion(nil, nil)
                    return
                }
            case .failure(_):
                print("AMONDO_SDK: ERROR WHILE FETCHING IMPRINT DATA")
                completion(nil, nil)
                return
            }
        }
    }
    
}

func xibBundle() -> Bundle {
    let podBundle = Bundle(for: AmondoSDK.self)
    if let bundleURL = podBundle.url(forResource: "ViewBundle", withExtension: "bundle") {
        if let bundle = Bundle(url: bundleURL) {
            return bundle
        }else {
            return podBundle
        }
    }else {
        return podBundle
    }
}

func loadFont(_ name: String) -> Bool {
    let bundle = Bundle(for: AmondoSDK.self)
    guard let fontPath = bundle.path(forResource: name, ofType: "otf"),
        let data = try? Data(contentsOf: URL(fileURLWithPath: fontPath)),
        let provider = CGDataProvider(data: data as CFData)
        else {
            return false
    }
    
    let font = CGFont(provider)
    var error: Unmanaged<CFError>?
    
    let success = CTFontManagerRegisterGraphicsFont(font!, &error)
    if !success {
        print("Error loading font. Font is possibly already registered.")
        return false
    }
    
    return true
}
