unit uTypebotResponseContinueChat;

// *************************************************
// Generated By: JsonToDelphiClass - 0.65
// Project link: https://github.com/PKGeorgiev/Delphi-JsonToDelphiClass
// Generated On: 2024-11-12 01:13:18
// *************************************************
// Created By  : Petar Georgiev - 2014
// WebSite     : http://pgeorgiev.com
// *************************************************

interface

uses Generics.Collections, Rest.Json;

type

  TScriptToExecuteClass = class
  private
    FArgs: TArray<String>;
    FContent: String;
    FIsCode: Boolean;
  public
    property args: TArray<String> read FArgs write FArgs;
    property content: String read FContent write FContent;
    property isCode: Boolean read FIsCode write FIsCode;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TScriptToExecuteClass;
  end;

  TSetVariableClass = class
  private
    FScriptToExecute: TScriptToExecuteClass;
  public
    property scriptToExecute: TScriptToExecuteClass read FScriptToExecute
      write FScriptToExecute;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSetVariableClass;
  end;

  TClientSideActionsClass = class
  private
    FExpectsDedicatedReply: Boolean;
    FLastBubbleBlockId: String;
    FSetVariable: TSetVariableClass;
    FType: String;
  public
    property expectsDedicatedReply: Boolean read FExpectsDedicatedReply
      write FExpectsDedicatedReply;
    property lastBubbleBlockId: String read FLastBubbleBlockId
      write FLastBubbleBlockId;
    property setVariable: TSetVariableClass read FSetVariable
      write FSetVariable;
    property &type: String read FType write FType;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TClientSideActionsClass;
  end;

  TOptionsClass = class
  private
    FVariableId: String;
  public
    property variableId: String read FVariableId write FVariableId;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TOptionsClass;
  end;

  TInputClass = class
  private
    FId: String;
    FOptions: TOptionsClass;
    FOutgoingEdgeId: String;
    FType: String;
    FPrefilledValue: String;
  public
    property id: String read FId write FId;
    property options: TOptionsClass read FOptions write FOptions;
    property outgoingEdgeId: String read FOutgoingEdgeId write FOutgoingEdgeId;
    property prefilledValue: String read FPrefilledValue write FPrefilledValue;
    property &type: String read FType write FType;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TInputClass;
  end;

  TChildrenClass_006 = class
  private
    FText: String;
    FType: String;
    FBold: Boolean;
  public
    property text: String read FText write FText;
    property &type: String read FType write FType;
    property bold: Boolean read FBold write FBold;
    // function ToJsonString: string;
    // class function FromJsonString(AJsonString: string): TChildrenClass_001;
  end;

  TChildrenClass_005 = class
  private
    FText: String;
    FType: String;
    FChildren: TArray<TChildrenClass_006>;
    FBold: Boolean;
  public
    property text: String read FText write FText;
    property &type: String read FType write FType;
    property children: TArray<TChildrenClass_006> read FChildren
      write FChildren;
    property bold: Boolean read FBold write FBold;
    // function ToJsonString: string;
    // class function FromJsonString(AJsonString: string): TChildrenClass_001;
  end;

  TChildrenClass_004 = class
  private
    FText: String;
    FType: String;
    FChildren: TArray<TChildrenClass_004>;
    FBold: Boolean;
  public
    property text: String read FText write FText;
    property &type: String read FType write FType;
    property children: TArray<TChildrenClass_004> read FChildren
      write FChildren;
    property bold: Boolean read FBold write FBold;
    // function ToJsonString: string;
    // class function FromJsonString(AJsonString: string): TChildrenClass_001;
  end;

  TChildrenClass_003 = class
  private
    FText: String;
    FType: String;
    FChildren: TArray<TChildrenClass_004>;
    FBold: Boolean;
  public
    property text: String read FText write FText;
    property &type: String read FType write FType;
    property children: TArray<TChildrenClass_004> read FChildren
      write FChildren;
    property bold: Boolean read FBold write FBold;
    // function ToJsonString: string;
    // class function FromJsonString(AJsonString: string): TChildrenClass_001;
  end;

  TChildrenClass_002 = class
  private
    FText: String;
    FType: String;
    FChildren: TArray<TChildrenClass_003>;
    FBold: Boolean;
  public
    property text: String read FText write FText;
    property &type: String read FType write FType;
    property children: TArray<TChildrenClass_003> read FChildren
      write FChildren;
    property bold: Boolean read FBold write FBold;
    // function ToJsonString: string;
    // class function FromJsonString(AJsonString: string): TChildrenClass_001;
  end;

  TChildrenClass_001 = class
  private
    FText: String;
    FType: String;
    FChildren: TArray<TChildrenClass_002>;
    FBold: Boolean;
  public
    property text: String read FText write FText;
    property &type: String read FType write FType;
    property children: TArray<TChildrenClass_002> read FChildren
      write FChildren;
    property bold: Boolean read FBold write FBold;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TChildrenClass_001;
  end;

  TChildrenClass = class
  private
    FText: String;
    FChildren: TArray<TChildrenClass_001>;
    FType: String;
    FBold: Boolean;
  public
    property text: String read FText write FText;
    property &type: String read FType write FType;
    property children: TArray<TChildrenClass_001> read FChildren
      write FChildren;
    property bold: Boolean read FBold write FBold;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TChildrenClass;
  end;

  TRichTextClass = class
  private
    FChildren: TArray<TChildrenClass>;
    FType: String;
  public
    property children: TArray<TChildrenClass> read FChildren write FChildren;
    property &type: String read FType write FType;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TRichTextClass;
  end;

  TContentClass = class
  private
    FRichText: TArray<TRichTextClass>;
    FType: String;
  public
    property richText: TArray<TRichTextClass> read FRichText write FRichText;
    property &type: String read FType write FType;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TContentClass;
  end;

  TMessagesClassContinueChatTypeBot = class
  private
    FContent: TContentClass;
    FId: String;
    FType: String;
  public
    property content: TContentClass read FContent write FContent;
    property id: String read FId write FId;
    property &type: String read FType write FType;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string)
      : TMessagesClassContinueChatTypeBot;
  end;

  TResultResponseContinueChatClass = class
  private
    FInput: TInputClass;
    FMessages: TArray<TMessagesClassContinueChatTypeBot>;
    FClientSideActions: TArray<TClientSideActionsClass>;
    FLogs: TArray<String>;
  public
    property input: TInputClass read FInput write FInput;
    property messages: TArray<TMessagesClassContinueChatTypeBot> read FMessages
      write FMessages;
    property clientSideActions: TArray<TClientSideActionsClass>
      read FClientSideActions write FClientSideActions;
    property logs: TArray<String> read FLogs write FLogs;

    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string)
      : TResultResponseContinueChatClass;
  end;

implementation

{ TScriptToExecuteClass }

function TScriptToExecuteClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TScriptToExecuteClass.FromJsonString(AJsonString: string)
  : TScriptToExecuteClass;
begin
  result := TJson.JsonToObject<TScriptToExecuteClass>(AJsonString)
end;

{ TSetVariableClass }

constructor TSetVariableClass.Create;
begin
  inherited;
  FScriptToExecute := TScriptToExecuteClass.Create();
end;

destructor TSetVariableClass.Destroy;
begin
  FScriptToExecute.free;
  inherited;
end;

function TSetVariableClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSetVariableClass.FromJsonString(AJsonString: string)
  : TSetVariableClass;
begin
  result := TJson.JsonToObject<TSetVariableClass>(AJsonString)
end;

{ TClientSideActionsClass }

constructor TClientSideActionsClass.Create;
begin
  inherited;
  FSetVariable := TSetVariableClass.Create();
end;

destructor TClientSideActionsClass.Destroy;
begin
  FSetVariable.free;
  inherited;
end;

function TClientSideActionsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TClientSideActionsClass.FromJsonString(AJsonString: string)
  : TClientSideActionsClass;
begin
  result := TJson.JsonToObject<TClientSideActionsClass>(AJsonString)
end;

{ TOptionsClass }

function TOptionsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TOptionsClass.FromJsonString(AJsonString: string): TOptionsClass;
begin
  result := TJson.JsonToObject<TOptionsClass>(AJsonString)
end;

{ TInputClass }

constructor TInputClass.Create;
begin
  inherited;
  FOptions := TOptionsClass.Create();
end;

destructor TInputClass.Destroy;
begin
  FOptions.free;
  inherited;
end;

function TInputClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TInputClass.FromJsonString(AJsonString: string): TInputClass;
begin
  result := TJson.JsonToObject<TInputClass>(AJsonString)
end;

{ TChildrenClass_001 }

function TChildrenClass_001.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TChildrenClass_001.FromJsonString(AJsonString: string)
  : TChildrenClass_001;
begin
  result := TJson.JsonToObject<TChildrenClass_001>(AJsonString)
end;

{ TChildrenClass }

function TChildrenClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TChildrenClass.FromJsonString(AJsonString: string)
  : TChildrenClass;
begin
  result := TJson.JsonToObject<TChildrenClass>(AJsonString)
end;

{ TRichTextClass }

destructor TRichTextClass.Destroy;
var
  LchildrenItem: TChildrenClass;
begin

  for LchildrenItem in FChildren do
    LchildrenItem.free;

  inherited;
end;

function TRichTextClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRichTextClass.FromJsonString(AJsonString: string)
  : TRichTextClass;
begin
  result := TJson.JsonToObject<TRichTextClass>(AJsonString)
end;

{ TContentClass }

destructor TContentClass.Destroy;
var
  LrichTextItem: TRichTextClass;
begin

  for LrichTextItem in FRichText do
    LrichTextItem.free;

  inherited;
end;

function TContentClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TContentClass.FromJsonString(AJsonString: string): TContentClass;
begin
  result := TJson.JsonToObject<TContentClass>(AJsonString)
end;

{ TMessagesClassContinueChatTypeBot }

constructor TMessagesClassContinueChatTypeBot.Create;
begin
  inherited;
  FContent := TContentClass.Create();
end;

destructor TMessagesClassContinueChatTypeBot.Destroy;
begin
  FContent.free;
  inherited;
end;

function TMessagesClassContinueChatTypeBot.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TMessagesClassContinueChatTypeBot.FromJsonString
  (AJsonString: string): TMessagesClassContinueChatTypeBot;
begin
  result := TJson.JsonToObject<TMessagesClassContinueChatTypeBot>(AJsonString)
end;

{ TResultResponseContinueChatClass }

constructor TResultResponseContinueChatClass.Create;
begin
  inherited;
  FInput := TInputClass.Create();
end;

destructor TResultResponseContinueChatClass.Destroy;
var
  LmessagesItem: TMessagesClassContinueChatTypeBot;
begin

  for LmessagesItem in FMessages do
    LmessagesItem.free;

  FInput.free;
  inherited;
end;

function TResultResponseContinueChatClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TResultResponseContinueChatClass.FromJsonString
  (AJsonString: string): TResultResponseContinueChatClass;
begin
  result := TJson.JsonToObject<TResultResponseContinueChatClass>(AJsonString)
end;

end.
