// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
import Hack&Change23Track1&

struct RoomAttrs: SchemaAPI.SelectionSet, Fragment {
  static var fragmentDefinition: StaticString {
    #"fragment RoomAttrs on Room { __typename File { __typename ...PlayerItemAttrs } Id Likes Name Members { __typename ...UserAttrs } Owner { __typename Id } }"#
  }

  let __data: DataDict
  init(_dataDict: DataDict) { __data = _dataDict }

  static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Room }
  static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("File", File?.self),
    .field("Id", String?.self),
    .field("Likes", Int?.self),
    .field("Name", String?.self),
    .field("Members", [Member?]?.self),
    .field("Owner", Owner?.self),
  ] }

  var file: File? { __data["File"] }
  var id: String? { __data["Id"] }
  var likes: Int? { __data["Likes"] }
  var name: String? { __data["Name"] }
  var members: [Member?]? { __data["Members"] }
  var owner: Owner? { __data["Owner"] }

  init(
    file: File? = nil,
    id: String? = nil,
    likes: Int? = nil,
    name: String? = nil,
    members: [Member?]? = nil,
    owner: Owner? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.Room.typename,
        "File": file._fieldData,
        "Id": id,
        "Likes": likes,
        "Name": name,
        "Members": members._fieldData,
        "Owner": owner._fieldData,
      ],
      fulfilledFragments: [
        ObjectIdentifier(RoomAttrs.self)
      ]
    ))
  }

  /// File
  ///
  /// Parent Type: `PlayFile`
  struct File: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PlayFile }
    static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(PlayerItemAttrs.self),
    ] }

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
          ObjectIdentifier(RoomAttrs.File.self),
          ObjectIdentifier(PlayerItemAttrs.self)
        ]
      ))
    }

    /// File.File
    ///
    /// Parent Type: `Audio`
    struct File: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Audio }

      var id: String? { __data["Id"] }
      var name: String? { __data["Name"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var fileAttrs: FileAttrs { _toFragment() }
      }

      init(
        id: String? = nil,
        name: String? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.Audio.typename,
            "Id": id,
            "Name": name,
          ],
          fulfilledFragments: [
            ObjectIdentifier(RoomAttrs.File.File.self),
            ObjectIdentifier(FileAttrs.self),
            ObjectIdentifier(PlayerItemAttrs.File.self)
          ]
        ))
      }
    }
  }

  /// Member
  ///
  /// Parent Type: `User`
  struct Member: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }
    static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(UserAttrs.self),
    ] }

    var id: String { __data["Id"] }
    var login: String { __data["Login"] }
    var avatar: String { __data["Avatar"] }

    struct Fragments: FragmentContainer {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      var userAttrs: UserAttrs { _toFragment() }
    }

    init(
      id: String,
      login: String,
      avatar: String
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.User.typename,
          "Id": id,
          "Login": login,
          "Avatar": avatar,
        ],
        fulfilledFragments: [
          ObjectIdentifier(RoomAttrs.Member.self),
          ObjectIdentifier(UserAttrs.self)
        ]
      ))
    }
  }

  /// Owner
  ///
  /// Parent Type: `User`
  struct Owner: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }
    static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("Id", String.self),
    ] }

    var id: String { __data["Id"] }

    init(
      id: String
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.User.typename,
          "Id": id,
        ],
        fulfilledFragments: [
          ObjectIdentifier(RoomAttrs.Owner.self)
        ]
      ))
    }
  }
}
