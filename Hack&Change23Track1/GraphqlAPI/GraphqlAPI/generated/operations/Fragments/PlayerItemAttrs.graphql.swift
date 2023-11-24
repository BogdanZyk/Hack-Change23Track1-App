// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
import Hack&Change23Track1&

struct PlayerItemAttrs: SchemaAPI.SelectionSet, Fragment {
  static var fragmentDefinition: StaticString {
    #"fragment PlayerItemAttrs on PlayFile { __typename CurrentSeconds DurationSeconds File { __typename ...FileAttrs } Pause }"#
  }

  let __data: DataDict
  init(_dataDict: DataDict) { __data = _dataDict }

  static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PlayFile }
  static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("CurrentSeconds", String?.self),
    .field("DurationSeconds", String?.self),
    .field("File", File?.self),
    .field("Pause", Bool?.self),
  ] }

  var currentSeconds: String? { __data["CurrentSeconds"] }
  var durationSeconds: String? { __data["DurationSeconds"] }
  var file: File? { __data["File"] }
  var pause: Bool? { __data["Pause"] }

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
        ObjectIdentifier(PlayerItemAttrs.self)
      ]
    ))
  }

  /// File
  ///
  /// Parent Type: `Audio`
  struct File: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Audio }
    static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(FileAttrs.self),
    ] }

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
          ObjectIdentifier(PlayerItemAttrs.File.self),
          ObjectIdentifier(FileAttrs.self)
        ]
      ))
    }
  }
}
