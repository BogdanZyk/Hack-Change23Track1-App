// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
import Hack&Change23Track1

class UpdateRoomMutation: GraphQLMutation {
  static let operationName: String = "UpdateRoom"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateRoom($roomId: String!, $image: String, $private: Boolean, $type: RoomType, $name: String) { UpdateRoom( RoomId: $roomId Image: $image Private: $private Type: $type Name: $name ) { __typename ...RoomAttrs } }"#,
      fragments: [RoomAttrs.self, PlayerItemAttrs.self, FileAttrs.self, UserAttrs.self]
    ))

  public var roomId: String
  public var image: GraphQLNullable<String>
  public var `private`: GraphQLNullable<Bool>
  public var type: GraphQLNullable<GraphQLEnum<SchemaAPI.RoomType>>
  public var name: GraphQLNullable<String>

  public init(
    roomId: String,
    image: GraphQLNullable<String>,
    `private`: GraphQLNullable<Bool>,
    type: GraphQLNullable<GraphQLEnum<SchemaAPI.RoomType>>,
    name: GraphQLNullable<String>
  ) {
    self.roomId = roomId
    self.image = image
    self.`private` = `private`
    self.type = type
    self.name = name
  }

  public var __variables: Variables? { [
    "roomId": roomId,
    "image": image,
    "private": `private`,
    "type": type,
    "name": name
  ] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("UpdateRoom", UpdateRoom?.self, arguments: [
        "RoomId": .variable("roomId"),
        "Image": .variable("image"),
        "Private": .variable("private"),
        "Type": .variable("type"),
        "Name": .variable("name")
      ]),
    ] }

    var updateRoom: UpdateRoom? { __data["UpdateRoom"] }

    init(
      updateRoom: UpdateRoom? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "UpdateRoom": updateRoom._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(UpdateRoomMutation.Data.self)
        ]
      ))
    }

    /// UpdateRoom
    ///
    /// Parent Type: `Room`
    struct UpdateRoom: SchemaAPI.SelectionSet {
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
            ObjectIdentifier(UpdateRoomMutation.Data.UpdateRoom.self),
            ObjectIdentifier(RoomAttrs.self)
          ]
        ))
      }

      /// UpdateRoom.File
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
              ObjectIdentifier(UpdateRoomMutation.Data.UpdateRoom.File.self),
              ObjectIdentifier(PlayerItemAttrs.self),
              ObjectIdentifier(RoomAttrs.File.self)
            ]
          ))
        }

        /// UpdateRoom.File.File
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
                ObjectIdentifier(UpdateRoomMutation.Data.UpdateRoom.File.File.self),
                ObjectIdentifier(FileAttrs.self),
                ObjectIdentifier(PlayerItemAttrs.File.self)
              ]
            ))
          }
        }
      }

      /// UpdateRoom.Playlist
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
              ObjectIdentifier(UpdateRoomMutation.Data.UpdateRoom.Playlist.self),
              ObjectIdentifier(FileAttrs.self),
              ObjectIdentifier(RoomAttrs.Playlist.self)
            ]
          ))
        }
      }

      /// UpdateRoom.Member
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
              ObjectIdentifier(UpdateRoomMutation.Data.UpdateRoom.Member.self),
              ObjectIdentifier(UserAttrs.self),
              ObjectIdentifier(RoomAttrs.Member.self)
            ]
          ))
        }
      }
    }
  }
}
