// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class RoomActionMutation: GraphQLMutation {
  public static let operationName: String = "RoomAction"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation RoomAction($arg: String, $action: String, $roomId: String) { RoomAction(Arg: $arg, Action: $action, RoomId: $roomId) }"#
    ))

  public var arg: GraphQLNullable<String>
  public var action: GraphQLNullable<String>
  public var roomId: GraphQLNullable<String>

  public init(
    arg: GraphQLNullable<String>,
    action: GraphQLNullable<String>,
    roomId: GraphQLNullable<String>
  ) {
    self.arg = arg
    self.action = action
    self.roomId = roomId
  }

  public var __variables: Variables? { [
    "arg": arg,
    "action": action,
    "roomId": roomId
  ] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("RoomAction", Bool?.self, arguments: [
        "Arg": .variable("arg"),
        "Action": .variable("action"),
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
