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

public enum ImprintStatus: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// Not shown in the iOS app but accessible via url
  case hidden
  /// Shown in the iOS app
  case active
  /// Shown in the iOS app and web imprint as upcoming
  case upcoming
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "hidden": self = .hidden
      case "active": self = .active
      case "upcoming": self = .upcoming
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .hidden: return "hidden"
      case .active: return "active"
      case .upcoming: return "upcoming"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ImprintStatus, rhs: ImprintStatus) -> Bool {
    switch (lhs, rhs) {
      case (.hidden, .hidden): return true
      case (.active, .active): return true
      case (.upcoming, .upcoming): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ImprintStatus] {
    return [
      .hidden,
      .active,
      .upcoming,
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
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "Instagram": self = .instagram
      case "Facebook": self = .facebook
      case "Twitter": self = .twitter
      case "Amondo": self = .amondo
      case "YouTube": self = .youTube
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
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "photo": self = .photo
      case "video": self = .video
      case "status": self = .status
      case "url": self = .url
      case "youtube": self = .youtube
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
        artist
        startDate
        endDate
        createdAt
        updatedAt
        locationRadius
        location
        geoPoint {
          __typename
          latitude
          longitude
        }
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

  public var ids: [GraphQLID?]?

  public init(ids: [GraphQLID?]? = nil) {
    self.ids = ids
  }

  public var variables: GraphQLMap? {
    return ["ids": ids]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("imprints", arguments: ["where": ["ids": GraphQLVariable("ids")]], type: .nonNull(.list(.nonNull(.object(Imprint.selections))))),
    ]

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

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("artist", type: .nonNull(.scalar(String.self))),
        GraphQLField("startDate", type: .scalar(String.self)),
        GraphQLField("endDate", type: .scalar(String.self)),
        GraphQLField("createdAt", type: .scalar(String.self)),
        GraphQLField("updatedAt", type: .scalar(String.self)),
        GraphQLField("locationRadius", type: .scalar(Int.self)),
        GraphQLField("location", type: .scalar(String.self)),
        GraphQLField("geoPoint", type: .nonNull(.object(GeoPoint.selections))),
        GraphQLField("image", type: .object(Image.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, artist: String, startDate: String? = nil, endDate: String? = nil, createdAt: String? = nil, updatedAt: String? = nil, locationRadius: Int? = nil, location: String? = nil, geoPoint: GeoPoint, image: Image? = nil) {
        self.init(unsafeResultMap: ["__typename": "Imprint", "id": id, "artist": artist, "startDate": startDate, "endDate": endDate, "createdAt": createdAt, "updatedAt": updatedAt, "locationRadius": locationRadius, "location": location, "geoPoint": geoPoint.resultMap, "image": image.flatMap { (value: Image) -> ResultMap in value.resultMap }])
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

      /// Title of the imprint.
      /// Should be deprecated in favor of `title` field.
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

      public var locationRadius: Int? {
        get {
          return resultMap["locationRadius"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "locationRadius")
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

      public var geoPoint: GeoPoint {
        get {
          return GeoPoint(unsafeResultMap: resultMap["geoPoint"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "geoPoint")
        }
      }

      public var image: Image? {
        get {
          return (resultMap["image"] as? ResultMap).flatMap { Image(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "image")
        }
      }

      public struct GeoPoint: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["GeoPoint"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("latitude", type: .nonNull(.scalar(Double.self))),
          GraphQLField("longitude", type: .nonNull(.scalar(Double.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(latitude: Double, longitude: Double) {
          self.init(unsafeResultMap: ["__typename": "GeoPoint", "latitude": latitude, "longitude": longitude])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var latitude: Double {
          get {
            return resultMap["latitude"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "latitude")
          }
        }

        public var longitude: Double {
          get {
            return resultMap["longitude"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "longitude")
          }
        }
      }

      public struct Image: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CloudinaryFile"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("url", type: .scalar(String.self)),
          GraphQLField("type", type: .scalar(CloudinaryFileType.self)),
          GraphQLField("width", type: .scalar(Int.self)),
          GraphQLField("height", type: .scalar(Int.self)),
          GraphQLField("publicId", type: .scalar(String.self)),
          GraphQLField("format", type: .scalar(String.self)),
          GraphQLField("version", type: .scalar(Int.self)),
        ]

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
        status
        artist
        startDate
        endDate
        createdAt
        updatedAt
        locationRadius
        location
        geoPoint {
          __typename
          latitude
          longitude
        }
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

  public var first: Int? = 100
  public var skip: Int? = 0

  public init(first: Int? = 100, skip: Int? = 0) {
    self.first = first
    self.skip = skip
  }

  public var variables: GraphQLMap? {
    return ["first": first, "skip": skip]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("imprints", arguments: ["first": GraphQLVariable("first"), "skip": GraphQLVariable("skip")], type: .nonNull(.list(.nonNull(.object(Imprint.selections))))),
    ]

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

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("status", type: .scalar(ImprintStatus.self)),
        GraphQLField("artist", type: .nonNull(.scalar(String.self))),
        GraphQLField("startDate", type: .scalar(String.self)),
        GraphQLField("endDate", type: .scalar(String.self)),
        GraphQLField("createdAt", type: .scalar(String.self)),
        GraphQLField("updatedAt", type: .scalar(String.self)),
        GraphQLField("locationRadius", type: .scalar(Int.self)),
        GraphQLField("location", type: .scalar(String.self)),
        GraphQLField("geoPoint", type: .nonNull(.object(GeoPoint.selections))),
        GraphQLField("image", type: .object(Image.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, status: ImprintStatus? = nil, artist: String, startDate: String? = nil, endDate: String? = nil, createdAt: String? = nil, updatedAt: String? = nil, locationRadius: Int? = nil, location: String? = nil, geoPoint: GeoPoint, image: Image? = nil) {
        self.init(unsafeResultMap: ["__typename": "Imprint", "id": id, "status": status, "artist": artist, "startDate": startDate, "endDate": endDate, "createdAt": createdAt, "updatedAt": updatedAt, "locationRadius": locationRadius, "location": location, "geoPoint": geoPoint.resultMap, "image": image.flatMap { (value: Image) -> ResultMap in value.resultMap }])
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

      public var status: ImprintStatus? {
        get {
          return resultMap["status"] as? ImprintStatus
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      /// Title of the imprint.
      /// Should be deprecated in favor of `title` field.
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

      public var locationRadius: Int? {
        get {
          return resultMap["locationRadius"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "locationRadius")
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

      public var geoPoint: GeoPoint {
        get {
          return GeoPoint(unsafeResultMap: resultMap["geoPoint"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "geoPoint")
        }
      }

      public var image: Image? {
        get {
          return (resultMap["image"] as? ResultMap).flatMap { Image(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "image")
        }
      }

      public struct GeoPoint: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["GeoPoint"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("latitude", type: .nonNull(.scalar(Double.self))),
          GraphQLField("longitude", type: .nonNull(.scalar(Double.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(latitude: Double, longitude: Double) {
          self.init(unsafeResultMap: ["__typename": "GeoPoint", "latitude": latitude, "longitude": longitude])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var latitude: Double {
          get {
            return resultMap["latitude"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "latitude")
          }
        }

        public var longitude: Double {
          get {
            return resultMap["longitude"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "longitude")
          }
        }
      }

      public struct Image: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["CloudinaryFile"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("url", type: .scalar(String.self)),
          GraphQLField("type", type: .scalar(CloudinaryFileType.self)),
          GraphQLField("width", type: .scalar(Int.self)),
          GraphQLField("height", type: .scalar(Int.self)),
          GraphQLField("publicId", type: .scalar(String.self)),
          GraphQLField("format", type: .scalar(String.self)),
          GraphQLField("version", type: .scalar(Int.self)),
        ]

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

public final class GetTilesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetTiles($imprintId: ID!) {
      tiles(imprintId: $imprintId) {
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

  public var imprintId: GraphQLID

  public init(imprintId: GraphQLID) {
    self.imprintId = imprintId
  }

  public var variables: GraphQLMap? {
    return ["imprintId": imprintId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("tiles", arguments: ["imprintId": GraphQLVariable("imprintId")], type: .nonNull(.list(.nonNull(.object(Tile.selections))))),
    ]

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

      public static let selections: [GraphQLSelection] = [
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

      /// Username of a Social Platform user without the `@` part, eg `amondo` for
      /// `@amondo` account. For custom uploads, use this, rather than `realname`
      public var username: String? {
        get {
          return resultMap["username"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
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

      public var location: String? {
        get {
          return resultMap["location"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "location")
        }
      }

      /// Caption
      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      /// Number of likes on original social network
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

      /// Avatar image from the tile creator on original social network
      public var avatar: Avatar? {
        get {
          return (resultMap["avatar"] as? ResultMap).flatMap { Avatar(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "avatar")
        }
      }

      /// Tile Media
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

        public static let selections: [GraphQLSelection] = [
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

        public static let selections: [GraphQLSelection] = [
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

    public static let selections: [GraphQLSelection] = [
      GraphQLField("loginUser", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .nonNull(.object(LoginUser.selections))),
    ]

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

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("token", type: .nonNull(.scalar(String.self))),
        GraphQLField("user", type: .nonNull(.object(User.selections))),
      ]

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

      /// JWT Token
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

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        ]

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
