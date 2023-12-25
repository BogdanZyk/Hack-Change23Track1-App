// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateRoomMutation: GraphQLMutation {
  public static let operationName: String = "CreateRoom"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateRoom($name: String!, $type: RoomType, $image: String, $private: Boolean) { CreateRoom(Name: $name, Type: $type, Image: $image, Private: $private) { __typename ...RoomAttrs } }"#,
      fragments: [MediaInfoAttrs.self, RoomAttrs.self, SourceAttrs.self]
    ))

  public var name: String
  public var type: GraphQLNullable<GraphQLEnum<RoomType>>
  public var image: GraphQLNullable<String>
  public var `private`: GraphQLNullable<Bool>

  public init(
    name: String,
    type: GraphQLNullable<GraphQLEnum<RoomType>>,
    image: GraphQLNullable<String>,
    `private`: GraphQLNullable<Bool>
  ) {
    self.name = name
    self.type = type
    self.image = image
    self.`private` = `private`
  }

  public var __variables: Variables? { [
    "name": name,
    "type": type,
    "image": image,
    "private": `private`
  ] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("CreateRoom", CreateRoom?.self, arguments: [
        "Name": .variable("name"),
        "Type": .variable("type"),
        "Image": .variable("image"),
        "Private": .variable("private")
      ]),
    ] }

    public var createRoom: CreateRoom? { __data["CreateRoom"] }

    public init(
      createRoom: CreateRoom? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "CreateRoom": createRoom._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(CreateRoomMutation.Data.self)
        ]
      ))
    }

    /// CreateRoom
    ///
    /// Parent Type: `Room`
    public struct CreateRoom: SchemaAPI.SelectionSet {
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
            ObjectIdentifier(CreateRoomMutation.Data.CreateRoom.self),
            ObjectIdentifier(RoomAttrs.self)
          ]
        ))
      }

      /// CreateRoom.MediaInfo
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
              ObjectIdentifier(CreateRoomMutation.Data.CreateRoom.MediaInfo.self),
              ObjectIdentifier(MediaInfoAttrs.self),
              ObjectIdentifier(RoomAttrs.MediaInfo.self)
            ]
          ))
        }

        /// CreateRoom.MediaInfo.Source
        ///
        /// Parent Type: `Source`
        public struct Source: SchemaAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }

          public var id: String? { __data["Id"] }
          public var cover: String? { __data["Cover"] }
          public var name: String? { __data["Name"] }
          public var url: String? { __data["Url"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var sourceAttrs: SourceAttrs { _toFragment() }
          }

          public init(
            id: String? = nil,
            cover: String? = nil,
            name: String? = nil,
            url: String? = nil
          ) {
            self.init(_dataDict: DataDict(
              data: [
                "__typename": SchemaAPI.Objects.Source.typename,
                "Id": id,
                "Cover": cover,
                "Name": name,
                "Url": url,
              ],
              fulfilledFragments: [
                ObjectIdentifier(CreateRoomMutation.Data.CreateRoom.MediaInfo.Source.self),
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
