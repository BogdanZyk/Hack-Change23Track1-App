// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetRoomByKeyQuery: GraphQLQuery {
  public static let operationName: String = "GetRoomByKey"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetRoomByKey($key: String!) { GetRoomByKey(Key: $key) { __typename ...RoomAttrs } }"#,
      fragments: [RoomAttrs.self, MediaInfoAttrs.self, SourceAttrs.self]
    ))

  public var key: String

  public init(key: String) {
    self.key = key
  }

  public var __variables: Variables? { ["key": key] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootQueryType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("GetRoomByKey", GetRoomByKey?.self, arguments: ["Key": .variable("key")]),
    ] }

    public var getRoomByKey: GetRoomByKey? { __data["GetRoomByKey"] }

    public init(
      getRoomByKey: GetRoomByKey? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootQueryType.typename,
          "GetRoomByKey": getRoomByKey._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(GetRoomByKeyQuery.Data.self)
        ]
      ))
    }

    /// GetRoomByKey
    ///
    /// Parent Type: `Room`
    public struct GetRoomByKey: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Room }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(RoomAttrs.self),
      ] }

      public var mediaInfo: MediaInfo? { __data["MediaInfo"] }
      public var id: String? { __data["Id"] }
      public var likes: Int? { __data["Likes"] }
      public var `private`: Bool? { __data["Private"] }
      public var image: String? { __data["Image"] }
      public var key: String? { __data["Key"] }
      public var name: String? { __data["Name"] }
      public var owner: RoomAttrs.Owner? { __data["Owner"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var roomAttrs: RoomAttrs { _toFragment() }
      }

      public init(
        mediaInfo: MediaInfo? = nil,
        id: String? = nil,
        likes: Int? = nil,
        `private`: Bool? = nil,
        image: String? = nil,
        key: String? = nil,
        name: String? = nil,
        owner: RoomAttrs.Owner? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.Room.typename,
            "MediaInfo": mediaInfo._fieldData,
            "Id": id,
            "Likes": likes,
            "Private": `private`,
            "Image": image,
            "Key": key,
            "Name": name,
            "Owner": owner._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(GetRoomByKeyQuery.Data.GetRoomByKey.self),
            ObjectIdentifier(RoomAttrs.self)
          ]
        ))
      }

      /// GetRoomByKey.MediaInfo
      ///
      /// Parent Type: `MediaInfo`
      public struct MediaInfo: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MediaInfo }

        public var currentTimeSeconds: Double? { __data["CurrentTimeSeconds"] }
        public var durationSeconds: Double? { __data["DurationSeconds"] }
        public var source: Source? { __data["Source"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var mediaInfoAttrs: MediaInfoAttrs { _toFragment() }
        }

        public init(
          currentTimeSeconds: Double? = nil,
          durationSeconds: Double? = nil,
          source: Source? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.MediaInfo.typename,
              "CurrentTimeSeconds": currentTimeSeconds,
              "DurationSeconds": durationSeconds,
              "Source": source._fieldData,
            ],
            fulfilledFragments: [
              ObjectIdentifier(GetRoomByKeyQuery.Data.GetRoomByKey.MediaInfo.self),
              ObjectIdentifier(MediaInfoAttrs.self),
              ObjectIdentifier(RoomAttrs.MediaInfo.self)
            ]
          ))
        }

        /// GetRoomByKey.MediaInfo.Source
        ///
        /// Parent Type: `Source`
        public struct Source: SchemaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }

          public var id: String { __data["Id"] }
          public var cover: String { __data["Cover"] }
          public var name: String { __data["Name"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var sourceAttrs: SourceAttrs { _toFragment() }
          }

          public init(
            id: String,
            cover: String,
            name: String
          ) {
            self.init(_dataDict: DataDict(
              data: [
                "__typename": SchemaAPI.Objects.Source.typename,
                "Id": id,
                "Cover": cover,
                "Name": name,
              ],
              fulfilledFragments: [
                ObjectIdentifier(GetRoomByKeyQuery.Data.GetRoomByKey.MediaInfo.Source.self),
                ObjectIdentifier(SourceAttrs.self),
                ObjectIdentifier(MediaInfoAttrs.Source.self)
              ]
            ))
          }
        }
      }
    }
  }
}
