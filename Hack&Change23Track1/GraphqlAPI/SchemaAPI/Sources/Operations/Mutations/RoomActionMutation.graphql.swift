// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class RoomActionMutation: GraphQLMutation {
  public static let operationName: String = "RoomAction"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation RoomAction($action: MediaAction, $arg: String, $roomId: String) { RoomAction(Action: $action, Arg: $arg, RoomId: $roomId) }"#
    ))

  public var action: GraphQLNullable<GraphQLEnum<MediaAction>>
  public var arg: GraphQLNullable<String>
  public var roomId: GraphQLNullable<String>

  public init(
    action: GraphQLNullable<GraphQLEnum<MediaAction>>,
    arg: GraphQLNullable<String>,
    roomId: GraphQLNullable<String>
  ) {
    self.action = action
    self.arg = arg
    self.roomId = roomId
  }

  public var __variables: Variables? { [
    "action": action,
    "arg": arg,
    "roomId": roomId
  ] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("RoomAction", Bool?.self, arguments: [
        "Action": .variable("action"),
        "Arg": .variable("arg"),
        "RoomId": .variable("roomId")
      ]),
    ] }

    public var roomAction: Bool? { __data["RoomAction"] }

    public init(
      roomAction: Bool? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "RoomAction": roomAction,
        ],
        fulfilledFragments: [
          ObjectIdentifier(RoomActionMutation.Data.self)
        ]
      ))
    }
  }
}
