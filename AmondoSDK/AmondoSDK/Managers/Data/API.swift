// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public enum CloudinaryFileType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case upload
  case `private`
  case authenticated
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "upload": self = .upload
      case "private": self = .private
      case "authenticated": self = .authenticated
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .upload: return "upload"
      case .private: return "private"
      case .authenticated: return "authenticated"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: CloudinaryFileType, rhs: CloudinaryFileType) -> Bool {
    switch (lhs, rhs) {
      case (.upload, .upload): return true
      case (.private, .private): return true
      case (.authenticated, .authenticated): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [CloudinaryFileType] {
    return [
      .upload,
      .private,
      .authenticated,
    ]
  }
}

public enum TileSource: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case instagram
  case facebook
  case twitter
  case amondo
  case youTube
  case tikTok
  case riddle
  case spotify
  case paperform
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "Instagram": self = .instagram
      case "Facebook": self = .facebook
      case "Twitter": self = .twitter
      case "Amondo": self = .amondo
      case "YouTube": self = .youTube
      case "TikTok": self = .tikTok
      case "Riddle": self = .riddle
      case "Spotify": self = .spotify
      case "Paperform": self = .paperform
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .instagram: return "Instagram"
      case .facebook: return "Facebook"
      case .twitter: return "Twitter"
      case .amondo: return "Amondo"
      case .youTube: return "YouTube"
      case .tikTok: return "TikTok"
      case .riddle: return "Riddle"
      case .spotify: return "Spotify"
      case .paperform: return "Paperform"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: TileSource, rhs: TileSource) -> Bool {
    switch (lhs, rhs) {
      case (.instagram, .instagram): return true
      case (.facebook, .facebook): return true
      case (.twitter, .twitter): return true
      case (.amondo, .amondo): return true
      case (.youTube, .youTube): return true
      case (.tikTok, .tikTok): return true
      case (.riddle, .riddle): return true
      case (.spotify, .spotify): return true
      case (.paperform, .paperform): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [TileSource] {
    return [
      .instagram,
      .facebook,
      .twitter,
      .amondo,
      .youTube,
      .tikTok,
      .riddle,
      .spotify,
      .paperform,
    ]
  }
}

public enum TileType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case photo
  case video
  case status
  case url
  case youtube
  case tiktok
  case riddle
  case spotify
  case submission
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "photo": self = .photo
      case "video": self = .video
      case "status": self = .status
      case "url": self = .url
      case "youtube": self = .youtube
      case "tiktok": self = .tiktok
      case "riddle": self = .riddle
      case "spotify": self = .spotify
      case "submission": self = .submission
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .photo: return "photo"
      case .video: return "video"
      case .status: return "status"
      case .url: return "url"
      case .youtube: return "youtube"
      case .tiktok: return "tiktok"
      case .riddle: return "riddle"
      case .spotify: return "spotify"
      case .submission: return "submission"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: TileType, rhs: TileType) -> Bool {
    switch (lhs, rhs) {
      case (.photo, .photo): return true
      case (.video, .video): return true
      case (.status, .status): return true
      case (.url, .url): return true
      case (.youtube, .youtube): return true
      case (.tiktok, .tiktok): return true
      case (.riddle, .riddle): return true
      case (.spotify, .spotify): return true
      case (.submission, .submission): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [TileType] {
    return [
      .photo,
      .video,
      .status,
      .url,
      .youtube,
      .tiktok,
      .riddle,
      .spotify,
      .submission,
    ]
  }
}

public enum CloudinaryResourceType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case raw
  case image
  case video
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "raw": self = .raw
      case "image": self = .image
      case "video": self = .video
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .raw: return "raw"
      case .image: return "image"
      case .video: return "video"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: CloudinaryResourceType, rhs: CloudinaryResourceType) -> Bool {
    switch (lhs, rhs) {
      case (.raw, .raw): return true
      case (.image, .image): return true
      case (.video, .video): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [CloudinaryResourceType] {
    return [
      .raw,
      .image,
      .video,
    ]
  }
}

public final class GetImprintsByIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetImprintsById($ids: [ID]) {
      imprints(where: {ids: $ids}) {
        __typename
        id
        publicId
        artist
        startDate
        endDate
        createdAt
        updatedAt
        location
        image {
          __typename
          url
          type
          width
          height
          publicId
          format
          version
        }
      }
    }
    """

  public let operationName: String = "GetImprintsById"

  public let operationIdentifier: String? = "8f29c07e1aaef1e0934f83ec5e95dbdbae9da604f6d396c452d791efe1ad4c62"

  public var ids: [GraphQLID?]?

  public init(ids: [GraphQLID?]? = nil) {
    self.ids = ids
  }

  public var variables: GraphQLMap? {
    return ["ids": ids]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("imprints", arguments: ["where": ["ids": GraphQLVariable("ids")]], type: .nonNull(.list(.nonNull(.object(Imprint.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(imprints: [Imprint]) {
      self.init(unsafeResultMap: ["__typename": "Query", "imprints": imprints.map { (value: Imprint) -> ResultMap in value.resultMap }])
    }

    public var imprints: [Imprint] {
      get {
        return (resultMap["imprints"] as! [ResultMap]).map { (value: ResultMap) -> Imprint in Imprint(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Imprint) -> ResultMap in value.resultMap }, forKey: "imprints")
      }
    }

    public struct Imprint: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Imprint"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("publicId", type: .scalar(Int.self)),
          GraphQLField("artist", type: .nonNull(.scalar(String.self))),
          GraphQLField("startDate", type: .scalar(String.self)),
          GraphQLField("endDate", type: .scalar(String.self)),
          GraphQLField("createdAt", type: .scalar(String.self)),
          GraphQLField("updatedAt", type: .scalar(String.self)),
          GraphQLField("location", type: .scalar(String.self)),
          GraphQLField("image", type: .object(Image.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, publicId: Int? = nil, artist: String, startDate: String? = nil, endDate: String? = nil, createdAt: String? = nil, updatedAt: String? = nil, location: String? = nil, image: Image? = nil) {
        self.init(unsafeResultMap: ["__typename": "Imprint", "id": id, "publicId": publicId, "artist": artist, "startDate": startDate, "endDate": endDate, "createdAt": createdAt, "updatedAt": updatedAt, "location": location, "image": image.flatMap { (value: Image) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// This one is common amongst different versions of Imprint, ie Imprints ID#1, 2 and 3 can have same publicId if they are versions of the same Imprint
      public var publicId: Int? {
        get {
          return resultMap["publicId"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "publicId")
        }
      }

      @available(*, deprecated, message: "Renamed to 'title'")
      public var artist: String {
        get {
          return resultMap["artist"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "artist")
        }
      }

      public var startDate: String? {
        get {
          return resultMap["startDate"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "startDate")
        }
      }

      public var endDate: String? {
        get {
          return resultMap["endDate"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "endDate")
        }
      }

      public var createdAt: String? {
        get {
          return resultMap["createdAt"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String? {
        get {
          return resultMap["updatedAt"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var location: String? {
        get {
          return resultMap["location"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "location")
        }
      }

      @available(*, deprecated, message: "Renamed to 'coverImage'")
      public var image: Image? {
        get {
          return (resultMap["image"] as? ResultMap).flatMap { Image(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "image")
        }
      }

      public struct Image: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CloudinaryFile"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("url", type: .scalar(String.self)),
            GraphQLField("type", type: .scalar(CloudinaryFileType.self)),
            GraphQLField("width", type: .scalar(Int.self)),
            GraphQLField("height", type: .scalar(Int.self)),
            GraphQLField("publicId", type: .scalar(String.self)),
            GraphQLField("format", type: .scalar(String.self)),
            GraphQLField("version", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(url: String? = nil, type: CloudinaryFileType? = nil, width: Int? = nil, height: Int? = nil, publicId: String? = nil, format: String? = nil, version: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "CloudinaryFile", "url": url, "type": type, "width": width, "height": height, "publicId": publicId, "format": format, "version": version])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var url: String? {
          get {
            return resultMap["url"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "url")
          }
        }

        public var type: CloudinaryFileType? {
          get {
            return resultMap["type"] as? CloudinaryFileType
          }
          set {
            resultMap.updateValue(newValue, forKey: "type")
          }
        }

        public var width: Int? {
          get {
            return resultMap["width"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "width")
          }
        }

        public var height: Int? {
          get {
            return resultMap["height"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "height")
          }
        }

        public var publicId: String? {
          get {
            return resultMap["publicId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "publicId")
          }
        }

        public var format: String? {
          get {
            return resultMap["format"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "format")
          }
        }

        public var version: Int? {
          get {
            return resultMap["version"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "version")
          }
        }
      }
    }
  }
}

public final class GetImprintsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetImprints($first: Int, $skip: Int) {
      imprints(first: $first, skip: $skip) {
        __typename
        id
        publicId
        artist
        startDate
        endDate
        createdAt
        updatedAt
        location
        image {
          __typename
          url
          type
          width
          height
          publicId
          format
          version
        }
      }
    }
    """

  public let operationName: String = "GetImprints"

  public let operationIdentifier: String? = "fd30c5b93a551de507f08e04e011e367c0c6fa1a9e2cef8a577a36f9632a0a07"

  public var first: Int?
  public var skip: Int?

  public init(first: Int? = nil, skip: Int? = nil) {
    self.first = first
    self.skip = skip
  }

  public var variables: GraphQLMap? {
    return ["first": first, "skip": skip]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("imprints", arguments: ["first": GraphQLVariable("first"), "skip": GraphQLVariable("skip")], type: .nonNull(.list(.nonNull(.object(Imprint.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(imprints: [Imprint]) {
      self.init(unsafeResultMap: ["__typename": "Query", "imprints": imprints.map { (value: Imprint) -> ResultMap in value.resultMap }])
    }

    public var imprints: [Imprint] {
      get {
        return (resultMap["imprints"] as! [ResultMap]).map { (value: ResultMap) -> Imprint in Imprint(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Imprint) -> ResultMap in value.resultMap }, forKey: "imprints")
      }
    }

    public struct Imprint: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Imprint"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("publicId", type: .scalar(Int.self)),
          GraphQLField("artist", type: .nonNull(.scalar(String.self))),
          GraphQLField("startDate", type: .scalar(String.self)),
          GraphQLField("endDate", type: .scalar(String.self)),
          GraphQLField("createdAt", type: .scalar(String.self)),
          GraphQLField("updatedAt", type: .scalar(String.self)),
          GraphQLField("location", type: .scalar(String.self)),
          GraphQLField("image", type: .object(Image.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, publicId: Int? = nil, artist: String, startDate: String? = nil, endDate: String? = nil, createdAt: String? = nil, updatedAt: String? = nil, location: String? = nil, image: Image? = nil) {
        self.init(unsafeResultMap: ["__typename": "Imprint", "id": id, "publicId": publicId, "artist": artist, "startDate": startDate, "endDate": endDate, "createdAt": createdAt, "updatedAt": updatedAt, "location": location, "image": image.flatMap { (value: Image) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// This one is common amongst different versions of Imprint, ie Imprints ID#1, 2 and 3 can have same publicId if they are versions of the same Imprint
      public var publicId: Int? {
        get {
          return resultMap["publicId"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "publicId")
        }
      }

      @available(*, deprecated, message: "Renamed to 'title'")
      public var artist: String {
        get {
          return resultMap["artist"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "artist")
        }
      }

      public var startDate: String? {
        get {
          return resultMap["startDate"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "startDate")
        }
      }

      public var endDate: String? {
        get {
          return resultMap["endDate"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "endDate")
        }
      }

      public var createdAt: String? {
        get {
          return resultMap["createdAt"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String? {
        get {
          return resultMap["updatedAt"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "updatedAt")
        }
      }

      public var location: String? {
        get {
          return resultMap["location"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "location")
        }
      }

      @available(*, deprecated, message: "Renamed to 'coverImage'")
      public var image: Image? {
        get {
          return (resultMap["image"] as? ResultMap).flatMap { Image(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "image")
        }
      }

      public struct Image: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CloudinaryFile"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("url", type: .scalar(String.self)),
            GraphQLField("type", type: .scalar(CloudinaryFileType.self)),
            GraphQLField("width", type: .scalar(Int.self)),
            GraphQLField("height", type: .scalar(Int.self)),
            GraphQLField("publicId", type: .scalar(String.self)),
            GraphQLField("format", type: .scalar(String.self)),
            GraphQLField("version", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(url: String? = nil, type: CloudinaryFileType? = nil, width: Int? = nil, height: Int? = nil, publicId: String? = nil, format: String? = nil, version: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "CloudinaryFile", "url": url, "type": type, "width": width, "height": height, "publicId": publicId, "format": format, "version": version])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var url: String? {
          get {
            return resultMap["url"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "url")
          }
        }

        public var type: CloudinaryFileType? {
          get {
            return resultMap["type"] as? CloudinaryFileType
          }
          set {
            resultMap.updateValue(newValue, forKey: "type")
          }
        }

        public var width: Int? {
          get {
            return resultMap["width"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "width")
          }
        }

        public var height: Int? {
          get {
            return resultMap["height"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "height")
          }
        }

        public var publicId: String? {
          get {
            return resultMap["publicId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "publicId")
          }
        }

        public var format: String? {
          get {
            return resultMap["format"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "format")
          }
        }

        public var version: Int? {
          get {
            return resultMap["version"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "version")
          }
        }
      }
    }
  }
}

public final class GetMeQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetMe {
      me {
        __typename
        id
        email
        firstName
        lastName
        team {
          __typename
          id
          name
          imprints {
            __typename
            id
            publicId
            title
          }
        }
      }
    }
    """

  public let operationName: String = "GetMe"

  public let operationIdentifier: String? = "1fa064fbc7deace799e398a87fbb7325244515fa263820cdc7548f4f4f1f7a6c"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("me", type: .object(Me.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(me: Me? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "me": me.flatMap { (value: Me) -> ResultMap in value.resultMap }])
    }

    public var me: Me? {
      get {
        return (resultMap["me"] as? ResultMap).flatMap { Me(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "me")
      }
    }

    public struct Me: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("team", type: .object(Team.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, email: String, firstName: String? = nil, lastName: String? = nil, team: Team? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "email": email, "firstName": firstName, "lastName": lastName, "team": team.flatMap { (value: Team) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var firstName: String? {
        get {
          return resultMap["firstName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstName")
        }
      }

      public var lastName: String? {
        get {
          return resultMap["lastName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lastName")
        }
      }

      public var team: Team? {
        get {
          return (resultMap["team"] as? ResultMap).flatMap { Team(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "team")
        }
      }

      public struct Team: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Team"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("imprints", type: .nonNull(.list(.object(Imprint.selections)))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, name: String? = nil, imprints: [Imprint?]) {
          self.init(unsafeResultMap: ["__typename": "Team", "id": id, "name": name, "imprints": imprints.map { (value: Imprint?) -> ResultMap? in value.flatMap { (value: Imprint) -> ResultMap in value.resultMap } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var imprints: [Imprint?] {
          get {
            return (resultMap["imprints"] as! [ResultMap?]).map { (value: ResultMap?) -> Imprint? in value.flatMap { (value: ResultMap) -> Imprint in Imprint(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Imprint?) -> ResultMap? in value.flatMap { (value: Imprint) -> ResultMap in value.resultMap } }, forKey: "imprints")
          }
        }

        public struct Imprint: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Imprint"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("publicId", type: .scalar(Int.self)),
              GraphQLField("title", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, publicId: Int? = nil, title: String) {
            self.init(unsafeResultMap: ["__typename": "Imprint", "id": id, "publicId": publicId, "title": title])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          /// This one is common amongst different versions of Imprint, ie Imprints ID#1, 2 and 3 can have same publicId if they are versions of the same Imprint
          public var publicId: Int? {
            get {
              return resultMap["publicId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "publicId")
            }
          }

          public var title: String {
            get {
              return resultMap["title"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }
        }
      }
    }
  }
}

public final class GetTilesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetTiles($imprintId: ID!) {
      tiles(imprintId: $imprintId, where: {deleted: false}) {
        __typename
        id
        username
        url
        location
        description
        likes
        commentCount
        source
        sourceId
        type
        date
        verified
        avatar {
          __typename
          width
          height
          secureUrl
          resourceType
          type
          version
          publicId
          format
          originalUrl
        }
        file {
          __typename
          width
          height
          secureUrl
          resourceType
          type
          version
          publicId
          format
          originalUrl
        }
      }
    }
    """

  public let operationName: String = "GetTiles"

  public let operationIdentifier: String? = "9ad1b26969102dff936f6ad2a71ff4d6e4de14d544374324e0340e57de701473"

  public var imprintId: GraphQLID

  public init(imprintId: GraphQLID) {
    self.imprintId = imprintId
  }

  public var variables: GraphQLMap? {
    return ["imprintId": imprintId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("tiles", arguments: ["imprintId": GraphQLVariable("imprintId"), "where": ["deleted": false]], type: .nonNull(.list(.nonNull(.object(Tile.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tiles: [Tile]) {
      self.init(unsafeResultMap: ["__typename": "Query", "tiles": tiles.map { (value: Tile) -> ResultMap in value.resultMap }])
    }

    public var tiles: [Tile] {
      get {
        return (resultMap["tiles"] as! [ResultMap]).map { (value: ResultMap) -> Tile in Tile(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Tile) -> ResultMap in value.resultMap }, forKey: "tiles")
      }
    }

    public struct Tile: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Tile"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("username", type: .scalar(String.self)),
          GraphQLField("url", type: .scalar(String.self)),
          GraphQLField("location", type: .scalar(String.self)),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("likes", type: .scalar(Int.self)),
          GraphQLField("commentCount", type: .scalar(Int.self)),
          GraphQLField("source", type: .scalar(TileSource.self)),
          GraphQLField("sourceId", type: .scalar(String.self)),
          GraphQLField("type", type: .scalar(TileType.self)),
          GraphQLField("date", type: .scalar(String.self)),
          GraphQLField("verified", type: .scalar(Bool.self)),
          GraphQLField("avatar", type: .object(Avatar.selections)),
          GraphQLField("file", type: .object(File.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, username: String? = nil, url: String? = nil, location: String? = nil, description: String? = nil, likes: Int? = nil, commentCount: Int? = nil, source: TileSource? = nil, sourceId: String? = nil, type: TileType? = nil, date: String? = nil, verified: Bool? = nil, avatar: Avatar? = nil, file: File? = nil) {
        self.init(unsafeResultMap: ["__typename": "Tile", "id": id, "username": username, "url": url, "location": location, "description": description, "likes": likes, "commentCount": commentCount, "source": source, "sourceId": sourceId, "type": type, "date": date, "verified": verified, "avatar": avatar.flatMap { (value: Avatar) -> ResultMap in value.resultMap }, "file": file.flatMap { (value: File) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// Username of a Social Platform user without the `@` part, eg `amondo` for `@amondo` account. For custom uploads, use this, rather than `realname`
      public var username: String? {
        get {
          return resultMap["username"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      @available(*, deprecated, message: "Renamed to `source_url`")
      public var url: String? {
        get {
          return resultMap["url"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "url")
        }
      }

      public var location: String? {
        get {
          return resultMap["location"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "location")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      @available(*, deprecated, message: "Renamed to `like_count`")
      public var likes: Int? {
        get {
          return resultMap["likes"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "likes")
        }
      }

      public var commentCount: Int? {
        get {
          return resultMap["commentCount"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "commentCount")
        }
      }

      /// Name of the original social network
      public var source: TileSource? {
        get {
          return resultMap["source"] as? TileSource
        }
        set {
          resultMap.updateValue(newValue, forKey: "source")
        }
      }

      /// Original ID from the platform where it was retrieved
      public var sourceId: String? {
        get {
          return resultMap["sourceId"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "sourceId")
        }
      }

      public var type: TileType? {
        get {
          return resultMap["type"] as? TileType
        }
        set {
          resultMap.updateValue(newValue, forKey: "type")
        }
      }

      @available(*, deprecated, message: "Renamed to `posted_at`")
      public var date: String? {
        get {
          return resultMap["date"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "date")
        }
      }

      /// Flags whether the user has verified badge
      public var verified: Bool? {
        get {
          return resultMap["verified"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "verified")
        }
      }

      public var avatar: Avatar? {
        get {
          return (resultMap["avatar"] as? ResultMap).flatMap { Avatar(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "avatar")
        }
      }

      @available(*, deprecated, message: "Renamed to `media`")
      public var file: File? {
        get {
          return (resultMap["file"] as? ResultMap).flatMap { File(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "file")
        }
      }

      public struct Avatar: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CloudinaryFile"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("width", type: .scalar(Int.self)),
            GraphQLField("height", type: .scalar(Int.self)),
            GraphQLField("secureUrl", type: .scalar(String.self)),
            GraphQLField("resourceType", type: .scalar(CloudinaryResourceType.self)),
            GraphQLField("type", type: .scalar(CloudinaryFileType.self)),
            GraphQLField("version", type: .scalar(Int.self)),
            GraphQLField("publicId", type: .scalar(String.self)),
            GraphQLField("format", type: .scalar(String.self)),
            GraphQLField("originalUrl", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(width: Int? = nil, height: Int? = nil, secureUrl: String? = nil, resourceType: CloudinaryResourceType? = nil, type: CloudinaryFileType? = nil, version: Int? = nil, publicId: String? = nil, format: String? = nil, originalUrl: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "CloudinaryFile", "width": width, "height": height, "secureUrl": secureUrl, "resourceType": resourceType, "type": type, "version": version, "publicId": publicId, "format": format, "originalUrl": originalUrl])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var width: Int? {
          get {
            return resultMap["width"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "width")
          }
        }

        public var height: Int? {
          get {
            return resultMap["height"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "height")
          }
        }

        public var secureUrl: String? {
          get {
            return resultMap["secureUrl"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "secureUrl")
          }
        }

        public var resourceType: CloudinaryResourceType? {
          get {
            return resultMap["resourceType"] as? CloudinaryResourceType
          }
          set {
            resultMap.updateValue(newValue, forKey: "resourceType")
          }
        }

        public var type: CloudinaryFileType? {
          get {
            return resultMap["type"] as? CloudinaryFileType
          }
          set {
            resultMap.updateValue(newValue, forKey: "type")
          }
        }

        public var version: Int? {
          get {
            return resultMap["version"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "version")
          }
        }

        public var publicId: String? {
          get {
            return resultMap["publicId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "publicId")
          }
        }

        public var format: String? {
          get {
            return resultMap["format"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "format")
          }
        }

        public var originalUrl: String? {
          get {
            return resultMap["originalUrl"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "originalUrl")
          }
        }
      }

      public struct File: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CloudinaryFile"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("width", type: .scalar(Int.self)),
            GraphQLField("height", type: .scalar(Int.self)),
            GraphQLField("secureUrl", type: .scalar(String.self)),
            GraphQLField("resourceType", type: .scalar(CloudinaryResourceType.self)),
            GraphQLField("type", type: .scalar(CloudinaryFileType.self)),
            GraphQLField("version", type: .scalar(Int.self)),
            GraphQLField("publicId", type: .scalar(String.self)),
            GraphQLField("format", type: .scalar(String.self)),
            GraphQLField("originalUrl", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(width: Int? = nil, height: Int? = nil, secureUrl: String? = nil, resourceType: CloudinaryResourceType? = nil, type: CloudinaryFileType? = nil, version: Int? = nil, publicId: String? = nil, format: String? = nil, originalUrl: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "CloudinaryFile", "width": width, "height": height, "secureUrl": secureUrl, "resourceType": resourceType, "type": type, "version": version, "publicId": publicId, "format": format, "originalUrl": originalUrl])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var width: Int? {
          get {
            return resultMap["width"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "width")
          }
        }

        public var height: Int? {
          get {
            return resultMap["height"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "height")
          }
        }

        public var secureUrl: String? {
          get {
            return resultMap["secureUrl"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "secureUrl")
          }
        }

        public var resourceType: CloudinaryResourceType? {
          get {
            return resultMap["resourceType"] as? CloudinaryResourceType
          }
          set {
            resultMap.updateValue(newValue, forKey: "resourceType")
          }
        }

        public var type: CloudinaryFileType? {
          get {
            return resultMap["type"] as? CloudinaryFileType
          }
          set {
            resultMap.updateValue(newValue, forKey: "type")
          }
        }

        public var version: Int? {
          get {
            return resultMap["version"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "version")
          }
        }

        public var publicId: String? {
          get {
            return resultMap["publicId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "publicId")
          }
        }

        public var format: String? {
          get {
            return resultMap["format"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "format")
          }
        }

        public var originalUrl: String? {
          get {
            return resultMap["originalUrl"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "originalUrl")
          }
        }
      }
    }
  }
}

public final class LoginMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation Login($email: String!, $password: String!) {
      loginUser(email: $email, password: $password) {
        __typename
        token
        user {
          __typename
          id
        }
      }
    }
    """

  public let operationName: String = "Login"

  public let operationIdentifier: String? = "c7e8e55721414948e02ea09710ab15f49e285c20bec52646d4d31b78b57937d0"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("loginUser", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .nonNull(.object(LoginUser.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(loginUser: LoginUser) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "loginUser": loginUser.resultMap])
    }

    /// Logins user in the system and returns the user object
    public var loginUser: LoginUser {
      get {
        return LoginUser(unsafeResultMap: resultMap["loginUser"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "loginUser")
      }
    }

    public struct LoginUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["AuthSuccess"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("token", type: .nonNull(.scalar(String.self))),
          GraphQLField("user", type: .nonNull(.object(User.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(token: String, user: User) {
        self.init(unsafeResultMap: ["__typename": "AuthSuccess", "token": token, "user": user.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Session code
      public var token: String {
        get {
          return resultMap["token"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      public var user: User {
        get {
          return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "user")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }
      }
    }
  }
}
