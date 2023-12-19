// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class CreateRoomMutation: GraphQLMutation {
  static let operationName: String = "CreateRoom"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateRoom($name: String!, $type: RoomType, $image: String, $private: Boolean) { CreateRoom(Name: $name, Type: $type, Image: $image, Private: $private) { __typename ...RoomAttrs } }"#,
      fragments: [RoomAttrs.self, MediaInfoAttrs.self, SourceAttrs.self]
    ))

  public var name: String
  public var type: GraphQLNullable<GraphQLEnum<SchemaAPI.RoomType>>
  public var image: GraphQLNullable<String>
  public var `private`: GraphQLNullable<Bool>

  public init(
    name: String,
    type: GraphQLNullable<GraphQLEnum<SchemaAPI.RoomType>>,
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

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("CreateRoom", CreateRoom?.self, arguments: [
        "Name": .variable("name"),
        "Type": .variable("type"),
        "Image": .variable("image"),
        "Private": .variable("private")
      ]),
    ] }

    var createRoom: CreateRoom? { __data["CreateRoom"] }

    init(
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
    struct CreateRoom: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Room }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(RoomAttrs.self),
      ] }

      var mediaInfo: MediaInfo? { __data["MediaInfo"] }
      var id: String? { __data["Id"] }
      var likes: Int? { __data["Likes"] }
      var `private`: Bool? { __data["Private"] }
      var image: String? { __data["Image"] }
      var key: String? { __data["Key"] }
      var name: String? { __data["Name"] }
      var owner: RoomAttrs.Owner? { __data["Owner"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var roomAttrs: RoomAttrs { _toFragment() }
      }

      init(
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
      struct MediaInfo: SchemaAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MediaInfo }

        var currentTimeSeconds: Double? { __data["CurrentTimeSeconds"] }
        var durationSeconds: Double? { __data["DurationSeconds"] }
        var source: Source? { __data["Source"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var mediaInfoAttrs: MediaInfoAttrs { _toFragment() }
        }

        init(
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
        struct Source: SchemaAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }

          var id: String { __data["Id"] }
          var cover: String { __data["Cover"] }
          var name: String { __data["Name"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            var sourceAttrs: SourceAttrs { _toFragment() }
          }

          init(
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
