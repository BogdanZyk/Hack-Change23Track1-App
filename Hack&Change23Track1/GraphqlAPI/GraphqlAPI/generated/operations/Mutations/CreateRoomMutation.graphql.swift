// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class CreateRoomMutation: GraphQLMutation {
  static let operationName: String = "CreateRoom"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateRoom($name: String!, $type: RoomType, $image: String, $private: Boolean) { CreateRoom(Name: $name, Type: $type, Image: $image, Private: $private) { __typename ...RoomAttrs } }"#,
      fragments: [RoomAttrs.self, PlayerItemAttrs.self, FileAttrs.self, UserAttrs.self]
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

      var file: File? { __data["File"] }
      var playlist: [Playlist?]? { __data["Playlist"] }
      var id: String? { __data["Id"] }
      var likes: Int? { __data["Likes"] }
      var `private`: Bool? { __data["Private"] }
      var image: String? { __data["Image"] }
      var key: String? { __data["Key"] }
      var name: String? { __data["Name"] }
      var members: [Member?]? { __data["Members"] }
      var owner: RoomAttrs.Owner? { __data["Owner"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var roomAttrs: RoomAttrs { _toFragment() }
      }

      init(
        file: File? = nil,
        playlist: [Playlist?]? = nil,
        id: String? = nil,
        likes: Int? = nil,
        `private`: Bool? = nil,
        image: String? = nil,
        key: String? = nil,
        name: String? = nil,
        members: [Member?]? = nil,
        owner: RoomAttrs.Owner? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.Room.typename,
            "File": file._fieldData,
            "Playlist": playlist._fieldData,
            "Id": id,
            "Likes": likes,
            "Private": `private`,
            "Image": image,
            "Key": key,
            "Name": name,
            "Members": members._fieldData,
            "Owner": owner._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(CreateRoomMutation.Data.CreateRoom.self),
            ObjectIdentifier(RoomAttrs.self)
          ]
        ))
      }

      /// CreateRoom.File
      ///
      /// Parent Type: `PlayFile`
      struct File: SchemaAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PlayFile }

        var currentSeconds: String? { __data["CurrentSeconds"] }
        var durationSeconds: String? { __data["DurationSeconds"] }
        var file: File? { __data["File"] }
        var pause: Bool? { __data["Pause"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var playerItemAttrs: PlayerItemAttrs { _toFragment() }
        }

        init(
          currentSeconds: String? = nil,
          durationSeconds: String? = nil,
          file: File? = nil,
          pause: Bool? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.PlayFile.typename,
              "CurrentSeconds": currentSeconds,
              "DurationSeconds": durationSeconds,
              "File": file._fieldData,
              "Pause": pause,
            ],
            fulfilledFragments: [
              ObjectIdentifier(CreateRoomMutation.Data.CreateRoom.File.self),
              ObjectIdentifier(PlayerItemAttrs.self),
              ObjectIdentifier(RoomAttrs.File.self)
            ]
          ))
        }

        /// CreateRoom.File.File
        ///
        /// Parent Type: `Audio`
        struct File: SchemaAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Audio }

          var id: String? { __data["Id"] }
          var name: String? { __data["Name"] }
          var cover: String? { __data["Cover"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            var fileAttrs: FileAttrs { _toFragment() }
          }

          init(
            id: String? = nil,
            name: String? = nil,
            cover: String? = nil
          ) {
            self.init(_dataDict: DataDict(
              data: [
                "__typename": SchemaAPI.Objects.Audio.typename,
                "Id": id,
                "Name": name,
                "Cover": cover,
              ],
              fulfilledFragments: [
                ObjectIdentifier(CreateRoomMutation.Data.CreateRoom.File.File.self),
                ObjectIdentifier(FileAttrs.self),
                ObjectIdentifier(PlayerItemAttrs.File.self)
              ]
            ))
          }
        }
      }

      /// CreateRoom.Playlist
      ///
      /// Parent Type: `Audio`
      struct Playlist: SchemaAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Audio }

        var id: String? { __data["Id"] }
        var name: String? { __data["Name"] }
        var cover: String? { __data["Cover"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var fileAttrs: FileAttrs { _toFragment() }
        }

        init(
          id: String? = nil,
          name: String? = nil,
          cover: String? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.Audio.typename,
              "Id": id,
              "Name": name,
              "Cover": cover,
            ],
            fulfilledFragments: [
              ObjectIdentifier(CreateRoomMutation.Data.CreateRoom.Playlist.self),
              ObjectIdentifier(FileAttrs.self),
              ObjectIdentifier(RoomAttrs.Playlist.self)
            ]
          ))
        }
      }

      /// CreateRoom.Member
      ///
      /// Parent Type: `User`
      struct Member: SchemaAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }

        var id: String { __data["Id"] }
        var login: String { __data["Login"] }
        var avatar: String { __data["Avatar"] }
        var email: String { __data["Email"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var userAttrs: UserAttrs { _toFragment() }
        }

        init(
          id: String,
          login: String,
          avatar: String,
          email: String
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.User.typename,
              "Id": id,
              "Login": login,
              "Avatar": avatar,
              "Email": email,
            ],
            fulfilledFragments: [
              ObjectIdentifier(CreateRoomMutation.Data.CreateRoom.Member.self),
              ObjectIdentifier(UserAttrs.self),
              ObjectIdentifier(RoomAttrs.Member.self)
            ]
          ))
        }
      }
    }
  }
}
