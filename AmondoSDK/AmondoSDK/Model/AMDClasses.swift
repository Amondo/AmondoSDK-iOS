import Photos
import UIKit
import AVKit
import Alamofire
import KeychainSwift
import Cloudinary

class AMDDefaults {

    class Standard {
        class func getString(key: String) -> String? {
            let string = UserDefaults.standard.string(forKey: "AMDUSERDEFAULTS_"+key)
            return string
        }
        class func getData(key: String) -> Data? {
            let data = UserDefaults.standard.data(forKey: "AMDUSERDEFAULTS_"+key)
            return data
        }
        class func setString(key: String, value: String) {
            UserDefaults.standard.set(value, forKey: "AMDUSERDEFAULTS_"+key)

        }
        class func setData(key: String, value: Data) {
            UserDefaults.standard.set(value, forKey: "AMDUSERDEFAULTS_"+key)

        }
        class func delete(key: String) {
            UserDefaults.standard.set(nil, forKey: "AMDUSERDEFAULTS_"+key)

        }

        class func getDate(key: String) -> Date? {
            let date = UserDefaults.standard.object(forKey: "AMDUSERDEFAULTS_"+key) as? Date
            return date
        }
        class func setDate(key: String, value: Date) {
            UserDefaults.standard.set(value, forKey: "AMDUSERDEFAULTS_"+key)

        }

    }

}

struct StringError: LocalizedError {
    var errorDescription: String? { return mMsg }
    var failureReason: String? { return mMsg }
    var recoverySuggestion: String? { return "" }
    var helpAnchor: String? { return "" }

    private var mMsg: String

    init(_ msg: String) {
        mMsg = msg
    }
}

class AMDObject: NSMutableDictionary {
    func objectId() -> String {
        return String(self["id"] as! Int)
    }
}

class AMDUserAssetUploader: NSObject {

    convenience init(ass: PHAsset) {
        self.init()
        self.asset = ass
        type = "photo"
        if ass.mediaType == .video {
            type = "video"
        }
        self.itemID = ass.localIdentifier
    }

    var asset: PHAsset!
    var type: String!
    var itemID: String!

    class func cloudinaryDelete(itemID: String) {
        let cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "amondo-media"))
        let mng = cloudinary.createManagementApi()

        mng.destroy(itemID, params: nil) { (_: CLDDeleteResult?, _: Error?) in

        }
    }

    func profileImageUpload(data: Data, tprogress: @escaping (_ fraction: Double) -> Void, completion:@escaping (_ success: Bool, _ error: AMDError?, _ json: [String: Any]?) -> Void) {

        let cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "amondo-media"))

        let uploader = cloudinary.createUploader()

        let uparams = CLDUploadRequestParams()

        uploader.upload(data: data, uploadPreset: "u5vklcbz", params: uparams, progress: { (progress:Progress) in
            tprogress(progress.fractionCompleted)
        }, completionHandler: { (result: CLDUploadResult?, error: NSError?) in

            if error == nil {

                let uploadJSON = result!.resultJson

                completion(true, nil, uploadJSON)

            } else {

                let aerror = AMDError(code: "400", errorString: error!.localizedDescription, info: nil)
                completion(false, aerror, nil)
            }

        })

    }

    func cloudinaryUpload(data: Data, eventID: Int, tprogress: @escaping (_ fraction: Double) -> Void, completion:@escaping (_ success: Bool, _ error: AMDError?) -> Void) {

        let cloudinary = CLDCloudinary(configuration: CLDConfiguration(cloudName: "amondo-media"))

        let uploader = cloudinary.createUploader()

        let uparams = CLDUploadRequestParams()
        if type == "video" {
            uparams.setResourceType("video")
        }

        uploader.upload(data: data, uploadPreset: "u5vklcbz", params: uparams, progress: { (progress:Progress) in
            tprogress(progress.fractionCompleted)
        }, completionHandler: { (result: CLDUploadResult?, error: NSError?) in

            if error == nil {

                self.saveNewAsset(params: result!.resultJson, eventID: eventID, completion: { (error: AMDError?, _: Bool) in
                    if error == nil {
                        completion(true, nil)
                    } else {

                        completion(false, error)
                    }
                })

            } else {

                let aerror = AMDError(code: "400", errorString: error!.localizedDescription, info: nil)
                completion(false, aerror)
            }

        })

    }

    func getDataForVideo(completion:@escaping (_ data: Data?, _ success: Bool) -> Void) {

        PHImageManager.default().requestAVAsset(forVideo: asset, options: PHVideoRequestOptions()) { asset, _, _ in

            do {
                let data = try Data(contentsOf: (asset as! AVURLAsset).url)
                completion(data, true)
                return
            } catch {

            }
            completion(nil, false)
            return
        }
    }

    func getDataForPhoto(completion:@escaping (_ data: Data?, _ success: Bool) -> Void) {
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.version = .original
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        
        manager.requestImageData(for: asset, options: options) { data, string, _, _ in
            
            if let data = data {
                if string?.range(of: ".heic") != nil || string?.range(of: ".heif") != nil {
                    let rawImage = UIImage(data: data)
                    let rawImageOrientationFix = self.fixOrientation(img: rawImage!)
                    let jpegData = rawImageOrientationFix.jpegData(compressionQuality: 1.0)
                    completion(jpegData, true)
                } else {
                    completion(data, true)
                }

            }
        }

    }
    
    func fixOrientation(img:UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img;
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale);
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        
        let normalizedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return normalizedImage;
        
    }

    func getDataForAsset(completion:@escaping (_ data: Data?, _ success: Bool) -> Void) {
        if self.asset.mediaType == .image {
            getDataForPhoto(completion: { (d: Data?, s: Bool) in
                completion(d, s)
            })
        } else if self.asset.mediaType == .video {
            getDataForVideo(completion: { (d: Data?, s: Bool) in
                completion(d, s)
            })
        }
    }

    func saveNewAsset(params: [String: Any], eventID: Int, completion:@escaping (_ error: AMDError?, _ success: Bool) -> Void) {

        let urlstring="https://api.amondo.com/asset"
        let token = AMDUser.currentUser()!.token!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json",
            "Prefer": "return=representation"
        ]

        let parameters: Parameters = ["file": params, "created_at": Date().postgrestDate(), "event_id": eventID, "user_id": AMDUser.currentUser()?.id]

        Alamofire.request(URL(string: urlstring)!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response: DataResponse<Any>) in
            switch response.result {
            case .success:
                completion(nil, true)
            case .failure(let error):
                let aerror = AMDError(code: "400", errorString: error.localizedDescription, info: nil)
                completion(aerror, false)
            }
        }
    }

    class func randomSlugCreator(length: Int) -> String {
        var string=""
        var possible = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "O", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        for _ in 0 ..< length {
            let rand = possible[Int(arc4random_uniform(UInt32(possible.count)))]

            string += rand
        }

        return string
    }
    class func updateEventSlug(event: String, slug: String, completion:@escaping (_ error: AMDError?, _ success: Bool) -> Void) {

        var urlstring="https://api.amondo.com/events_users?event_id=eq.\(event)"

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(AMDUser.currentUser()!.token!)",
            "Content-Type": "application/json",
            "Prefer": "return=representation"
        ]

        let parameters: Parameters = ["slug": slug]

        let allowedCharacterSet = (CharacterSet(charactersIn: "<>,{} @").inverted)

        if let escapedString = urlstring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            //do something with escaped string
            urlstring = escapedString
        } else {
            urlstring=""
        }

        Alamofire.request(URL(string: urlstring)!, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response: DataResponse<Any>) in
            switch response.result {

            case .success:

                if let resparray = response.result.value as? NSArray {
                    if let attributes = (resparray).firstObject as? [String: Any] {

                        if let dbslug = attributes["slug"] as? String {
                            if dbslug == slug {
                                completion(nil, true)
                                return
                            }
                        }

                    }
                }

                completion(AMDError(code: "0", errorString: "Something went wrong", info: nil), false)
                return

            case .failure(let error):

                let aerror = AMDError(code: "400", errorString: error.localizedDescription, info: nil)

                completion(aerror, false)

            }
        }
    }

    class func getEventSlug(event: String, completion:@escaping (_ error: AMDError?, _ slug: String?) -> Void) {

        var urlstring="https://api.amondo.com/events_users?event_id=eq.\(event)"

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(AMDUser.currentUser()!.token!)",
            "Content-Type": "application/json"
        ]

        //  let parameters: Parameters = ["slug":slug]// ["username":self.username!, "password":self.password!]
        //Prefer: return=representation

        let allowedCharacterSet = (CharacterSet(charactersIn: "<>,{} @").inverted)

        if let escapedString = urlstring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            //do something with escaped string
            urlstring = escapedString
        } else {
            urlstring=""
        }

        Alamofire.request(URL(string: urlstring)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response: DataResponse<Any>) in
            switch response.result {

            case .success:

                if let resparray = response.result.value as? NSArray {
                    if let attributes = (resparray).firstObject as? [String: Any] {
                        //     print(attributes)

                        if let dbslug = attributes["slug"] as? String {
                            completion(nil, dbslug)
                            return
                        }

                    }
                }

                completion(AMDError(code: "0", errorString: "Something went wrong", info: nil), nil)
                return

            case .failure(let error):

                let aerror = AMDError(code: "400", errorString: error.localizedDescription, info: nil)

                completion(aerror, nil)

            }
        }
    }
}

class AMDError: Error {
    var code: String!
    var errorString: String!
    var userInfo: [String: Any]?

    convenience init(code: String, errorString: String, info: [String: Any]?) {
        self.init()
        self.code = code
        self.errorString = errorString
        self.userInfo = info

    }
}

func dataToJSON(data: Data) -> Any? {
    do {
        return try JSONSerialization.jsonObject(with: data, options: .allowFragments)
    } catch let myJSONError {
        print(myJSONError)
    }
    return nil
}

func jsonToData(json: Any) -> Data? {
    do {
        return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
    } catch let myJSONError {
        print(myJSONError)
    }
    return nil
}

class AMDQuery: NSObject {

    // not.eq
    var className: String!
    var limit: Int?
    var parameters = [AMDEndpointParameter]()
    var request: DataRequest!

    convenience init(className: String) {
        self.init()
        self.className = className
    }

    func whereKey(key: String, isLessThan: Any) {
        // < less than
        let param = AMDEndpointParameter(k: key, o: "lt", v: isLessThan)
        self.parameters.append(param)
    }

    func whereKey(key: String, isGreaterThan: Any) {
        // > greater than
        let param = AMDEndpointParameter(k: key, o: "gt", v: isGreaterThan)
        self.parameters.append(param)
    }

    func whereKey(key: String, isEqualTo: Any) {
        // == equal to
        let param = AMDEndpointParameter(k: key, o: "eq", v: isEqualTo)
        self.parameters.append(param)
    }

    func whereKey(key: String, containedIn: Any) {
        // contained in
        let param = AMDEndpointParameter(k: key, o: "in", v: containedIn)
        self.parameters.append(param)
    }

    func whereKey(key: String, notContainedIn: Any) {
        let param = AMDEndpointParameter(k: key, o: "not.in", v: notContainedIn)
        self.parameters.append(param)
    }

    func whereKeyExists(key: String) {
        let param = AMDEndpointParameter(k: key, o: "exists", v: true)
        self.parameters.append(param)
    }
    func orderByAscending(key: String) {
        let param = AMDEndpointParameter(k: key, o: "order++", v: true)
        self.parameters.append(param)
    }
    func orderByDescending(key: String) {
        let param = AMDEndpointParameter(k: key, o: "order--", v: true)
        self.parameters.append(param)
    }
    func whereKeyContainsString(key: String, string: String) {
        let param = AMDEndpointParameter(k: key, o: "@@", v: string)
        self.parameters.append(param)
    }
    func whereKeyContainsOrString(key: String, string: String) {
        let param = AMDEndpointParameter(k: key, o: "|@", v: string)
        self.parameters.append(param)
    }

    func parsedURL() -> String {

        if self.className == "SearchEvents" {
            var searchTerm = ""
            for el in self.parameters {
                if el._key == "searchTerm" {
                    searchTerm = el._value as! String
                }
            }
            var urlString = "https://relay.amondo.com/search/"+searchTerm
            print(urlString)
            let allowedCharacterSet = (CharacterSet(charactersIn: "<>,{} ").inverted)

            if let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                //do something with escaped string
                urlString = escapedString
            } else {
                return ""
            }
            return urlString
        }
        var urlString="https://api.amondo.com/\(self.className!)?"

        var index = 0
        for parameter in parameters {

            urlString += parameter.urlConstructor()

            if index < parameters.count - 1 {
                urlString+="&"
            }
            index += 1
        }

        if self.limit != nil {
            urlString+="&limit=\(self.limit!)"
        }
        //urlString+="/"

        let allowedCharacterSet = (CharacterSet(charactersIn: "<>,{} ").inverted)

        if let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            //do something with escaped string
            urlString = escapedString
        } else {
            return ""
        }

        return urlString
    }

    func postgrestToAMDImprint(object: Dictionary<String, Any>) -> AMDImprintItem {

        let statusString = object["status"] as! String
        var status: AMDImprintItem.Status!

        if statusString == "active" {
            status = .active
        } else if statusString == "upcoming" {
            status = .upcoming
        } else {
            status = .hidden
        }

        let men = AMDImprintItem()
        men.object = object
        men.status = status
        if let imageDictionaryInfo = men.object!["image"] as? [String : Any] {
            men.imageMeta = AMDFile(file: imageDictionaryInfo, ftype: AMDFileType.image.rawValue)
        }

        let event = AMDEvent()
        event.id = String(object["id"] as! Int)
        event.location = object["location"] as? String
        event.artist = object["artist"] as? String
        if (object["startDate"] is NSNull) {
            event.date = Date()
        } else {
            event.date = (object["startDate"] as! String).dateFromPostgresString()
        }

        men.event = event

        men.contributed = AMDUser.currentUser()!.contributedEvents.contains(men.objectID())
        if men.contributed {
            let end = (object["endDate"] as! String).dateFromPostgresString()
            let start = (object["startDate"] as! String).dateFromPostgresString()
            let count = AMDImprintItem.getAllAssetsCount(start: start, end: end, event: object)

            men.contributedAssetsCount = Int(count)
        }
        men.notified = AMDUser.currentUser()!.notifiedEvents.contains(men.objectID())
        men.liked = AMDUser.currentUser()!.events_users.contains(men.objectID())

        return men

    }

    func getObjectsInBackground(completion:@escaping (_ error: AMDError?, _ objects: [Dictionary<String, Any>]?) -> Void) {

        let urlstring = self.parsedURL()

        if urlstring == "" {
            completion(nil, nil)
        }
        print("Get objects in background from: \(urlstring)")

        self.request = Alamofire.request(URL(string: urlstring)!, method: .get).responseJSON { (response: DataResponse<Any>) in

            switch response.result {

            case .success:

                if let result = response.result.value as? [String: Any] {

                    let code = result["code"] as! String

                    let message = result["message"] as! String

                    let error = AMDError(code: code, errorString: message, info: result)
                    DispatchQueue.main.async {

                        completion(error, nil)
                    }
                    return
                }

                let results = response.result.value as! NSArray

                var objects = [[String: Any]]()

                for result in results {
                    if let object = result as? [String: Any] {
                        objects.append(object)
                    }
                }
                DispatchQueue.main.async {

                    completion(nil, objects )
                }
                return
            case .failure(let error):

                let error = AMDError(code: "400", errorString: error.localizedDescription, info: nil)

                DispatchQueue.main.async {
                    completion(error, nil)
                }

                return
            }

        }

    }

    func _deleteObjectsInBackground(completion:@escaping (_ error: AMDError?, _ deleted: Bool?) -> Void) {

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(AMDUser.currentUser()!.token!)",
            "Content-Type": "application/json"
        ]

        let urlstring = self.parsedURL()
        print(urlstring)

        if urlstring == "" {
            completion(nil, nil)
        }
        print("\n")
        print(urlstring)
        print("\n")

        Alamofire.request(URL(string: urlstring)!, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response: DataResponse<Any>) in

            switch response.result {

            case .success:

                if let result = response.result.value as? Dictionary<String, Any> {

                    let code = result["code"] as! String

                    let message = result["message"] as! String

                    let error = AMDError(code: code, errorString: message, info: result)

                    completion(error, nil)
                    return
                }

                DispatchQueue.main.async {
                    completion(nil, true )
                    return
                }

            case .failure(let error):

                let error = AMDError(code: "400", errorString: error.localizedDescription, info: nil)

                DispatchQueue.main.async {
                    completion(error, nil)
                }
            }
        }
    }
}

class AMDEndpointParameter: NSObject {

    var _key: String!
    var _operator: String!
    var _value: Any!

    convenience init(k: String, o: String, v: Any) {
        self.init()
        self._key = k
        self._operator = o
        self._value = v
    }

    func urlConstructor() -> String {

        let op = self._operator!
        let key = self._key!
        let value = self._value!

        if op == "lt" || op == "gt" || op == "eq" {
            return "\(key)=\(op).\(value)"
        }

        if op == "order++" {
            return "order=\(key)"
        }

        if op == "order--" {
            return "order=\(key).desc"
        }

        if op == "exists" {
            return "\(key)=neq.null"
        }

        if op == "@@" {
            return "\(key)=@@.\(value)"
        }

        if op == "in" || op == "not.in" {
            let array = (value as! [Any])
            var index = 0
            var values = ""

            for el in array {
                values += "\(el)"
                if index < array.count - 1 {
                    values+=","
                }
                index += 1
            }

            return "\(key)=\(op).\(values)"
        }

        return "error"
    }

}
